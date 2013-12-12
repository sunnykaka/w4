package com.lianhua.user.test;

import org.junit.Test;
import org.springframework.test.annotation.Rollback;

import com.rootrip.platform.util.MD5Encoder;

public class PasswordTest{

	@Test
	@Rollback(false)
	public void test() {
		String password = "753951";
		System.out.println(MD5Encoder.encode(password));
	}

}
