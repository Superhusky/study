package com.dkp.design.muchFactory;

/**
 * Created by 15207 on 2017/6/11.
 *
 * 多个工厂设计模式:在一个方法内,放置多个工厂方法,分别创建对象
 */
public class MuchFactory {

    public Sender produceMail() {
        return new MailSender();
    }

    public Sender produceMsn() {
        return new MsnSender();
    }
}
