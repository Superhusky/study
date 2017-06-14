package com.dkp.design.adapter.objectAdapter;

/**
 * Created by 15207 on 2017/6/14.
 */
public class AdapterTest {

    public static void main(String[] args) {
        Source  source = new Source();

        ObjectAdapter objectAdapter = new ObjectAdapter(source);
        objectAdapter.Source();
        objectAdapter.Target();
    }
}
