package com.dkp.design.facade;

/**
 * Created by 15207 on 2017/6/18.
 *
 * 外观模式:将多个类进行封装成一个类,将类的关系放于一个类中,减少耦合
 */
public class Computer {

    private Cpu cpu;

    private Disk disk;

    private Memory memory;

    public Computer() {
        cpu = new Cpu();
        disk = new Disk();
        memory = new Memory();
    }

    public void start() {
        cpu.startUp();
        memory.startUp();
        disk.startUp();
    }

    public void shutDown() {
        cpu.shutDown();
        memory.shutDown();
        disk.shutDown();
    }
}
