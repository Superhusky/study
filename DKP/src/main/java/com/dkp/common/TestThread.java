package com.dkp.common;

/**
 * Created by 15207 on 2017/4/26.
 */
public class TestThread implements Runnable {



    @Override
    public void run() {
        StudentInfoSingleton studentInfoSingleton = StudentInfoSingleton.getInstance();
        int id = studentInfoSingleton.getId();
        System.out.println(id);
    }


    public static void main(String[] args) {
        TestThread testThread = new TestThread();
        testThread.run();
    }
}
