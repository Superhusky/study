package com.dkp.mapper;

import com.dkp.entity.GameInfo;

import java.util.List;


/**
 * Created by 15207 on 2017/4/15.
 */
public interface GameInfoMapper {
    List<GameInfo> selectGameInfoList();
}
