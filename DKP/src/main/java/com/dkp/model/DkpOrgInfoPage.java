package com.dkp.model;

import com.dkp.entity.DkpOrgInfo;

import java.util.List;

/**
 * Created by 半夏微凉 on 2017/3/15.
 */
public class DkpOrgInfoPage {
    private int sumPage;

    private int pageNo;

    private int pageNum;

    private List<DkpOrgInfo> dkpOrgInfoList;


    public int getSumPage() {
        return sumPage;
    }

    public void setSumPage(int sumPage) {
        this.sumPage = sumPage;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public List<DkpOrgInfo> getDkpOrgInfoList() {
        return dkpOrgInfoList;
    }

    public void setDkpOrgInfoList(List<DkpOrgInfo> dkpOrgInfoList) {
        this.dkpOrgInfoList = dkpOrgInfoList;
    }
}
