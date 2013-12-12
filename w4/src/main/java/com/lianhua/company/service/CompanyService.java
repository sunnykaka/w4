package com.lianhua.company.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.lianhua.W4Application;
import com.lianhua.area.model.Area;
import com.lianhua.area.service.AreaService;
import com.lianhua.code.model.Code;
import com.lianhua.code.service.CodeService;
import com.lianhua.common.excel.ExcelReader;
import com.lianhua.common.excel.ExcelTemplate;
import com.lianhua.common.util.ImportResult;
import com.lianhua.common.web.WebHolder;
import com.lianhua.company.dao.CompanyDao;
import com.lianhua.company.model.Company;
import com.lianhua.company.model.EnumCompanyApproveState;
import com.lianhua.company.model.EnumCompanyOperation;
import com.lianhua.company.model.EnumCompanyState;
import com.lianhua.company.util.CompanyImportVO;
import com.lianhua.contact.dao.ContactDao;
import com.lianhua.contact.model.Contact;
import com.lianhua.declaration.model.Declaration;
import com.lianhua.declaration.model.EnumApprovalReason;
import com.lianhua.declaration.model.EnumApprovalState;
import com.lianhua.declaration.model.EnumApprovalStep;
import com.lianhua.declaration.model.EnumDeclarationState;
import com.lianhua.declaration.service.ApprovalService;
import com.lianhua.document.model.Document;
import com.lianhua.document.model.DocumentDescriptor;
import com.lianhua.document.model.Property;
import com.lianhua.document.util.PropertyDescriptor;
import com.lianhua.permission.util.PermissionUtil;
import com.lianhua.user.model.User;
import com.lianhua.user.service.UserService;
import com.rootrip.platform.Platform;
import com.rootrip.platform.common.dao.Page;
import com.rootrip.platform.exception.AppException;
import com.rootrip.platform.exception.BusinessException;
import com.rootrip.platform.genericdao.search.Filter;
import com.rootrip.platform.genericdao.search.Search;
import com.rootrip.platform.id.IdGenerator;
import com.rootrip.platform.util.EntityUtil;

@Service
public class CompanyService {
	
	protected final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private CompanyDao companyDao;

	@Autowired
	private ContactDao contactDao;

	@Autowired
	private UserService userService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private ApprovalService approvalService;
	
	@Autowired
	private IdGenerator idGenerator;
	
	@Autowired
	private AreaService areaService;

	private W4Application app = (W4Application)Platform.getInstance().getApp();

	public Company get(Long id) {
		return companyDao.get(id);
	}

	@Transactional(readOnly = true)
	public List<Company> findByKey(Map<String, String[]> paramMap, Page page) {
		Search search = new Search().addSortDesc("operator.addTime").setPagination(page);
		//区管理员只能查看自己区的数据
		if(PermissionUtil.isCountyManager()) {
			search.addFilter(Filter.equal("contact.countyId", WebHolder.getUser().getAreaId()));
		}
		//列出当前直报年度的记录
		search.addFilter(Filter.equal("year", WebHolder.getUser().getCurrentYear()));

		if(paramMap.containsKey("codeOrName") && paramMap.get("codeOrName").length > 0) {
			String codeOrName = paramMap.get("codeOrName")[0];
			if(!StringUtils.isBlank(codeOrName)) {
				search.addFilter(Filter.or(Filter.like("code", "%" + codeOrName + "%"), Filter.like("name", "%" + codeOrName + "%")));
			}
		}
		if(paramMap.containsKey("approveState") && paramMap.get("approveState").length > 0) {
			String approveState = paramMap.get("approveState")[0];
			if(!"-1".equals(approveState)) {
				search.addFilter(Filter.equal("approveState", Integer.parseInt(approveState)));
			}
		}
		if(paramMap.containsKey("state") && paramMap.get("state").length > 0) {
			String state = paramMap.get("state")[0];
			if(!"-1".equals(state)) {
				search.addFilter(Filter.equal("state", Integer.parseInt(state)));
			}
		}
		if(paramMap.containsKey("countyId") && paramMap.get("countyId").length > 0) {
			String county = paramMap.get("countyId")[0];
			if(!"-1".equals(county)) {
				search.addFilter(Filter.equal("contact.countyId", Long.parseLong(county)));
			}
		}

		return companyDao.search(search);
	}

