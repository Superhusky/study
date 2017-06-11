package com.dkp.design.commonFactory;

/**
 * Created by 15207 on 2017/6/11.
 */
public class MailSender implements Sender {
    @Override
    public void sender() {
        System.out.println("this is mailSender");
    }
}
