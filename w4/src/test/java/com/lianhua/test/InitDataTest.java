package com.lianhua.test;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.lianhua.company.model.Company;
import com.rootrip.platform.test.PlatformTest;

public class InitDataTest extends PlatformTest {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Test
	public void test() {
		Session session = sessionFactory.getCurrentSession();
		for (int i = 12000; i < 12100; i++) {
			Company c = new Company();
			c.setId(Long.valueOf(i));
			c.setName(String.valueOf("11111"));
			session.save(c);
		}
	}
	
}
