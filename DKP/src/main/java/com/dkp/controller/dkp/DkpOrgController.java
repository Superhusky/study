package com.dkp.controller.dkp;

import com.dkp.entity.Activity;
import com.dkp.entity.DkpOrgInfo;
import com.dkp.entity.TeamInfo;
import com.dkp.model.DkpOrgInfoPage;
import com.dkp.service.ActivityInfoService;
import com.dkp.service.TeamInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 半夏微凉 on 2017/3/15.
 */
@Controller
@RequestMapping("/console/dkp")
public class DkpOrgController {

    @Autowired
    private TeamInfoService teamInfoService;

    @Autowired
    private ActivityInfoService activityInfoService;

    @RequestMapping("/list")
    @ResponseBody
    public List<DkpOrgInfoPage> getDkpList() {
        List<DkpOrgInfo> dkpOrgInfoArrayList = new ArrayList<>();
        List<DkpOrgInfoPage> dkpOrgInfoPageArrayList = new ArrayList<>();
        return dkpOrgInfoPageArrayList;

    }

    @RequestMapping("/team")
    @ResponseBody
    public List<TeamInfo> selectTeamInfoList(@RequestParam("gameId") Integer gameId) {
        List<TeamInfo> teamInfoList = teamInfoService.selectTeamInfoList(gameId);
        return teamInfoList;
    }

    @RequestMapping("/activity")
    @ResponseBody
    public List<Activity> selectActivityInfoList(@RequestParam("gameId") Integer gameId,
                                                 @RequestParam("teamId") Integer teamId) {
        List<Activity> activityList = activityInfoService.selectActivityInfoList(gameId, teamId);
        return activityList;
    }
}
