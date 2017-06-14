package com.dkp.design.adapter.classAdapter;

/**
 * Created by 15207 on 2017/6/14.
 */
public class AdapterTest {

    public static void main(String[] args) {
        Target target = new ClassAdapter();
        target.Target();
        target.Source();
    }
}
