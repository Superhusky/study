package com.dkp.mapper;

import com.dkp.entity.UserInfo;
import org.apache.ibatis.annotations.Param;

/**
 * Created by 半夏微凉 on 2017/3/1.
 */
public interface UserInfoMapper {

    int findByNameAndPassword(@Param("loginName") String loginName,
                              @Param("password") String password);

    UserInfo findByLoginName(@Param("loginName") String loginName,
                             @Param("roleGroupId") String roleGroupId);

    int judgeByNameAndPassword(@Param("loginName") String loginName,
                               @Param("password") String password);
}
