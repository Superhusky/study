package com.dkp.design.abstractFactory;

/**
 * Created by 15207 on 2017/6/11.
 */
public class MsnProducer implements Producer{

    @Override
    public void producer() {
        MsnSender msnSender = new MsnSender();
        msnSender.Sender();

    }
}
