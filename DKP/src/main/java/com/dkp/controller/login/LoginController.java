package com.dkp.controller.login;

import com.dkp.service.GameInfoService;
import com.dkp.service.UserInfoService;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by 半夏微凉 on 2017/3/1.
 */
@Controller
public class LoginController {

    @Autowired
    private UserInfoService userLoginService;

    @Autowired
    private GameInfoService gameInfoService;

    private static final Logger logger = org.slf4j.LoggerFactory.getLogger(LoginController.class);


    /**
     * 1、验证码问题
     * 2、Shiro问题
     * 3、主页设计
     *
     * @return 主页面
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String userLogin() {
        if (SecurityUtils.getSubject().isAuthenticated()) {
            logger.debug("post login: login successful.");
            // 已登录时重定向到shiro配置的success页面
            return "openDoor/integrate";
        }
        logger.debug("post login: login failed.");
        // 未登录时返回login页面
        return "openDoor/user_index";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "openDoor/user_index";
    }


    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String userIndex() {
        return "openDoor/user_index";
    }

    @RequestMapping(value = "/")
    public String root() {
        return "openDoor/integrate";
    }
}
