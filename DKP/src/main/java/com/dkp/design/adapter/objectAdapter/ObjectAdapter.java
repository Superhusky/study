package com.dkp.design.adapter.objectAdapter;

/**
 * Created by 15207 on 2017/6/14.
 * 对象适配器:持有Source类的实例
 */
public class ObjectAdapter implements Target {

    private Source source;

    /**
     * 如果不重写构造函数的话,下面的方法会报空指针异常
     * @param source
     */
    public ObjectAdapter(Source source) {
        //super();？为什么要调用父类方法？
        this.source =source;
    }

    @Override
    public void Target() {
        System.out.println("this is a target");
    }

    @Override
    public void Source() {
        source.Source();
    }
}
