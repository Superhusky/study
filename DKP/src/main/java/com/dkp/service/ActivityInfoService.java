package com.dkp.service;

import com.dkp.entity.Activity;
import com.dkp.mapper.ActivityInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 15207 on 2017/4/15.
 */
@Service
public class ActivityInfoService {

    @Autowired
    private ActivityInfoMapper activityInfoMapper;

    public List<Activity> selectActivityInfoList(Integer gameId, Integer teamId, Integer unionId) {
        return activityInfoMapper.selectActivityInfoList(gameId, teamId, unionId);
    }
}
