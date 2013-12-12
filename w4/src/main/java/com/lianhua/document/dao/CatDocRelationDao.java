package com.lianhua.document.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.lianhua.document.model.CatDocRelation;
import com.rootrip.platform.genericdao.dao.hibernate.GenericDAOImpl;
import com.rootrip.platform.genericdao.search.Filter;
import com.rootrip.platform.genericdao.search.Search;

@Repository
public class CatDocRelationDao extends GenericDAOImpl<CatDocRelation, Long> {

	public List<CatDocRelation> findByCondition(List<Long> codeIds, Long accountingCode, int year) {
		Search search = new Search();
		search.addFilter(Filter.in("categoryCode", codeIds));
		search.addFilter(Filter.equal("year", year));
//		search.addFilter(Filter.or(Filter.equal("accountingCode", accountingCode), Filter.isNull("accountingCode")));
		search.addFilter(Filter.equal("accountingCode", accountingCode));
		List<CatDocRelation> results = super.search(search);
		//先根据行业类别与会计制度精确匹配,如果没有对应关系,则查找这个行业类别与会计制度为null的关系
		if(results.isEmpty()) {
			search = new Search();
			search.addFilter(Filter.in("categoryCode", codeIds));
			search.addFilter(Filter.equal("year", year));
			search.addFilter(Filter.isNull("accountingCode"));
			results = super.search(search);
		}
		return results;
	}

}
