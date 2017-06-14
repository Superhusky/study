package com.dkp.design.prototype;

/**
 * Created by 15207 on 2017/6/13.
 * 原型模式:将对象作为一个原型,然后对其进行拷贝,复制产生一个和原对象类似的对象.
 * 原型类只需要实现Cloneable,重写clone方法
 */
public class Prototype implements Cloneable{

    public Object clone() throws CloneNotSupportedException{
        Prototype prototype = (Prototype)super.clone();
        return prototype;
    }

    /*{
        浅复制：将一个对象复制后，基本数据类型的变量都会重新创建，而引用类型，指向的还是原对象所指向的。
        深复制：将一个对象复制后，不论是基本数据类型还有引用类型，都是重新创建的。简单来说，
        就是深复制进行了完全彻底的复制，而浅复制不彻底。
    }*/

}
