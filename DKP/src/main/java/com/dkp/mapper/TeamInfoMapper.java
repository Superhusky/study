package com.dkp.mapper;

import com.dkp.entity.TeamInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by 15207 on 2017/4/15.
 */
public interface TeamInfoMapper {

    List<TeamInfo> selectTeamInfoList(@Param("gameId") int gameId,
                                      @Param("unionId") int unionId);
}
