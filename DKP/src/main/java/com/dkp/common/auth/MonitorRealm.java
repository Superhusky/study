package com.dkp.common.auth;

import com.dkp.common.servlet.ValidateCodeServlet;
import com.dkp.entity.UserInfo;
import com.dkp.mapper.UserInfoMapper;
import com.dkp.service.UserInfoService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Set;

/**
 * Created by 15207 on 2017/4/16.
 */
@Service("monitorRealm")
public class MonitorRealm extends AuthorizingRealm {

    @Autowired
    private UserInfoService userInfoService;


    public MonitorRealm() {
        super();
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        Set<String> roleNames = new HashSet<>();
        Set<String> permissions = new HashSet<>();
        roleNames.add("admin");
        permissions.add("user.do?myjsp");
        permissions.add("login.do?main");
        permissions.add("login.do?logout");
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(roleNames);
        info.setStringPermissions(permissions);
        return info;
    }

    /**
     * 通过
     * @param authToken
     * @return
     * @throws AuthenticationException
     */
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken) authToken;
        Session session = SecurityUtils.getSubject().getSession();
        String code = (String) session.getAttribute(ValidateCodeServlet.VALIDATE_CODE);
        if (token.getCaptcha() == null || !token.getCaptcha().toUpperCase().equals(code)) {
            throw new CaptchaException("验证码错误.");
        }
        if (token != null ) {
            UserInfo userInfo = userInfoService.getUserByLoginName(token.getUsername());
            if (userInfo == null) {
                return null;
            }
            return new SimpleAuthenticationInfo(userInfo.getUserName(), userInfo.getPassword(), getName());
        }
        return null;
    }


    /**
     * 清除缓存信息
     * @param principal
     */
    public void clearCachedAuthorizationInfo(String principal) {
        SimplePrincipalCollection principals = new SimplePrincipalCollection(
                principal, getName());
        clearCachedAuthorizationInfo(principals);
    }
}
