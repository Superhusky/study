package com.dkp.service;

import com.dkp.common.auth.Digests;
import com.dkp.common.auth.UsernamePasswordToken;
import com.dkp.common.servlet.ValidateCodeServlet;
import com.dkp.entity.GameInfo;
import com.dkp.entity.UserInfo;
import com.dkp.mapper.UserInfoMapper;
import com.dkp.service.GameInfoService;
import com.dkp.utils.EncodeUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * Created by 半夏微凉 on 2017/3/1.
 */
@Service
public class UserInfoService {

    private static final String LOGIN_ADMIN = "1";

    private static final int SALT_SIZE = 8;

    private static final int HASH_INTERATIONS = 1024;

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Autowired
    private GameInfoService gameInfoService;

    public int userLogin(String name, String password) {
        System.out.println("我通过了测试");
        return userInfoMapper.findByNameAndPassword(name, password);

    }


    public UserInfo getUserByLoginName(String loginName) {
        return userInfoMapper.findByLoginName(loginName, LOGIN_ADMIN);
    }

    /**
     * 判断用户是否属于本系统
     * @param UserName
     * @param password
     * @return
     */
    private boolean judgeByNameAndPassword(String UserName, String password) {
        return (userInfoMapper.judgeByNameAndPassword(UserName, password) > 0) ? true : false;
    }

    /**
     * 生成安全的密码，生成随机的16位salt并经过1024次 sha-1 hash
     */
    public static String encryptPassword(String plainPassword) {
        byte[] salt = Digests.generateSalt(SALT_SIZE);
        byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt, HASH_INTERATIONS);
        return EncodeUtils.encodeHex(salt) + EncodeUtils.encodeHex(hashPassword);
    }

    /**
     * 验证密码
     *
     * @param plainPassword 明文密码
     * @param password      密文密码
     * @return 验证成功返回true
     */
    public static boolean validatePassword(String plainPassword, String password) {
        byte[] salt = EncodeUtils.decodeHex(password.substring(0, 16));
        byte[] hashPassword = Digests.sha1(plainPassword.getBytes(), salt, HASH_INTERATIONS);
        return password.equals(EncodeUtils.encodeHex(salt) + EncodeUtils.encodeHex(hashPassword));
    }

    /**
     * 登录验证
     * @param loginName
     * @param password
     * @return
     */
    public ModelAndView loginValidate(String loginName, String password) {
        /*boolean isSystemUser = judgeByNameAndPassword(loginName, password);
        String encryptPassword = encryptPassword(password);*/
        Subject currentUser = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken();
        Session session = SecurityUtils.getSubject().getSession();
        String validate = (String)session.getAttribute(ValidateCodeServlet.VALIDATE_CODE);
        token.setCaptcha(validate);
        token.setUsername(loginName);
        token.setPassword(password.toCharArray()); //转化成字节数组
        token.setRememberMe(true);
        currentUser.login(token);
        ModelAndView modelAndView = new ModelAndView();
        if (currentUser.isAuthenticated()) {
            List<GameInfo> gameInfoList = gameInfoService.selectGameInfoList();
            modelAndView.setViewName("openDoor/admin_main");
            modelAndView.addObject("gameInfoList", gameInfoList);
        } else {
            modelAndView.addObject("loginName", loginName);
            modelAndView.addObject("password", password);
            modelAndView.addObject("error_msg", "用户名或者密码错误");
            modelAndView.setViewName("openDoor/user_index");
        }

        /*if (loginName.isEmpty() || password.isEmpty()) {
            modelAndView.addObject("loginName", loginName);
            modelAndView.addObject("password", password);
            modelAndView.addObject("error_msg", "用户名或者密码为空");
            modelAndView.setViewName("openDoor/user_login");
        } else if (isSystemUser) {
            List<GameInfo> gameInfoList = gameInfoService.selectGameInfoList();
            modelAndView.setViewName("openDoor/admin_main");
            modelAndView.addObject("msg", "success");
            modelAndView.addObject("gameInfoList", gameInfoList);
        } else {
            modelAndView.addObject("loginName", loginName);
            modelAndView.addObject("password", password);
            modelAndView.addObject("error_msg", "用户名或者密码错误");
            modelAndView.setViewName("openDoor/user_login");
        }*/
        return modelAndView;
    }

    /**
     * 安全退出
     */
    public void logout() {
        Subject subject = SecurityUtils.getSubject();
        if (subject.isAuthenticated()) {
            SecurityUtils.getSubject().logout();
        }
    }

    /*public static void main(String[] args) {
        //创建shiro工厂
        Factory<SecurityManager> factory = new IniSecurityManagerFactory("classpath:shiro.ini");
        //获得shiro工厂实例
        SecurityManager securityManager = factory.getInstance();
        //绑定shrio工厂实例
        SecurityUtils.setSecurityManager(securityManager);
        //获得当前用户
        Subject currentUser = SecurityUtils.getSubject();
        //令牌
        UsernamePasswordToken token = new UsernamePasswordToken("admin", "1234");
        try {
            currentUser.login(token);
            System.out.println("登录成功");
        } catch (AuthenticationException e) {
            e.printStackTrace();
            System.out.println("登录失败");
        }
    }*/
}
