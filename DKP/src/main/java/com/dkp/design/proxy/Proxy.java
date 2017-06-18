package com.dkp.design.proxy;

/**
 * Created by 15207 on 2017/6/18.
 * 代理模式就相当于是对象适配器,持有某个对象的实例,然后对这个实例进行加工
 * 应用场景;{
 *  如果已有方法的使用需要对原有方法进行改进
 *  1、修改原有方法,但是违反了对扩展开放,对修改关闭的原则
 *  2、采用代理类对原有方法调用,并对结果进行控制
 *  使用代理模式可以将功能划分更加清晰？
 * }
 */
public class Proxy implements SourceAble{

    private SourceAble sourceAble;

    public Proxy(SourceAble sourceAble) {
        super(); //这个super有什么用？
        this.sourceAble = sourceAble;
    }

    @Override
    public void Source() {
        before();
        sourceAble.Source();
        after();
    }

    private void after() {
        System.out.println("this is after");
    }

    private void before() {
        System.out.println("this is before");
    }
}
