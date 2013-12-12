package com.lianhua.declaration.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.base.Joiner;
import com.google.common.collect.Sets;
import com.lianhua.W4Application;
import com.lianhua.area.model.Area;
import com.lianhua.area.service.AreaService;
import com.lianhua.code.service.CodeService;
import com.lianhua.common.excel.ExcelTemplate;
import com.lianhua.common.web.WebHolder;
import com.lianhua.company.dao.CompanyDao;
import com.lianhua.company.model.Company;
import com.lianhua.company.service.CompanyService;
import com.lianhua.contact.dao.ContactDao;
import com.lianhua.contact.model.Contact;
import com.lianhua.declaration.dao.DeclarationDao;
import com.lianhua.declaration.model.Declaration;
import com.lianhua.declaration.model.EnumApprovalState;
import com.lianhua.declaration.model.EnumApprovalStep;
import com.lianhua.declaration.model.EnumDeclarationState;
import com.lianhua.document.dao.DocumentDao;
import com.lianhua.document.dao.PropertyDao;
import com.lianhua.document.model.Document;
import com.lianhua.document.model.DocumentDescriptor;
import com.lianhua.document.model.Property;
import com.lianhua.document.service.DocumentDescriptorService;
import com.lianhua.document.service.DocumentService;
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
import com.rootrip.platform.util.MathUtil;

@Service
public class DeclarationService {
	
	protected final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private DeclarationDao declarationDao;
	
	@Autowired
	private DocumentDao documentDao;

	@Autowired
	private ContactDao contactDao;

	@Autowired
	private UserService userService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private DocumentService documentService;
	
	@Autowired
	private DocumentDescriptorService documentDescriptorService;

	@Autowired
	private PropertyDao propertyDao;

	@Autowired
	private CompanyService companyService;

	@Autowired
	private ApprovalService approvalService;
	
	@Autowired
	private AreaService areaService;

	@Autowired
	private CompanyDao companyDao;

	private W4Application app = (W4Application)Platform.getInstance().getApp();

	@Transactional(readOnly = true)
	public Declaration get(Long id) {
		return declarationDao.get(id);
	}

	@Transactional(readOnly = true)
	public Declaration getByUserAndYear(Long userId, Integer currentDeclarationYear) {
		Search search = new Search();
		search.addFilter(Filter.equal("company.userId", userId)).addFilter(Filter.equal("year", currentDeclarationYear));
		return declarationDao.searchUnique(search);
	}

	@Transactional(readOnly = true)
	public Declaration getByCompanyAndYear(Long companyId, Integer currentDeclarationYear) {
		Search search = new Search();
		search.addFilter(Filter.equal("companyId", companyId)).addFilter(Filter.equal("year", currentDeclarationYear));
		return declarationDao.searchUnique(search);
	}

	@Transactional
	public Long prepareDeclaration(Company company, Integer currentDeclarationYear) throws AppException {
		Declaration declaration = getByCompanyAndYear(company.getId(), currentDeclarationYear);
		List<DocumentDescriptor> suitableDescriptors = documentDescriptorService.findSuitableDocumentDescriptor(company);
		if(suitableDescriptors.isEmpty()) {
			throw new AppException("您所在行业没有需要填报的表格，如有疑问请与管理员联系");
		}
		boolean isCreate = false;
		boolean isNeedRebuildDocument = false;
		if(declaration == null) {
			isCreate = true;
			//当前年度还没有直报过,创建直报记录
			declaration = new Declaration();
			declaration.setCompanyId(company.getId());
			declaration.setYear(currentDeclarationYear);
			declaration.setState(EnumDeclarationState.UNCOMMIT.value);
			WebHolder.fillOperatorValues(declaration);
			declarationDao.save(declaration);
		} else {
			//如果该直报未提交或者已被退回,则判断当前的表格是否与合适填写的表格一致.
			//如果不一致,删除不需要填写的表格,加入应该填写的表格
			isNeedRebuildDocument = EnumDeclarationState.UNCOMMIT.value.equals(declaration.getState()) ||
					EnumDeclarationState.BACK.value.equals(declaration.getState());
			if(isNeedRebuildDocument) {
				List<Document> documents = documentService.findByDeclaration(declaration.getId());
				for(Document document : documents) {
					Long descriptorId = document.getDescriptorId();
					boolean exist = false;
					for(Iterator<DocumentDescriptor> descriptorIter = suitableDescriptors.iterator(); descriptorIter.hasNext();) {
						DocumentDescriptor descriptor = descriptorIter.next();
						if(descriptorId.equals(descriptor.getId())) {
							exist = true;
							descriptorIter.remove();
							break;
						}
					}
					if(!exist) {
						documentService.deleteDocument(document);
					}
				}
			}
		}

		//如果是新建直报或者编辑直报但是该直报未提交或者已被退回,将需要新填写的表格创建出来
		if(isCreate || isNeedRebuildDocument) {
			for(DocumentDescriptor descriptor : suitableDescriptors) {
				documentService.createDocument(declaration, descriptor);
			}
		}

		return declaration.getId();
	}


