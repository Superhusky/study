package com.dkp.mapper;

import org.apache.ibatis.annotations.Param;

/**
 * Created by 15207 on 2017/4/12.
 */
public interface SystemLogMapper {

    int insert(@Param("logContent") String logContent);
}
