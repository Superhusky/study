package com.dkp.service;

import com.dkp.entity.UnionInfo;
import com.dkp.mapper.UnionInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 15207 on 2017/7/2.
 */
@Service
public class UnionInfoService {

    @Autowired
    private UnionInfoMapper unionInfoMapper;


    public List<UnionInfo> selectUnionInfoList(int gameId) {
        return unionInfoMapper.selectUnionInfoList(gameId);
    }
}
