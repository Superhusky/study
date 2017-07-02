package com.dkp.mapper;

import com.dkp.entity.UnionInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by 15207 on 2017/7/2.
 */
public interface UnionInfoMapper {

    List<UnionInfo> selectUnionInfoList(@Param("gameId") int gameId);
}
