package com.dkp.model;

import java.util.List;

/**
 * Created by 15207 on 2017/7/2.
 */
public class DkpInfoPage {

    private int sumPage;

    private int pageNo;

    private int pageNum;

    private List<DkpInfo> dkpInfoList;

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

    public List<DkpInfo> getDkpInfoList() {
        return dkpInfoList;
    }

    public void setDkpInfoList(List<DkpInfo> dkpInfoList) {
        this.dkpInfoList = dkpInfoList;
    }
}
