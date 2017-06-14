package com.dkp.design.decorator;

/**
 * Created by 15207 on 2017/6/14.
 * 装饰模式:给一个对象增加新的功能,动态的,要求装饰对象和被装饰对象是实现同一个接口,装饰对象持有被装饰对象实例
 * {
 *      需要扩展一个类的功能。
        动态的为一个对象增加功能，而且还能动态撤销。（继承不能做到这一点，继承的功能是静态的，不能动态增删。
        缺点：产生过多相似的对象，不易排错！
 * }
 */
public class Decorator implements SourceAble {
    //这里使用接口作为私有属性的好处是;方便拓展面向接口编程,而不是只针对该接口下的某一个类
    private SourceAble source;

    public Decorator(SourceAble source) {
        super();
        this.source = source;
    }

    @Override
    public void SourceAble() {
        System.out.println("before");
        source.SourceAble();
        System.out.println("after");
    }
}
