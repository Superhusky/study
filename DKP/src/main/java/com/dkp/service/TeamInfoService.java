package com.dkp.service;

import com.dkp.entity.TeamInfo;
import com.dkp.mapper.TeamInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 15207 on 2017/4/15.
 */
@Service
public class TeamInfoService {

    @Autowired
    private TeamInfoMapper teamInfoMapper;

    public List<TeamInfo> selectTeamInfoList(int gameId, Integer unionId){
        return teamInfoMapper.selectTeamInfoList(gameId, unionId);
    }
}
