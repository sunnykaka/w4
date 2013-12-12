package com.lianhua.document.service;

import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.notNullValue;
import static org.hamcrest.Matchers.nullValue;
import static org.junit.Assert.assertThat;

import javax.xml.bind.JAXBException;

import org.apache.commons.lang3.StringUtils;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.lianhua.code.service.CodeService;
import com.rootrip.platform.test.PlatformTest;

public class DocumentDescriptorServiceTest extends PlatformTest {
	
	@Autowired
	private DocumentDescriptorService documentDescriptorService;
	

	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	@Rollback(true)
	public void testFindDecriptorIdByCondition() throws JAXBException {
		//社会事务管理机构
		assertEquals(10103L, null, 2013, "3,14");
		assertEquals(10103L, 1L, 2013, "3,14");
		//体育社会事务管理机构
		assertEquals(10104L, 10402L, 2013, "3,14");
		assertEquals(10104L, null, 2013, "3,14");
		
		//体育组织
		assertEquals(10105L, 10404L, 2013, "4,14");
		assertEquals(10105L, 10401L, 2013, "2,14");
		assertNull(10105L, null, 2013);
		
		//体育组织的下级: 各种群众性体育组织
		assertEquals(10108L, 10404L, 2013, "4,14");
		assertEquals(10108L, 10401L, 2013, "2,14");
		assertNull(10108L, null, 2013);
		
		//体育展览服务为空
		assertNull(10189L, 10404L, 2013);
	}
	
	private void assertEquals(Long categoryCode, Long accountingCode, int year, String descriptorIds) {
		Long[] ids = documentDescriptorService.findDecriptorIdByCondition(categoryCode, accountingCode, year);
		assertThat(ids, notNullValue());
		assertThat(StringUtils.join(ids, ","), is(descriptorIds));
	}
	
	private void assertNull(Long categoryCode, Long accountingCode, int year) {
		Long[] ids = documentDescriptorService.findDecriptorIdByCondition(categoryCode, accountingCode, year);
		assertThat(ids, nullValue());
	}

}
