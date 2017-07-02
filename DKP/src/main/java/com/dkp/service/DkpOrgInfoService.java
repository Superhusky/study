package com.dkp.service;

import com.dkp.entity.DkpOrgInfo;
import com.dkp.mapper.DkpOrgInfoMapper;
import com.dkp.model.DkpInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 15207 on 2017/6/28.
 */
@Service
public class DkpOrgInfoService {

    @Autowired
    private DkpOrgInfoMapper dkpOrgInfoMapper;

    public List<DkpOrgInfo> getAllOrgInfo() {
        return dkpOrgInfoMapper.getAllOrgInfo();
    }

    public List<DkpInfo> selectOrgInfoByActivityId(int gameId, Integer teamId, Integer activityId, int start, int size) {
        return dkpOrgInfoMapper.selectOrgInfoByActivityId(gameId, teamId, activityId, start, size);
    }

    public int countDkpInfoByActivityId(int gameId, Integer teamId, Integer activityId) {
        return dkpOrgInfoMapper.countDkpInfoByActivityId(gameId, teamId, activityId);
    }

}