	@Transactional
	public void saveDocument(Document document, Map<String, String[]> propertyMap, String action) throws AppException {
		if(!isDeclarationUpdatable(WebHolder.getUser(), document.getDeclarationId())) {
			throw new AppException("当前直报已经结束,如有疑问请联系管理员");
		}
		if(!"tempSave".equalsIgnoreCase(action)) {
			document.setSaved(true);
		}
		if("commit".equalsIgnoreCase(action)) {
			Declaration declaration = document.getDeclaration();
			//待区审核
			declaration.setState(EnumDeclarationState.COUNTY_APPROVING.value);
			WebHolder.fillOperatorValues(declaration);
			declarationDao.save(declaration);
			approvalService.createDeclarationAppvoval(declaration.getId(), EnumApprovalState.COMMIT,
					EnumApprovalStep.ENTERPRISE_COMMIT, null, null);
		}
		for(Map.Entry<String, String[]> entry : propertyMap.entrySet()) {
			String prop = entry.getKey();
			String[] values = entry.getValue();
			String value = null;
			if(values != null) {
				if(values.length == 1) {
					value = values[0];
				} else {
					//如果有多个值,用:分隔
					Joiner joiner = Joiner.on(":").skipNulls();
					value = joiner.join(values);
				}
			}
			Property property = document.getPropertyMap().get(prop);
			if(property == null) {
				property = new Property();
				property.setName(prop);
				property.setDocumentId(document.getId());
			}
			if(value != null && NumberUtils.isNumber(value) && value.indexOf(".") != -1) {
				//如果是小数,四舍五入
				value = String.valueOf(MathUtil.round(Double.parseDouble(value), 2));
			}
			property.setValue(value);
			propertyDao.save(property);
		}

	}

	/**
	 * 当前用户能否对这个直报数据进行编辑
	 * @param currentUser
	 * @param companyId
	 * @return
	 */
	@Transactional(readOnly = true)
	public boolean isDeclarationUpdatable(User currentUser, Long declarationId) {
		if(declarationId == null || declarationId.equals(0L)) return false;
		Declaration declaration = get(declarationId);
		if(declaration == null) return false;
		Company company = companyService.get(declaration.getCompanyId());
		if(!company.getUserId().equals(currentUser.getId())) {
			//只能编辑自己的直报数据
			return false;
		}
		if(!app.getCurrentDeclarationYear().equals(company.getYear())) {
			//不在当前直报年度,不能编辑
			return false;
		}
		if(!app.isCurrentDeclarationYearOpening()) {
			//当前年度直报已关闭,不能编辑
			return false;
		}
		EnumDeclarationState state = EnumDeclarationState.valueOf(declaration.getState());
		if(state.equals(EnumDeclarationState.UNCOMMIT) || state.equals(EnumDeclarationState.BACK)) {
			return true;
		}
		return false;
	}

