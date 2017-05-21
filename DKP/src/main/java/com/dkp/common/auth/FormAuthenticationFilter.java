package com.dkp.common.auth;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.stereotype.Component;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * 表单验证（包含验证码）过滤类
 * @author copy yangdongdong by gewenjie
 */
@Component
public class FormAuthenticationFilter extends org.apache.shiro.web.filter.authc.FormAuthenticationFilter {

	public static final String DEFAULT_CAPTCHA_PARAM = "validateCode";

	private String captchaParam = DEFAULT_CAPTCHA_PARAM;

	public String getCaptchaParam() {
		return captchaParam;
	}

	protected String getCaptcha(ServletRequest request) {
		return WebUtils.getCleanParam(request, getCaptchaParam());
	}

	protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) {
		String username = getUsername(request);
		String password = getPassword(request);
		if (password==null){
			password = "";
		}
		boolean rememberMe = isRememberMe(request);
		String host = getHost(request);
		String captcha = getCaptcha(request);
		return new UsernamePasswordToken(username, password.toCharArray(), rememberMe, host, captcha);
	}

	@Override
	protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {
		if (e instanceof CaptchaException) {
			// 验证码错误
			request.setAttribute("error_msg", "验证码错误");
			request.setAttribute(getUsernameParam(), getUsername(request));
			request.setAttribute(getPasswordParam(), getPassword(request));
		} else {
			// 用户名或密码错误
			request.setAttribute("error_msg", "用户名或密码错误");
			request.setAttribute(getUsernameParam(), getUsername(request));
		}
		return super.onLoginFailure(token, e, request, response);
	}
}