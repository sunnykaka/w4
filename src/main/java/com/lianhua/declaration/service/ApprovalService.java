package com.lianhua.declaration.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lianhua.W4Application;
import com.lianhua.common.web.WebHolder;
import com.lianhua.company.model.Company;
import com.lianhua.declaration.dao.ApprovalDao;
import com.lianhua.declaration.model.Approval;
import com.lianhua.declaration.model.Declaration;
import com.lianhua.declaration.model.EnumApprovalState;
import com.lianhua.declaration.model.EnumApprovalStep;
import com.lianhua.declaration.model.EnumApprovalType;
import com.rootrip.platform.Platform;
import com.rootrip.platform.genericdao.search.Filter;
import com.rootrip.platform.genericdao.search.Search;

@Service
public class ApprovalService {
	
	@Autowired
	private ApprovalDao approvalDao;
	
	private W4Application app = (W4Application)Platform.getInstance().getApp();

	/**
	 * 查找直报对应的审批记录
	 * @param declaration
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<Approval> findByDeclaration(Declaration declaration) {
		if(declaration == null) return new ArrayList<Approval>();
		Search search = new Search().addSortAsc("operator.addTime");
		search.addFilter(Filter.equal("declarationId", declaration.getId()));
		return approvalDao.search(search);
	}

	/**
	 * 查找企业资料对应的审批记录
	 * @param company
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<Approval> findByCompany(Company company) {
		if(company == null) return new ArrayList<Approval>();
		Search search = new Search().addSortAsc("operator.addTime");
		search.addFilter(Filter.equal("companyId", company.getId()));
		return approvalDao.search(search);
	}

	/**
	 * 创建直报审核记录
	 * @param declarationId
	 * @param state
	 * @param step
	 * @param comment
	 * @param reason
	 */
	@Transactional
	public void createDeclarationAppvoval(Long declarationId, EnumApprovalState state,
			EnumApprovalStep step, String comment, String reason) {
		Approval approval = new Approval();
		approval.setType(EnumApprovalType.DECLARATION.value);
		approval.setDeclarationId(declarationId);
		approval.setState(state.label);
		approval.setStep(step.label);
		approval.setComment(comment);
		approval.setReason(reason);
		WebHolder.fillOperatorValues(approval);
		approvalDao.save(approval);
	}
	
	/**
	 * 创建企业资料审核记录
	 * @param companyId
	 * @param state
	 * @param step
	 * @param comment
	 * @param reason
	 */
	@Transactional
	public void createCompanyAppvoval(Long companyId, EnumApprovalState state,
			EnumApprovalStep step, String comment, String reason) {
		Approval approval = new Approval();
		approval.setType(EnumApprovalType.COMPANY.value);
		approval.setCompanyId(companyId);
		approval.setState(state.label);
		approval.setStep(step.label);
		approval.setComment(comment);
		approval.setReason(reason);
		WebHolder.fillOperatorValues(approval);
		approvalDao.save(approval);
	}
	
}