	/**
	 * 保存企业,这是由管理员录入企业的时候调用
	 * @param company
	 * @param contact
	 * @param commit
	 * @throws AppException
	 */
	@Transactional(rollbackFor={RuntimeException.class, AppException.class})
	public void saveCompany(Company company, Contact contact, Boolean commit) throws AppException {
		if(PermissionUtil.isEnterprise()) {
			throw new AppException("没有操作权限");
		}
		
		contactDao.save(contact);

		boolean isCreate = EntityUtil.isCreate(company);
		if(isCreate) {
			company.setContactId(contact.getId());
			company.setContact(contact);
			User user = userService.createUser(company, app.getCurrentDeclarationYear());
			company.setUserId(user.getId());
			company.setOperation(EnumCompanyOperation.NEW.value);
			company.setState(EnumCompanyState.TEMP.value);
			//设置当前直报年度
			company.setYear(app.getCurrentDeclarationYear());
			companyDao.save(company);
		} else {
			if(!isCompanyUpdatable(WebHolder.getUser(), company.getId())) {
				throw new AppException("不允许对该单位资料进行编辑");
			}
			//保存企业资料的时候确保所在县与会员里的一致
			User user = company.getUser();
			user.setAreaId(company.getContact().getCountyId());
			userService.save(user);
		}

		if(commit == null || !commit) {
			if(isCreate) {
				//保存不提交
				company.setApproveState(EnumCompanyApproveState.UNCOMMIT.value);
			}
		} else if(!EnumCompanyOperation.DELETE.value.equals(company.getOperation())){
			//如果是删除审批操作,则提交企业资料不影响审批状态
			//提交
			if(isCreate || EnumCompanyApproveState.UNCOMMIT.value.equals(company.getApproveState())
					|| EnumCompanyApproveState.BACK.value.equals(company.getApproveState())) {
				if(PermissionUtil.isCountyManager()) {
					//如果是区管理员录入的,则需要审核
					company.setApproveState(EnumCompanyApproveState.APPROVING.value);
					approvalService.createCompanyAppvoval(company.getId(), EnumApprovalState.COMMIT,
							EnumApprovalStep.COUNTY_APPROVE, null, EnumApprovalReason.ENTERPRISE_INPUT.label);
				} else {
					company.setState(EnumCompanyState.NORMAL.value);
					company.setApproveState(EnumCompanyApproveState.APPROVED.value);
				}
			}
		}

		WebHolder.fillOperatorValues(company);


		companyDao.save(company);
	}

	@Transactional(readOnly = true)
	public Company getByUserAndYear(Long userId, Integer currentDeclarationYear) {
		Search search = new Search();
		search.addFilter(Filter.equal("userId", userId)).addFilter(Filter.equal("year", currentDeclarationYear));
		return companyDao.searchUnique(search);
	}

	/**
	 * 修改单位资料,这是直报企业修改自己单位资料的时候调用
	 * @param company
	 * @param contact
	 * @throws AppException
	 */
	@Transactional
	public void saveMyCompany(Company company, Contact contact) throws AppException {
		
		contactDao.save(contact);
		Long currentUserId = WebHolder.getUser().getId();
		if(EntityUtil.isCreate(company)) {
			company.setContactId(contact.getId());
			company.setUserId(currentUserId);
			company.setState(EnumCompanyState.TEMP.value);
			company.setApproveState(EnumCompanyApproveState.APPROVING.value);
			company.setOperation(EnumCompanyOperation.NEW.value);
			//设置当前直报年度
			company.setYear(app.getCurrentDeclarationYear());
		} else {
			if(!isCompanyUpdatable(WebHolder.getUser(), company.getId())) {
				throw new AppException("不允许对该单位资料进行编辑");
			}
		}
		company.setConfirmed(true);

		//保存企业资料的时候确保所在县与会员里的一致
		User user = WebHolder.getUser();
		user.setAreaId(contact.getCountyId());
		userService.save(user);
		WebHolder.fillOperatorValues(company);
		companyDao.save(company);
	}

