package test.com.dkp.controller.login; 

import com.dkp.service.UserInfoService;
import org.junit.Test;
import org.junit.Before; 
import org.junit.After;

/** 
* UserLoginController Tester. 
* 
* @author <Authors name> 
* @since <pre>���� 3, 2017</pre> 
* @version 1.0 
*/ 
public class loginControllerTest {


    @Before
    public void before() throws Exception {
    }

    @After
    public void after() throws Exception {
} 

/** 
* 
* Method: userLogin() 
* 
*/ 
@Test
public void testUserLogin() throws Exception {
    String UserName = "admin";
    String password = "1";
    UserInfoService userLoginService = new UserInfoService();
    userLoginService.userLogin(UserName,password);
} 


} 
