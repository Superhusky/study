package com.dkp.design.abstractFactory;

/**
 * Created by 15207 on 2017/6/11.
 */
public class MailProducer implements Producer{



    @Override
    public void producer() {
        MailSender mailSender = new MailSender();
        mailSender.Sender();
    }
}
