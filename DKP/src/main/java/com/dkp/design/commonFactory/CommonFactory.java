package com.dkp.design.commonFactory;

/**
 * Created by 15207 on 2017/6/11.
 * 普通工厂模式:就是建立一个工厂类,对实现了同一接口的一些类进行实例的创建
 *
 */
public class CommonFactory {

    public Sender method(String type) {
        if (type == "mail") {
            return new MailSender();
        } else if (type == "msn") {
            return new MailSender();
        }else {
            System.out.println("null");
            return null;
        }
    }
}
