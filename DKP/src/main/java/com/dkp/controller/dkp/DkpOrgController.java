package com.dkp.controller.dkp;

import com.dkp.entity.*;
import com.dkp.model.DkpInfo;
import com.dkp.model.DkpInfoPage;
import com.dkp.model.DkpOrgInfoPage;
import com.dkp.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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

    @Autowired
    private DkpOrgInfoService dkpOrgInfoService;

    @Autowired
    private GameInfoService gameInfoService;

    @Autowired
    private UnionInfoService unionInfoService;

    @RequestMapping()
    public ModelAndView goDkpControllerIndex() {
        ModelAndView modelAndView = new ModelAndView();
        List<GameInfo> gameInfoList = gameInfoService.selectGameInfoList();
        modelAndView.addObject("gameInfoList", gameInfoList);
        modelAndView.setViewName("openDoor/admin_main");
        return modelAndView;
    }


    @RequestMapping("/list")
    @ResponseBody
    public DkpInfoPage getDkpList(@RequestParam("gameId") int gameId,
                                  @RequestParam("teamId") Integer teamId,
                                  @RequestParam("activityId") Integer activityId,
                                  @RequestParam("pageNo") int pageNo,
                                  @RequestParam("pageNum") int pageNum) {
        int dkpInfoCount = dkpOrgInfoService.countDkpInfoByActivityId(gameId, teamId, activityId);
        DkpInfoPage dkpOrgInfoPage = new DkpInfoPage();
        if (dkpInfoCount > 0) {
            List<DkpInfo> dkpInfoList = dkpOrgInfoService.selectOrgInfoByActivityId(gameId, teamId, activityId, (pageNo - 1) * pageNum, pageNum);
            dkpOrgInfoPage.setDkpInfoList(dkpInfoList);
        } else {
            dkpOrgInfoPage.setDkpInfoList(new ArrayList<DkpInfo>());
        }
        dkpOrgInfoPage.setPageNo(pageNo);
        dkpOrgInfoPage.setPageNum(pageNum);
        dkpOrgInfoPage.setSumPage(dkpInfoCount % pageNum == 0 ? dkpInfoCount / pageNum : (dkpInfoCount / pageNum) + 1);//双目表达式
        return dkpOrgInfoPage;
    }

    @RequestMapping("/union")
    @ResponseBody
    public List<UnionInfo> selectUnionInfoList(@RequestParam(value = "gameId", required = true) int gameId) {
        return unionInfoService.selectUnionInfoList(gameId);
    }

    @RequestMapping("/team")
    @ResponseBody
    public List<TeamInfo> selectTeamInfoList(@RequestParam(value = "gameId", required = true) int gameId,
                                             @RequestParam(value = "unionId", required = true) Integer unionId) {
        List<TeamInfo> teamInfoList = teamInfoService.selectTeamInfoList(gameId, unionId);
        return teamInfoList;
    }

    @RequestMapping("/activity")
    @ResponseBody
    public List<Activity> selectActivityInfoList(@RequestParam("gameId") Integer gameId,
                                                 @RequestParam("teamId") Integer teamId,
                                                 @RequestParam("unionId") Integer unionId) {
        List<Activity> activityList = activityInfoService.selectActivityInfoList(gameId, teamId, unionId);
        return activityList;
    }
}
