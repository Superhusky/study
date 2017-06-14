package com.dkp.design.adapter.classAdapter;

/**
 * Created by 15207 on 2017/6/14.
 * 类适配器模式:将某个类的接口转换成客户端期望的另一个接口表示
 *
 * 将source中方法放合并到target接口中
 */
public class ClassAdapter extends Source implements Target{



    @Override
    public void Target() {
        System.out.println("this is a classAdapter");
    }
}
