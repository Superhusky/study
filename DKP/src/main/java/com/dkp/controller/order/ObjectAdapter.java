package com.dkp.controller.order;

/**
 * Created by 15207 on 2017/5/15.
 */
public class ObjectAdapter implements PsTwo{

    private Usb usb;

    public ObjectAdapter (Usb usb) {
        this.usb = usb;
    }
    @Override
    public void isPsTwo() {
        usb.isUsb();
    }

    //接口比抽象类还要抽象,所以作为接口的Usb可以被当作是Usber的父类,所以这边可以用Usber做一个对象,去声名
    public static void main(String[] args) {
        ObjectAdapter p = new ObjectAdapter(new Usber());
        p.isPsTwo();
    }
}
