package com.dkp.common.auth;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.UserFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicLong;

/**
 * Created by liyong on 16/6/28.
 */
public class AuthUserFilter extends UserFilter {


    private static Logger log = LoggerFactory.getLogger(AuthUserFilter.class);

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        Subject subject = getSubject(request, response);
        if (subject.getPrincipal() == null) {
            this.saveRequestAndRedirectToLogin(request, response);
        }
        /*if ("XMLHttpRequest".equals(WebUtils.toHttp(request).getHeader("X-Requested-With"))) {
            if (log.isTraceEnabled()) {
                log.trace("Attempting to submit a ajax request which requires authentication.  Response with status code of 401.");
            }
            WebUtils.toHttp(response).setStatus(401);
        } else {
            if (log.isTraceEnabled()) {
                log.trace("Attempting to access a path which requires authentication.  Forwarding to the Authentication url [" + this.getLoginUrl() + "]");
            }
            this.saveRequestAndRedirectToLogin(request, response);
        }*/
        return false;
    }


    public static void main(String[] args) {
        double sum = 1.0;
        int num = 0;
        for (double price = 0.1; price < sum; price += 0.1) {
            sum -= price;
            num ++;
        }
        System.out.println(num);
    }
}
