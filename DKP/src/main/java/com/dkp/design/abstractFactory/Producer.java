package com.dkp.design.abstractFactory;

/**
 * Created by 15207 on 2017/6/11.
 *
 * 抽象工厂类;分为两块,一块是类,一块是工厂,当需要新增功能的时候只需要在实现类和工厂,不需要改变原有的代码
 * 所有的都是以两个抽象类为主体,子类也能按部就班的走
 */
public interface Producer {

    void producer();
}
