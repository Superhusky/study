package com.dkp.design.commonFactory;

/**
 * Created by 15207 on 2017/6/11.
 */
public class CommonFactoryTest {

    public static void main(String[] args) {
        CommonFactory f = new CommonFactory();
        f.method("mail");
        f.method("msn");
        f.method(null);
    }
}
