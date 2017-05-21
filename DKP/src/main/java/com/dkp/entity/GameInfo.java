package com.dkp.entity;

/**
 * Created by 半夏微凉 on 2017/3/15.
 */
public class GameInfo {

    private int id;

    private String gameName;

    private byte gameType;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName;
    }

    public byte getGameType() {
        return gameType;
    }

    public void setGameType(byte gameType) {
        this.gameType = gameType;
    }
}
