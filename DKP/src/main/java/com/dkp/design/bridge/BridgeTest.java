package com.dkp.design.bridge;

/**
 * Created by 15207 on 2017/6/18.
 */
public class BridgeTest {


    public static void main(String[] args) {
        Bridge bridge = new Mybridge();
        SourceOne sourceOne = new SourceOne();
        bridge.setSourceAble(sourceOne);
        bridge.method();

        SourceTwo sourceTwo = new SourceTwo();
        bridge.setSourceAble(sourceTwo);
        bridge.method();
    }
}
