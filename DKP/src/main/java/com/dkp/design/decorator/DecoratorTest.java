package com.dkp.design.decorator;

/**
 * Created by 15207 on 2017/6/14.
 */
public class DecoratorTest {

    public static void main(String[] args) {
        SourceAble sourceAble = new Source();
        Decorator decorator = new Decorator(sourceAble);
        decorator.SourceAble();
    }
}