	/**
	 * 当前用户能否对这个企业数据进行编辑
	 * @param currentUser
	 * @param companyId
	 * @return
	 */
	@Transactional(readOnly = true)
	public boolean isCompanyUpdatable(User currentUser, Long companyId) {
		if(companyId == null || companyId.equals(0L)) return true;
		Company company = get(companyId);
		if(!app.getCurrentDeclarationYear().equals(company.getYear())) {
			//不在当前直报年度,不能编辑
			return false;
		}
		if(!app.isCurrentDeclarationYearOpening()) {
			//当前年度直报已关闭,不能编辑
			return false;
		}
		EnumCompanyApproveState approveState = EnumCompanyApproveState.valueOf(company.getApproveState());
		EnumCompanyState state = EnumCompanyState.valueOf(company.getState());
		if(PermissionUtil.isEnterprise(currentUser)) {
			//如果是企业用户
			if(!currentUser.getId().equals(company.getUserId())) {
				//只能编辑自己的
				return false;
			}
//			if(EnumCompanyApproveState.APPROVING.equals(approveState) || EnumCompanyApproveState.APPROVED.equals(approveState)) {
//				//正在审核和已经审核的,不能编辑
//				return false;
//			}
			if(EnumCompanyState.DELETED.equals(state)) {
				//已经删除的,不能编辑
				return false;
			}
			Declaration declaration = company.getDeclaration();
			if(declaration != null) {
				EnumDeclarationState declarationState = EnumDeclarationState.valueOf(declaration.getState());
				if(EnumDeclarationState.APPROVED.equals(declarationState) || EnumDeclarationState.APPROVING.equals(declarationState) 
						|| EnumDeclarationState.COUNTY_APPROVING.equals(declarationState)) {
					//当直报数据正在审批,或者审批通过的时候,企业不能编辑自己资料
					return false;
				}
			}
		} else if(PermissionUtil.isCountyManager(currentUser) || PermissionUtil.isCityManager(currentUser)) {
			//如果是区或市用户
			if(EnumCompanyState.DELETED.equals(state)) {
				//已经删除,不能编辑
				return false;
			}
		}

		return true;
	}

