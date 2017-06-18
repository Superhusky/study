package com.dkp.design.facade;

/**
 * Created by 15207 on 2017/6/18.
 */
public class Cpu implements FacadeFactory {

    @Override
    public void startUp() {
        System.out.println("cup start up");
    }

    @Override
    public void shutDown() {
        System.out.println("cup shut down");
    }

}

