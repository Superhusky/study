package com.dkp.common;

/**
 * Created by 15207 on 2017/4/26.
 */
public class StudentInfoSingleton {

    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public static void setInstance(StudentInfoSingleton instance) {
        StudentInfoSingleton.instance = instance;
    }

    private static StudentInfoSingleton instance;

    private StudentInfoSingleton() {}

    public static StudentInfoSingleton getInstance() {
        if (instance == null) {
            instance = new StudentInfoSingleton();
        }
        return instance;
    }
}
