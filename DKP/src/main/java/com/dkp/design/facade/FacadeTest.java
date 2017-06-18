package com.dkp.design.facade;

/**
 * Created by 15207 on 2017/6/18.
 */
public class FacadeTest {

    public static void main(String[] args) {
        Computer computer = new Computer();
        computer.start();
        computer.shutDown();
    }
}