	/**
	 * 当前用户能否对这个直报数据进行审核
	 * @param currentUser
	 * @param companyId
	 * @return
	 */
	@Transactional(readOnly = true)
	public boolean isDeclarationApprovable(User currentUser, Long declarationId) {
		if(declarationId == null || declarationId.equals(0L)) return false;
		Declaration declaration = get(declarationId);
		if(declaration == null) return false;
		Company company = companyService.get(declaration.getCompanyId());
		if(!app.getCurrentDeclarationYear().equals(company.getYear())) {
			//不在当前直报年度,不能审核
			return false;
		}
		if(!app.isCurrentDeclarationYearOpening()) {
			//当前年度直报已关闭,不能审核
			return false;
		}
		EnumDeclarationState state = EnumDeclarationState.valueOf(declaration.getState());
		if(PermissionUtil.isEnterprise(currentUser)) {
			return false;
		} else if(PermissionUtil.isCountyManager(currentUser)) {
			if(state.equals(EnumDeclarationState.COUNTY_APPROVING)) {
				return true;
			}
		} else if(PermissionUtil.isCityManager(currentUser)) {
			if(state.equals(EnumDeclarationState.COUNTY_APPROVING) || state.equals(EnumDeclarationState.APPROVING)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 待审核直报数据列表
	 * @param paramMap
	 * @param page
	 * @return
	 */
	@Transactional(readOnly = true)
	public Map<String, Object> findByKey(Map<String, String[]> paramMap, Page page) {

		StringBuilder hql = new StringBuilder("select c from Company c left join c.declaration d left join d.operator o where c.year=? ");
		List<Object> params = new ArrayList<>();

		params.add(WebHolder.getUser().getCurrentYear());
		//区管理员只能查看自己区的数据
		if(PermissionUtil.isCountyManager()) {
			hql.append(" and c.contact.countyId = ? ");
			params.add(WebHolder.getUser().getAreaId());
		}

		if(paramMap.containsKey("codeOrName") && paramMap.get("codeOrName").length > 0) {
			String codeOrName = paramMap.get("codeOrName")[0];
			if(!StringUtils.isBlank(codeOrName)) {
				hql.append(" and (c.code like ? or c.name like ?) ");
				params.add("%" + codeOrName + "%");
				params.add("%" + codeOrName + "%");
			}
		}
		if(paramMap.containsKey("countyId") && paramMap.get("countyId").length > 0) {
			String county = paramMap.get("countyId")[0];
			if(!"-1".equals(county)) {
				hql.append(" and c.contact.countyId = ? ");
				params.add(Long.parseLong(county));
			}
		}
		
		String uncommitCountHql = hql.toString() + " and (d.state=0 or d is null) ";
		int uncommitCount = companyDao.count(uncommitCountHql, params.toArray());
		String approvingCountHql = hql.toString() + " and d.state = 1 ";
		int approvingCount = companyDao.count(approvingCountHql, params.toArray());
		String countyApprovingCountHql = hql.toString() + " and d.state = 2 ";
		int countyApproving = companyDao.count(countyApprovingCountHql, params.toArray());
		String approvedCountHql = hql.toString() + " and d.state = 3 ";
		int approvedCount = companyDao.count(approvedCountHql, params.toArray());
		String backCountHql = hql.toString() + " and d.state = 4 ";
		int backCount = companyDao.count(backCountHql, params.toArray());
		String canceldCountHql = hql.toString() + " and d.state in (5,6,7,8) ";
		int canceldCount = companyDao.count(canceldCountHql, params.toArray());
		
		if(paramMap.containsKey("declarationState") && paramMap.get("declarationState").length > 0) {
			String declarationState = paramMap.get("declarationState")[0];
			if(!"-1".equals(declarationState)) {
				if("0".equals(declarationState)) {
					hql.append(" and (d.state=0 or d is null) ");
				} else {
					hql.append(" and d.state = ? ");
					params.add(Byte.parseByte(declarationState));
				}
			}
		}
		hql.append(" order by o.updateTime desc");
		

		List<Company> companies = companyDao.query(hql.toString(), page, params.toArray());
		Map<String, Object> results = new HashMap<>();
		results.put("companies", companies);
		results.put("uncommitCount", uncommitCount);
		results.put("approvingCount", approvingCount);
		results.put("countyApproving", countyApproving);
		results.put("approvedCount", approvedCount);
		results.put("backCount", backCount);
		results.put("canceldCount", canceldCount);
		return results;
	}

	/**
	 * 审核直报数据
	 * @param declaration
	 * @param back 是否退回
	 * @param approveResult
	 * @param comment
	 * @throws AppException
	 */
	@Transactional
	public void approve(Declaration declaration, Boolean back, Integer approveResult, String comment) throws AppException {
		if(!isDeclarationApprovable(WebHolder.getUser(), declaration.getId())) {
			throw new AppException("当前不允许审核该直报数据");
		}
		//是区管理员还是市管理员
		boolean isCountyManager = PermissionUtil.isCountyManager();
		EnumApprovalState approvalState = null;
		if(back != null && back) {
			//退回
			declaration.setState(EnumDeclarationState.BACK.value);
			approvalState = EnumApprovalState.BACK;
		} else {
			if(Integer.valueOf(-1).equals(approveResult)) {
				//审核通过
				if(isCountyManager) {
					//待市审核
					declaration.setState(EnumDeclarationState.APPROVING.value);
				} else {
					declaration.setState(EnumDeclarationState.APPROVED.value);
				}
			} else {
				//取消
				declaration.setState(approveResult.byteValue());
			}
			approvalState = EnumApprovalState.APPROVED;
		}
		approvalService.createDeclarationAppvoval(declaration.getId(), approvalState,
				isCountyManager ? EnumApprovalStep.COUNTY_APPROVE : EnumApprovalStep.CITY_APPROVE, comment, null);
	}

	/**
	 * 撤回
	 * @param declaration
	 * @throws AppException
	 */
	@Transactional
	public void cancel(Declaration declaration) throws AppException {
		if(!isDeclarationCancelable(WebHolder.getUser(), declaration.getId())) {
			throw new AppException("当前不允许审核该直报数据");
		}
		declaration.setState(EnumDeclarationState.UNCOMMIT.value);
		approvalService.createDeclarationAppvoval(declaration.getId(), EnumApprovalState.CANCEL,
				EnumApprovalStep.ENTERPRISE_COMMIT, null, null);
	}

	/**
	 * 是否允许撤回
	 * @param user
	 * @param declarationId
	 * @return
	 */
	@Transactional(readOnly = true)
	private boolean isDeclarationCancelable(User currentUser, Long declarationId) {
		Declaration declaration = get(declarationId);
		Company company = companyService.get(declaration.getCompanyId());
		if(!app.getCurrentDeclarationYear().equals(company.getYear())) {
			//不在当前直报年度,不能撤回
			return false;
		}
		if(!app.isCurrentDeclarationYearOpening()) {
			//当前年度直报已关闭,不能撤回
			return false;
		}
		if(!company.getUserId().equals(currentUser.getId())) {
			//只能撤回自己的直报数据
			return false;
		}
		EnumDeclarationState state = EnumDeclarationState.valueOf(declaration.getState());
		if(state.equals(EnumDeclarationState.COUNTY_APPROVING) || state.equals(EnumDeclarationState.APPROVING)) {
			return true;
		}
		return false;
	}

	/**
	 * 导出直报数据
	 * @param response
	 * @param areaIds 选择的区域
	 * @param desIds 需要导出的元表格ID
	 * @param includeBack 是否包含退回数据
	 * @param includeApproving 是否包含审核中的数据
	 * @param includeCancel 是否包含取消填报的数据
	 * @throws IOException 
	 */
	@Transactional(readOnly = true)
	public void export(HttpServletResponse response, Long[] areaIds,
			Long[] desIds, String includeBack, String includeApproving, String includeCancel) throws IOException {
		StringBuilder hql = new StringBuilder("select doc from Document doc join fetch doc.declaration dec join fetch dec.company c join fetch c.contact contact where c.year=? ");
		List<Object> params = new ArrayList<>();
		params.add(WebHolder.getUser().getCurrentYear());
		//选择的区域
		hql.append(" and contact.countyId in (");
		for (int i = 0; i < areaIds.length; i++) {
			hql.append("?,");
			params.add(areaIds[i]);
		}
		hql.replace(hql.length()-1, hql.length(), ") ");
		
		//选择的表格
		hql.append(" and doc.descriptorId in (");
		for (int i = 0; i < desIds.length; i++) {
			hql.append("?,");
			params.add(desIds[i]);
		}
		hql.replace(hql.length()-1, hql.length(), ") ");
		
		//直报状态
		List<Byte> states = new ArrayList<>();
		states.add(EnumDeclarationState.APPROVED.value);
		if("true".equalsIgnoreCase(includeBack)) {
			states.add(EnumDeclarationState.BACK.value);
		}
		if("true".equalsIgnoreCase(includeApproving)) {
			states.add(EnumDeclarationState.APPROVING.value);
			states.add(EnumDeclarationState.COUNTY_APPROVING.value);
		}
		if("true".equalsIgnoreCase(includeCancel)) {
			states.add(EnumDeclarationState.CANCELD_R1.value);
			states.add(EnumDeclarationState.CANCELD_R2.value);
			states.add(EnumDeclarationState.CANCELD_R3.value);
			states.add(EnumDeclarationState.CANCELD_R4.value);
		}
		hql.append(" and dec.state in(");
		for(Byte state : states) {
			hql.append("?,");
			params.add(state);
		}
		hql.replace(hql.length()-1, hql.length(), ") ");
		
		List<Document> documents = documentDao.query(hql.toString(), null, params.toArray());
		//key:areaId;value:{key:companyId;value:company}
		Map<Long, Map<Long, Company>> areaCompanyMap = new LinkedHashMap<>();
		for (int i = 0; i < areaIds.length; i++) {
			areaCompanyMap.put(areaIds[i], new LinkedHashMap<Long, Company>());
		}
		//key:companyId;value:{key:documentDescriptorId;value:document}
		Map<Long, Map<Long, Document>> companyDocumentMap = new HashMap<>();
		//key:companyId;value:declaration
		Map<Long, Declaration> declarationMap = new HashMap<>();
		Map<Long, Map<String, PropertyDescriptor>> propertyDescriptorMap = documentDescriptorService.getPropertyDescriptors();
		//这次导出包含的表格种类
		Set<Long> includedDocumentDescriptors = new HashSet<>();
		//忽略的属性,不需要导出
		Set<String> ignorePropertyNames = Sets.newHashSet("employeeNum", "masterNum", "bachelorNum", "collegeNum", "otherNum");
		
		for(Document document : documents) {
			includedDocumentDescriptors.add(document.getDescriptorId());
			Company company = document.getDeclaration().getCompany();
			declarationMap.put(company.getId(), document.getDeclaration());
			Long areaId = company.getContact().getCountyId();
			Map<Long, Company> companyMap = areaCompanyMap.get(areaId);
			if(companyMap == null) {
				companyMap = new LinkedHashMap<Long, Company>();
				areaCompanyMap.put(areaId, companyMap);
			}
			if(!companyMap.containsKey(company.getId())) {
				companyMap.put(company.getId(), company);
			}
			
			Map<Long, Document> documentMap = companyDocumentMap.get(company.getId());
			if(documentMap == null) {
				documentMap = new HashMap<Long, Document>();
				companyDocumentMap.put(company.getId(), documentMap);
			}
			documentMap.put(document.getDescriptorId(), document);
		}
		
		
		ExcelTemplate template = new ExcelTemplate("templates/declaration_export.xlsx");
		template.setCellStyle("STYLE_1");
		int row = 0;
		//填入表头
		template.createRow(row++);
		//公司信息表头
		template.createCell("组织机构代码").createCell("单位名称").createCell("城市").createCell("区/县")
		.createCell("地址").createCell("区号").createCell("电话号码").createCell("分机号").createCell("传真号码")
		.createCell("邮政编码").createCell("电子邮箱").createCell("主营还是兼营体育业务").createCell("主要体育业务活动1").createCell("主要体育业务活动2")
		.createCell("主要体育业务活动3").createCell("行业类别").createCell("登记注册类型").createCell("会计制度")
		.createCell("机构类型").createCell("单位负责人").createCell("填表人").createCell("联系电话")
		.createCell("平均从业人员（人）").createCell("研究生").createCell("本科学历").createCell("专科学历")
		.createCell("其他").createCell("是否是重点调查企业").createCell("审核状态");
		
		//直报表格表头
		for(Map.Entry<Long, Map<String, PropertyDescriptor>> propertyDescriptorMapEntry : propertyDescriptorMap.entrySet()) {
			if(!includedDocumentDescriptors.contains(propertyDescriptorMapEntry.getKey())) {
				//这次导出不包含这个表格
				continue;
			}
			Map<String, PropertyDescriptor> propertyMap = propertyDescriptorMapEntry.getValue();
			for(Map.Entry<String, PropertyDescriptor> propertyMapEntry : propertyMap.entrySet()) {
				String propertyName = propertyMapEntry.getKey();
				if(ignorePropertyNames.contains(propertyName)) {
					//该属性不需要导出
					continue;
				}
				PropertyDescriptor propertyDescriptor = propertyMapEntry.getValue();
				template.createCell(propertyDescriptor.getLabel());
			}
		}
		
		
		//填入直报数据
		for (int i = 0; i < areaIds.length; i++) {
			Long areaId = areaIds[i];
			Area area = areaService.getById(areaId);
			Map<Long, Company> companyMap = areaCompanyMap.get(areaId);
			if(companyMap == null || companyMap.isEmpty()) continue;
			for(Map.Entry<Long, Company> entry : companyMap.entrySet()) {
				Company company = entry.getValue();
				Contact contact = company.getContact();
				template.createRow(row++);
				//填入101表单位资料
				template.createCell(company.getCode()).createCell(company.getName()).createCell("深圳市").createCell(area.getName())
				.createCell(contact.getLocation()).createCell(contact.getAreaCode()).createCell(contact.getPhone()).createCell(contact.getPhoneExt()).createCell(contact.getFax())
				.createCell(contact.getZipCode()).createCell(contact.getEmail()).createCell(getCodeDisplayName(company.getBusinessTypeCode())).createCell(company.getProduct1()).createCell(company.getProduct2())
				.createCell(company.getProduct3()).createCell(getCodeDisplayName(company.getCategoryCode())).createCell(getCodeDisplayName(company.getRegisterCode())).createCell(getCodeDisplayName(company.getAccountingCode()))
				.createCell(getCodeDisplayName(company.getOrganizationCode())).createCell(company.getPrincipal()).createCell(company.getPreparer()).createCell(company.getMobile())
				.createCell(toStr(company.getEmployeeNum())).createCell(toStr(company.getMasterNum())).createCell(toStr(company.getBachelorNum())).createCell(toStr(company.getCollegeNum()))
				.createCell(toStr(company.getOtherNum())).createCell(company.isMajorInquiry() ? "是" : "否").createCell(EnumDeclarationState.valueOf(declarationMap.get(company.getId()).getState()).label);
				
				//填入该公司被选中的直报数据
				Map<Long, Document> documentMap = companyDocumentMap.get(company.getId());
				for(Map.Entry<Long, Map<String, PropertyDescriptor>> propertyDescriptorMapEntry : propertyDescriptorMap.entrySet()) {
					if(!includedDocumentDescriptors.contains(propertyDescriptorMapEntry.getKey())) {
						//这次导出不包含这个表格
						continue;
					}
					Map<String, PropertyDescriptor> propertyMap = propertyDescriptorMapEntry.getValue();
					Document document = documentMap.get(propertyDescriptorMapEntry.getKey());
					for(Map.Entry<String, PropertyDescriptor> propertyMapEntry : propertyMap.entrySet()) {
						String propertyName = propertyMapEntry.getKey();
						if(ignorePropertyNames.contains(propertyName)) {
							//该属性不需要导出
							continue;
						}
						if(document == null) {
							template.createCell();
						} else {
							Map<String, Property> documentPropertyMap = document.getPropertyMap();
							
							PropertyDescriptor propertyDescriptor = propertyMapEntry.getValue();
							Property property = documentPropertyMap.get(propertyName);
							if(property == null) {
								DocumentDescriptor documentDescriptor = documentDescriptorService.get(propertyDescriptorMapEntry.getKey());
								if(!"业务活动调查表".equals(documentDescriptor.getName())) {
									//业务活动调查表中很多字段可以为空
									log.warn(String.format("导出数据的时候发现企业【%s】表格【%s】属性【%s】为空", company.getName(), documentDescriptor.getCode(), propertyDescriptor.getName()));
								}
								template.createCell();
								continue;
							}
							switch (propertyDescriptor.getType()) {
							case NULL:
							case INVISIBLE:
								//什么都不做
								break;
							case TEXT:
								template.createCell(notNullStr(property.getValue()));
								break;
							case PERCENT:
								template.createCell(notNullStr(property.getValue()) + "%");
								break;
							case CODE_ID:
								if(StringUtils.isBlank(property.getValue())) {
									template.createCell();
								} else {
									String codeDisplayName = null;
									if(property.getValue().indexOf(":") == -1) {
										codeDisplayName = codeService.getCodeById(Long.parseLong(property.getValue())).getDisplayName();
									} else {
										StringBuilder textValue = new StringBuilder();
										String[] codeIds = property.getValue().split(":");
										for (int j = 0; j < codeIds.length; j++) {
											textValue.append(codeService.getCodeById(Long.parseLong(codeIds[j])).getDisplayName()).append("、");
										}
										textValue.delete(textValue.length()-1, textValue.length());
										codeDisplayName = textValue.toString();
									}
									template.createCell(codeDisplayName);
								}
								break;
							default:
								DocumentDescriptor documentDescriptor = documentDescriptorService.get(propertyDescriptorMapEntry.getKey());
								throw new BusinessException(String.format("企业【%s】表格【%s】属性【%s】未知的属性类型【%s】", company.getName(), documentDescriptor.getCode(), propertyDescriptor.getName(), propertyDescriptor.getType().value));
							}
						}
					}
				}
			}
		}
		
		template.writeToDownload(response, "企业直报数据");
	}
	
	private String getCodeDisplayName(Long codeId) {
		if(codeId == null) return "";
		return codeService.getCodeById(codeId).getDisplayName();
	}
	
	private String toStr(Number num) {
		if(num == null) return "";
		return num.toString();
	}
	
	private String notNullStr(String str) {
		if(str == null) return "";
		return str;
	}

	/**
	 * 批量审核通过
	 * @param decIds
	 */
	@Transactional
	public void batchApprove(Long[] decIds) {
		for (int i = 0; i < decIds.length; i++) {
			Declaration declaration = get(decIds[i]);
			if(declaration == null) continue;
			if(EnumDeclarationState.APPROVING.value.equals(declaration.getState()) 
					|| EnumDeclarationState.COUNTY_APPROVING.value.equals(declaration.getState())) {
				//是区管理员还是市管理员
				boolean isCountyManager = PermissionUtil.isCountyManager();
				if(isCountyManager) {
					//待市审核
					declaration.setState(EnumDeclarationState.APPROVING.value);
				} else {
					declaration.setState(EnumDeclarationState.APPROVED.value);
				}
				approvalService.createDeclarationAppvoval(declaration.getId(), EnumApprovalState.APPROVED,
						isCountyManager ? EnumApprovalStep.COUNTY_APPROVE : EnumApprovalStep.CITY_APPROVE, "", null);
			}
		}
	}
}
