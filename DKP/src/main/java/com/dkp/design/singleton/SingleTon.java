package com.dkp.design.singleton;

/**
 * Created by 15207 on 2017/6/13.
 * 单例模式:能保证在一个jvm中,该对象只有一个实例存在
 * 好处:{
 *        某些类创建比较频繁,对于一个大型对象来说,很大的一笔系统开销
 *        省去了new操作符,降低了系统内存的使用频率,减轻gc压力
 *         保证唯一性,确保独立控制整个流程
 *       }
 */
public class SingleTon {
    //懒汉
    private class LazySingleTon {

        private LazySingleTon lazySingleTon;

        //私有构造方法
        private LazySingleTon() {

        }

        private LazySingleTon getInstance() {
            if (lazySingleTon == null) {
                lazySingleTon = new LazySingleTon();
            }
            return lazySingleTon;
        }

        //对于多线程的情况下
        //在方法上加上synchronized关键字,锁住的是对象.每次调用都是都要对对象上锁,只有在第一次调用的时候才会需要加锁？
        /*private synchronized LazySingleTon getInstance() {
            if (lazySingleTon == null) {
                lazySingleTon = new LazySingleTon();
            }
            return lazySingleTon;
        }*/

        //多线程下单例模式的加强版,有提升但是仍有问题
        //java指令在创建对象和赋值的时候是分开进行的,lazySingleTon = new LazySingleTon();这句话是分开的不能保证两个操作的先后顺序
        //
        /*private LazySingleTon getInstance() {
            if (lazySingleTon == null) {
                synchronized (lazySingleTon){
                    if (lazySingleTon ==null){
                        lazySingleTon = new LazySingleTon();
                    }
                }
            }
            return lazySingleTon;
        }*/
    }

    //饿汉
    private class HungrySingleTon {

        private HungrySingleTon() {

        }

        private HungrySingleTon hungrySingleTon = new HungrySingleTon();

        private HungrySingleTon getInstance() {
            return hungrySingleTon;
        }
    }

    //单例+线程的升级版(静态方法不能放于不是静态类下)
    //单例类使用内部类来维护单例的实现,jvm能保存一个类被加载的过程是线程互斥的.当第一次调用getInstance()的时候能够保证
    // threadSingleTon只创建一次,并且会保证把赋值给instance的内存初始化完毕
    /*{
        内部类是什么？
        jvm为什么能保证类加载过程是互斥的
    }*/
    private static class ThreadSingleTon {
        private ThreadSingleTon() {

        }

        private static class ThreadSingleTonFactory {
            private static ThreadSingleTon threadSingleTon = new ThreadSingleTon();
        }

        private ThreadSingleTon getInstance() {
            return ThreadSingleTonFactory.threadSingleTon;
        }
    }



}
