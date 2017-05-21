package com.dkp.common;

/**
 * Created by 15207 on 2017/4/26.
 */
public enum EnumTest {
    LR(1, 1), FUJI(1, 1), PIPPIN(1, 1), GRANNU_SWITH(1, 1);

    private final int i;
    private final int j;

    EnumTest(int i, int j) {
        this.i = i;
        this.j = j;
    }

    public static void main(String[] args) {
        EnumTest enumTest = EnumTest.LR;
        EnumText enumText = EnumText.FUJI;
        /*enumTest == enumText;*/
        System.out.println(enumTest.equals(enumText));
        System.out.println(enumTest.toString());
    }
}
