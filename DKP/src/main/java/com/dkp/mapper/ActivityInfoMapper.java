package com.dkp.mapper;

import com.dkp.entity.Activity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by 15207 on 2017/4/15.
 */
public interface ActivityInfoMapper {

    List<Activity> selectActivityInfoList(@Param("gameId") Integer gameId,@Param("teamId") Integer teamId);
}
