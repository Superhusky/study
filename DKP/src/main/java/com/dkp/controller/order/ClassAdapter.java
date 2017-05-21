package com.dkp.controller.order;

/**
 * Created by 15207 on 2017/5/15.
 */
public class ClassAdapter extends Usber implements PsTwo {
    @Override
    public void isPsTwo() {
        isUsb();
        /*isPsTwo();*/
    }


    public static void main(String[] args) {
        ClassAdapter p = new ClassAdapter();
        p.isPsTwo();
    }
}
