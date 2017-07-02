package com.dkp.service;

import com.dkp.entity.GameInfo;
import com.dkp.mapper.GameInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 15207 on 2017/4/15.
 */
@Service
public class GameInfoService {

    @Autowired
    private GameInfoMapper gameInfoMapper;

    public List<GameInfo> selectGameInfoList(){
        return gameInfoMapper.selectGameInfoList();
    }
}
