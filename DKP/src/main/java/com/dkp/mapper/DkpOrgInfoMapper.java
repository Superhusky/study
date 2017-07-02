package com.dkp.mapper;

import com.dkp.entity.DkpOrgInfo;
import com.dkp.model.DkpInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by 15207 on 2017/6/28.
 */
public interface DkpOrgInfoMapper {

    List<DkpOrgInfo> getAllOrgInfo();

    List<DkpInfo> selectOrgInfoByActivityId(@Param("gameId") int gameId,
                                            @Param("teamId") Integer teamId,
                                            @Param("activityId") Integer activityId,
                                            @Param("start") int start,
                                            @Param("size") int size);

    int countDkpInfoByActivityId(@Param("gameId") int gameId,
                                 @Param("teamId") Integer teamId,
                                 @Param("activityId") Integer activityId);


}
