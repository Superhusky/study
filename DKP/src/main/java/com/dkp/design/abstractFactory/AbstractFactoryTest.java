package com.dkp.design.abstractFactory;

/**
 * Created by 15207 on 2017/6/11.
 */
public class AbstractFactoryTest {

    public static void main(String[] args) {
        Producer mailProducer = new MailProducer();
        Producer msnProducer = new MsnProducer();
        mailProducer.producer();
        msnProducer.producer();
    }
}
