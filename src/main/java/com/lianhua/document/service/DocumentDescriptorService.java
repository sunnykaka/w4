package com.lianhua.document.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Set;
import java.util.TreeSet;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lianhua.W4Application;
import com.lianhua.code.model.Code;
import com.lianhua.code.service.CodeService;
import com.lianhua.common.util.OrderedProperties;
import com.lianhua.company.model.Company;
import com.lianhua.document.dao.CatDocRelationDao;
import com.lianhua.document.dao.DocumentDao;
import com.lianhua.document.dao.DocumentDescriptorDao;
import com.lianhua.document.model.CatDocRelation;
import com.lianhua.document.model.DocumentDescriptor;
import com.lianhua.document.util.PropertyDescriptor;
import com.rootrip.platform.Platform;

@Service
public class DocumentDescriptorService {

	protected Logger log = LoggerFactory.getLogger(this.getClass());
	
	private final Map<String, String> tips = new HashMap<>();
	//key:descriptorId;value:{key:propertyName;value:PropertyDescriptor}
	private final Map<Long, Map<String, PropertyDescriptor>> propertyDescriptors = new LinkedHashMap<>();

	@Autowired
	private DocumentDao documentDao;

	@Autowired
	private DocumentDescriptorDao documentDescriptorDao;

	private W4Application app = (W4Application)Platform.getInstance().getApp();

	@Autowired
	private CodeService codeService;

	@Autowired
	private CatDocRelationDao catDocRelationDao;
	

	/**
	 * 查找当前企业对应年度合适的需要填报的表格
	 * @param company
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<DocumentDescriptor> findSuitableDocumentDescriptor(
			Company company) {
		List<DocumentDescriptor> descriptors = new ArrayList<>();
		Long accountingCode = company.getAccountingCode();
		Long categoryCode = company.getCategoryCode();
		int year = company.getYear();
		Long[] descriptorIds = findDecriptorIdByCondition(categoryCode, accountingCode, year);
		if(descriptorIds != null) {
			for (int i = 0; i < descriptorIds.length; i++) {
				DocumentDescriptor descriptor = documentDescriptorDao.get(descriptorIds[i]);
				if(descriptor.isMajorInquiry()) {
					//重点调查表格需要全局启用重点企业调查,并且当前企业是重点调查企业的时候才能进行填报
					if(company.isMajorInquiry() && codeService.isMajorInquiryEnabled()) {
						descriptors.add(descriptor);
					}
				} else {
					descriptors.add(descriptor);
				}
			}
		}
		if(descriptors.isEmpty()) {
			//默认填写113表
			DocumentDescriptor defaultDocument = documentDescriptorDao.getByCodeAndYear("深体113表", 2013);
			if(defaultDocument != null) {
				descriptors.add(defaultDocument);
			}
		}

		//TODO 根据行业类别和会计制度,以及直报年度得到合适填写的DocumentDescriptor
//		descriptors.addAll(documentDescriptorDao.findAll());
		return descriptors;
	}

	/**
	 * 根据行业类别,会计制度以及直报年度得到需要填写的表格的id
	 * @param categoryCode
	 * @param accountingCode
	 * @param year
	 * @return
	 */
	@Transactional(readOnly = true)
	public Long[] findDecriptorIdByCondition(Long categoryCode, Long accountingCode, int year) {
		Code category = codeService.getCodeById(categoryCode);
		if(category == null) {
			return null;
		}
		List<Long> codeIds = new ArrayList<>();
		Code parent = category.getParent();
		codeIds.add(category.getId());
		while(parent != null) {
			codeIds.add(parent.getId());
			parent = parent.getParent();
		}

		List<CatDocRelation> catDocRelations = catDocRelationDao.findByCondition(codeIds, accountingCode, year);

		if(catDocRelations.isEmpty()) {
			return null;
		} else if(catDocRelations.size() > 1) {
			StringBuilder sb = new StringBuilder();
			for(Long codeId : codeIds) {
				sb.append(codeId).append(",");
			}
			sb.deleteCharAt(sb.length() - 1);
			log.error("表格对应关系设置错误, 根据codeIds[{}], accountingCode[{}], year[{}]的条件搜索出来的数据条数为[{}]",
					sb.toString(), accountingCode, year, catDocRelations.size());
			return null;
		} else {
			CatDocRelation relation = catDocRelations.get(0);
			String[] idsInString = relation.getDescriptorIds().split(",");
			Long[] ids = new Long[idsInString.length];
			for (int i = 0; i < idsInString.length; i++) {
				ids[i] = Long.parseLong(idsInString[i]);
			}
			return ids;
		}


	}

	/**
	 * 查找对应年度所有的表格
	 * @param currentDeclarationYear
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<DocumentDescriptor> findByYear(Integer currentDeclarationYear) {
		List<CatDocRelation> catDocRelations = catDocRelationDao.findByCondition(null, null, currentDeclarationYear);
		Set<Long> descriptorIdSet = new TreeSet<>();
		for(CatDocRelation relation : catDocRelations) {
			String descriptorIds = relation.getDescriptorIds();
			if(!StringUtils.isBlank(descriptorIds)) {
				String[] descriptorIdArr = descriptorIds.split(",");
				for (int i = 0; i < descriptorIdArr.length; i++) {
					descriptorIdSet.add(Long.parseLong(descriptorIdArr[i]));
				}
			}
		}
		
		List<DocumentDescriptor> descriptors = new ArrayList<>();
		for(Long descriptorId : descriptorIdSet) {
			descriptors.add(get(descriptorId));
		}
		return descriptors;
	}
	
	public void initPropertyDescritor() throws IOException {
		//初始化提示信息
		Properties props = new Properties();
		props.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("tips.properties"));
		for(Iterator<Entry<Object,Object>> iter = props.entrySet().iterator(); iter.hasNext();) {
			Entry<Object,Object> entry = iter.next();
			tips.put((String)entry.getKey(), (String)entry.getValue());
		}
		//初始化表格属性元信息
		OrderedProperties orderedProps = new OrderedProperties();
		orderedProps.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("property_descriptor.properties"));
		for(Iterator<Object> iter = orderedProps.keySet().iterator(); iter.hasNext();) {
			String key = (String)iter.next();
			String value = (String)orderedProps.get(key);
			String[] descIdAndProp = key.split("_");
			Long descId = Long.parseLong(descIdAndProp[0]);
			String propertyName = descIdAndProp[1];
			Map<String, PropertyDescriptor> propertyMap = propertyDescriptors.get(descId);
			if(propertyMap == null) {
				propertyMap = new LinkedHashMap<>();
				propertyDescriptors.put(descId, propertyMap);
			}
			propertyMap.put(propertyName, PropertyDescriptor.forNameAndValue(propertyName, value));
		}
	}

	public Map<String, String> getTips() {
		return tips;
	}

	/**
	 * key:descriptorId;value:{key:propertyName;value:PropertyDescriptor}
	 * @return
	 */
	public Map<Long, Map<String, PropertyDescriptor>> getPropertyDescriptors() {
		return propertyDescriptors;
	}

	@Transactional(readOnly = true)
	public DocumentDescriptor get(Long id) {
		return documentDescriptorDao.get(id);
	}
}