	/**
	 * 当前用户能否对这个企业资料进行审核
	 * @param currentUser
	 * @param companyId
	 * @return
	 */
	@Transactional(readOnly = true)
	public boolean isCompanyApprovable(User currentUser, Long companyId) {
		if(companyId == null || companyId.equals(0L)) return true;
		Company company = get(companyId);
		if(!app.getCurrentDeclarationYear().equals(company.getYear())) {
			//不在当前直报年度,不能审核
			return false;
		}
		if(!app.isCurrentDeclarationYearOpening()) {
			//当前年度直报已关闭,不能审核
			return false;
		}
		EnumCompanyApproveState approveState = EnumCompanyApproveState.valueOf(company.getApproveState());
		EnumCompanyState state = EnumCompanyState.valueOf(company.getState());
		if(PermissionUtil.isEnterprise(currentUser) || PermissionUtil.isCountyManager(currentUser)) {
			return false;
		} else if( PermissionUtil.isCityManager(currentUser)) {
			if(approveState.equals(EnumCompanyApproveState.APPROVING)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 审核企业资料
	 * @param company
	 * @param back
	 * @param comment
	 * @throws AppException
	 */
	@Transactional
	public void approve(Company company, Boolean back, String comment) throws AppException {
		if(!isCompanyApprovable(WebHolder.getUser(), company.getId())) {
			throw new AppException("当前不允许审核该企业资料");
		}
		EnumApprovalState approvalState = null;
		EnumApprovalReason approvalReason = null;
		if(back != null && back) {
			//退回
			company.setApproveState(EnumCompanyApproveState.BACK.value);
			approvalState = EnumApprovalState.BACK;
			if(EnumCompanyOperation.DELETE.value.equals(company.getOperation())) {
				approvalReason = EnumApprovalReason.ENTERPRISE_DELETE;
			} else {
				approvalReason = EnumApprovalReason.ENTERPRISE_INPUT;
			}
		} else {
			//审核通过
			company.setApproveState(EnumCompanyApproveState.APPROVED.value);
			approvalState = EnumApprovalState.APPROVED;
			if(EnumCompanyOperation.DELETE.value.equals(company.getOperation())) {
				company.setState(EnumCompanyState.DELETED.value);
				approvalReason = EnumApprovalReason.ENTERPRISE_DELETE;
			} else {
				company.setState(EnumCompanyState.NORMAL.value);
				approvalReason = EnumApprovalReason.ENTERPRISE_INPUT;
			}
		}
		approvalService.createCompanyAppvoval(company.getId(), approvalState,
				 EnumApprovalStep.CITY_APPROVE, comment, approvalReason.label);
	}

	/**
	 * 将企业资料从名录库删除
	 * @param company
	 */
	@Transactional
	public void deleteCompany(Company company) throws AppException {
		if(!EnumCompanyState.NORMAL.value.equals(company.getState()) || PermissionUtil.isEnterprise()) {
			throw new AppException("暂时不允许删除该企业资料");
		}
		if(!EnumCompanyOperation.DELETE.value.equals(company.getOperation()) ||
				EnumCompanyApproveState.BACK.value.equals(company.getApproveState())) {
			//防止重复删除
			company.setOperation(EnumCompanyOperation.DELETE.value);
			if(PermissionUtil.isCountyManager()) {
				company.setApproveState(EnumCompanyApproveState.APPROVING.value);
				approvalService.createCompanyAppvoval(company.getId(), EnumApprovalState.COMMIT,
						EnumApprovalStep.COUNTY_APPROVE, null, EnumApprovalReason.ENTERPRISE_DELETE.label);
			} else {
				company.setState(EnumCompanyState.DELETED.value);
				company.setApproveState(EnumCompanyApproveState.APPROVED.value);
			}
		}
		companyDao.save(company);
	}

	/**
	 * 设置企业是否是重点调查企业
	 * @param company
	 * @param isMajorInquiry
	 */
	@Transactional
	public void setMajorInquiry(Company company, boolean isMajorInquiry) {
		company.setMajorInquiry(isMajorInquiry);
		companyDao.save(company);
	}
	
	@Transactional(readOnly = true)
	public boolean isCodeExist(String code, Long companyId, Integer year) {
		List<Company> companies = companyDao.search(new Search()
			.addFilter(Filter.equal("code", code))
			.addFilter(Filter.notEqual("id", companyId)));
		if(companies.isEmpty()) return false;
		for(Company c : companies) {
			if(c.getYear().equals(year)) {
				return true;
			}
		}
		return false;
	}
	
	@Transactional(readOnly = true)
	public Company getByCodeAndYear(String code, Integer year) {
		Search search = new Search();
		search.addFilter(Filter.equal("code", code)).addFilter(Filter.equal("year", year));
		return companyDao.searchUnique(search);
	}

	@Transactional
	public ImportResult importCompany(MultipartFile excelFile) {
		Integer year = app.getCurrentDeclarationYear();
		if(year == null) {
			throw new BusinessException("请先设置当前直报年度");
		}
		ExcelReader reader = new ExcelReader();
		Area city = areaService.getByName("深圳市");
		try {
			ImportResult importResult = new ImportResult();
			// 读取所有excel中预算的数据
			List<String[]> datas = reader.read(excelFile.getInputStream(), 0, 0, 0);
			List<String[]> wrongDatas = new ArrayList<>();
			List<String> wrongInfos = new ArrayList<>();
			int successNum = 0;
			int totalNum = 0;
			if(!datas.isEmpty()) {
				for (int i = 1; i < datas.size(); i++) {
					String[] cells = datas.get(i);
					if(cells == null || cells.length < 2 || StringUtils.isBlank(cells[0]) || StringUtils.isBlank(cells[1])) {
						continue;
					}
					totalNum ++;
					CompanyImportVO vo = CompanyImportVO.forRow(cells);
					if(StringUtils.isBlank(vo.getCode())) {
						wrongInfos.add("组织机构代码不能为空");
						wrongDatas.add(cells);
						continue;
					}
					if(StringUtils.isBlank(vo.getName())) {
						wrongInfos.add("单位名称不能为空");
						wrongDatas.add(cells);
						continue;
					}
					Company company = getByCodeAndYear(vo.getCode(), year);
					Contact contact = null;
					boolean isCreate = false;
					if(company == null) {
						isCreate = true;
						company = new Company();
						company.setCode(vo.getCode());
						contact = new Contact();
						contact.setId(idGenerator.nextId(Contact.class));
						company.setContactId(contact.getId());
						company.setContact(contact);
						company.setOperation(EnumCompanyOperation.NEW.value);
						company.setState(EnumCompanyState.NORMAL.value);
						company.setApproveState(EnumCompanyApproveState.APPROVED.value);						
						//设置当前直报年度
						company.setYear(year);
					} else {
						contact = company.getContact();
					}
					company.setName(vo.getName());
					contact.setCityId(city.getId());
					if(!StringUtils.isBlank(vo.getCounty())) {
						if(!vo.getCounty().endsWith("区")) {
							vo.setCounty(vo.getCounty() + "区");
						}
						Area county = areaService.getByName(vo.getCounty());
						if(county == null) {
							wrongInfos.add("您填写的区域信息不正确");
							wrongDatas.add(cells);
							continue;
						}
						contact.setCountyId(county.getId());
					}
					contact.setLocation(vo.getLocation());
					contact.setAreaCode(vo.getAreaCode());
					contact.setPhone(vo.getPhone());
					contact.setPhoneExt(vo.getPhoneExt());
					contact.setEmail(vo.getEmail());
					contact.setZipCode(vo.getZipCode());
					contact.setWebsite(vo.getWebsite());
					
					if(!StringUtils.isBlank(vo.getBusinessType()) && (Boolean.valueOf(vo.getBusinessType()) 
							|| "是".equals(vo.getBusinessType()) || "主营".equals(vo.getBusinessType()))) {
						company.setBusinessTypeCode(codeService.getCodeByKindAndDisplayName(CodeService.COMPANY_BUSINESS_TYPE, "主营").getId());
					} else {
						company.setBusinessTypeCode(codeService.getCodeByKindAndDisplayName(CodeService.COMPANY_BUSINESS_TYPE, "兼营").getId());
					}
					company.setProduct1(vo.getProduct1());
					company.setProduct2(vo.getProduct2());
					company.setProduct3(vo.getProduct3());
					if(!StringUtils.isBlank(vo.getCategory())) {
						Code categoryCode = codeService.getCodeByConditions(CodeService.CATEGORY, vo.getCategory(), 3);
						if(categoryCode == null) {
							wrongInfos.add("您填写的行业类别不正确");
							wrongDatas.add(cells);
							continue;
						}
						company.setCategoryCode(categoryCode.getId());
					}
					if(!StringUtils.isBlank(vo.getRegister())) {
						Code registerCode = codeService.getCodeByKindAndDisplayName(CodeService.COMPANY_REGISTER, vo.getRegister());
						if(registerCode == null) {
							wrongInfos.add("您填写的登记注册类型不正确");
							wrongDatas.add(cells);
							continue;
						}
						company.setRegisterCode(registerCode.getId());
					}
					if(!StringUtils.isBlank(vo.getAccounting())) {
						Code accountingCode = codeService.getCodeByKindAndDisplayName(CodeService.COMPANY_ACCOUNTING, vo.getAccounting());
						if(accountingCode == null) {
							wrongInfos.add("您填写的执行会计制度不正确");
							wrongDatas.add(cells);
							continue;
						}
						company.setAccountingCode(accountingCode.getId());
					}
					if(!StringUtils.isBlank(vo.getOrganization())) {
						Code organizationCode = codeService.getCodeByKindAndDisplayName(CodeService.COMPANY_ORGANIZATION, vo.getOrganization());
						if(organizationCode == null) {
							wrongInfos.add("您填写的机构类型不正确");
							wrongDatas.add(cells);
							continue;
						}
						company.setOrganizationCode(organizationCode.getId());
					}
					if(!StringUtils.isBlank(vo.getEmployeeNum())) {
						if(!NumberUtils.isNumber(vo.getEmployeeNum())) {
							wrongInfos.add("平均从业人数必须为数字");
							wrongDatas.add(cells);
							continue;
						}
						company.setEmployeeNum(new Double(Double.parseDouble(vo.getEmployeeNum())).intValue());
					}
					if(!StringUtils.isBlank(vo.getMasterNum())) {
						if(!NumberUtils.isNumber(vo.getMasterNum())) {
							wrongInfos.add("研究生人数必须为数字");
							wrongDatas.add(cells);
							continue;
						}
						company.setMasterNum(new Double(Double.parseDouble(vo.getMasterNum())).intValue());
					}
					if(!StringUtils.isBlank(vo.getBachelorNum())) {
						if(!NumberUtils.isNumber(vo.getBachelorNum())) {
							wrongInfos.add("本科人数必须为数字");
							wrongDatas.add(cells);
							continue;
						}
						company.setBachelorNum(new Double(Double.parseDouble(vo.getBachelorNum())).intValue());
					}
					if(!StringUtils.isBlank(vo.getCollegeNum())) {
						if(!NumberUtils.isNumber(vo.getCollegeNum())) {
							wrongInfos.add("专科人数必须为数字");
							wrongDatas.add(cells);

							continue;
						}
						company.setCollegeNum(new Double(Double.parseDouble(vo.getCollegeNum())).intValue());
					}
					if(!StringUtils.isBlank(vo.getOtherNum())) {
						if(!NumberUtils.isNumber(vo.getOtherNum())) {
							wrongInfos.add("其他人数必须为数字");
							wrongDatas.add(cells);

							continue;
						}
						company.setOtherNum(new Double(Double.parseDouble(vo.getOtherNum())).intValue());
					}
					if(!StringUtils.isBlank(vo.getMajorInquiry()) && (Boolean.valueOf(vo.getMajorInquiry()) 
							|| "是".equals(vo.getMajorInquiry()))) {
						company.setMajorInquiry(true);
					} else {
						company.setMajorInquiry(false);
					}
					if(isCreate) {
						User user = userService.createUser(company, app.getCurrentDeclarationYear());
						company.setUserId(user.getId());
					} else {
						//确保所在县与用户里的属性一致
						User user = company.getUser();
						if(company.getContact() != null) {
							user.setAreaId(company.getContact().getCountyId());
							userService.save(user);
						}
					}
					WebHolder.fillOperatorValues(company);
					
					contactDao.save(contact);
					companyDao.save(company);
					successNum++;
				}
			}
			importResult.setSuccessNum(successNum);
			importResult.setFailureNum(totalNum - successNum);
			importResult.setDatas(wrongDatas);
			importResult.setWrongInfos(wrongInfos.toArray(new String[0]));
			return importResult;
		} catch (Exception e) {
			log.error("导入单位资料的时候发生错误", e);
			throw new BusinessException("导入单位资料的时候发生错误");
		}
	}

	/**
	 * 导出企业名录库
	 * @param response
	 * @param areaIds
	 * @param declarationStates
	 * @throws IOException
	 */
	public void exportCompany(HttpServletResponse response, Long[] areaIds,
			Byte[] declarationStates) throws IOException {
		StringBuilder hql = new StringBuilder("select c from Company c left join c.declaration dec join fetch c.contact contact left join c.operator oper where c.year=? ");
		List<Object> params = new ArrayList<>();
		params.add(WebHolder.getUser().getCurrentYear());
		//选择的区域
		if(areaIds != null && areaIds.length > 0) {
			hql.append(" and contact.countyId in (");
			for (int i = 0; i < areaIds.length; i++) {
				hql.append("?,");
				params.add(areaIds[i]);
			}
			hql.replace(hql.length()-1, hql.length(), ") ");
		}
		
		//直报状态
		if(declarationStates != null && declarationStates.length > 0) {
			hql.append(" and (dec.state in (");
			boolean needUncommit = false;
			for (int i = 0; i < declarationStates.length; i++) {
				if(EnumDeclarationState.UNCOMMIT.value.equals(declarationStates[i])) {
					needUncommit = true;
				}
				hql.append("?,");
				params.add(declarationStates[i]);
			}
			hql.replace(hql.length()-1, hql.length(), ") ");
			if(needUncommit) {
				hql.append(" or dec.id is null ");
			}
			hql.append(") ");
		}
		hql.append(" order by oper.addTime desc ");
		
		List<Company> companies = companyDao.query(hql.toString(), null, params.toArray());
		
		ExcelTemplate template = new ExcelTemplate("templates/company_export.xlsx");
		template.setCellStyle("STYLE_1");
		int row = 0;
		//填入表头
		template.createRow(row++);
		//公司信息表头
		template.createCell("组织机构代码").createCell("单位名称").createCell("单位负责人").createCell("城市").createCell("区/县")
		.createCell("地址").createCell("区号").createCell("电话号码").createCell("分机号").createCell("传真号码").createCell("电子邮箱")
		.createCell("邮政编码").createCell("网址").createCell("主营还是兼营体育业务").createCell("主要体育业务活动1").createCell("主要体育业务活动2")
		.createCell("主要体育业务活动3").createCell("行业类别").createCell("登记注册类型").createCell("会计制度")
		.createCell("机构类型").createCell("平均从业人员（人）").createCell("研究生").createCell("本科学历").createCell("专科学历")
		.createCell("其他").createCell("是否是重点调查企业").createCell("审核状态");
		
		//填入直报数据
		for (Company company : companies) {
			Contact contact = company.getContact();
			template.createRow(row++);
			//填入101表单位资料
			String countyName = "";
			if(company.getContact().getCounty() != null) {
				countyName = company.getContact().getCounty().getName();
			}
			template.createCell(company.getCode()).createCell(company.getName()).createCell(company.getPrincipal()).createCell("深圳市").createCell(countyName)
			.createCell(contact.getLocation()).createCell(contact.getAreaCode()).createCell(contact.getPhone()).createCell(contact.getPhoneExt()).createCell(contact.getFax()).createCell(contact.getEmail())
			.createCell(contact.getZipCode()).createCell(contact.getWebsite()).createCell(getCodeDisplayName(company.getBusinessTypeCode())).createCell(company.getProduct1()).createCell(company.getProduct2())
			.createCell(company.getProduct3()).createCell(getCodeDisplayName(company.getCategoryCode())).createCell(getCodeDisplayName(company.getRegisterCode())).createCell(getCodeDisplayName(company.getAccountingCode()))
			.createCell(getCodeDisplayName(company.getOrganizationCode())).createCell(toStr(company.getEmployeeNum())).createCell(toStr(company.getMasterNum())).createCell(toStr(company.getBachelorNum())).createCell(toStr(company.getCollegeNum()))
			.createCell(toStr(company.getOtherNum())).createCell(company.isMajorInquiry() ? "是" : "否");
			String declarationStateLabel = "未报";
			if(company.getDeclaration() != null) {
				declarationStateLabel = EnumDeclarationState.valueOf(company.getDeclaration().getState()).label;
			}
			template.createCell(declarationStateLabel);
			
		}
		
		template.writeToDownload(response, "企业名录库导出");
		
	}

	private String getCodeDisplayName(Long codeId) {
		if(codeId == null) return "";
		return codeService.getCodeById(codeId).getDisplayName();
	}
	
	private String toStr(Number num) {
		if(num == null) return "";
		return num.toString();
	}
	
	
}
