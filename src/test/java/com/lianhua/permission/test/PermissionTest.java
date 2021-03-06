package com.lianhua.permission.test;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.lianhua.permission.jaxb.Permissions;
import com.lianhua.permission.service.PermissionService;
import com.rootrip.platform.test.PlatformTest;

public class PermissionTest extends PlatformTest {
	
	@Autowired
	private PermissionService permissionService;

	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	@Rollback(false)
	public void test() throws JAXBException {
		JAXBContext jc = JAXBContext.newInstance(Permissions.class.getPackage().getName());
		Permissions permissions = (Permissions)jc.createUnmarshaller().unmarshal(
				Thread.currentThread().getContextClassLoader().getResourceAsStream("permissions.xml"));
//		System.out.println(permissions.getUser().getName());
//		System.out.println(permissions.getResource().getName());
//		for(Permissions.Resource.Operation op : permissions.getResource().getOperation()) {
//			System.out.println(op.getName());
//		}
		permissionService.refreshPermissions(permissions, true);
//		Marshaller marshaller = jc.createMarshaller();
//		marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
//		marshaller.marshal( usersE,new FileOutputStream("src/test.xml"));
	}

}
