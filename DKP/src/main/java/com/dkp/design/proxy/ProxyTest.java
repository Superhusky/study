package com.dkp.design.proxy;

/**
 * Created by 15207 on 2017/6/18.
 */
public class ProxyTest {

    public static void main(String[] args) {
        Source source = new Source();
        Proxy proxy = new Proxy(source);
        proxy.Source();
    }
}
