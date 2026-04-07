package com.linzi.xiguwen.fragment.multistage.bean;

import java.util.ArrayList;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/26  17:27
 *
 * @author luyongjiang
 * @version 1.0
 */
public class MultistageTandemBean {
    private ArrayList<FragmentAndNavigationBean> navigationBeans = new ArrayList<>();
    private HeadTitleFragmentAndListenerBean titleBean = new HeadTitleFragmentAndListenerBean();
    private ViewHeightBean mHeightBean = new ViewHeightBean();

    public ArrayList<FragmentAndNavigationBean> getNavigationBeans() {
        return navigationBeans;
    }

    public MultistageTandemBean setNavigationBeans(ArrayList<FragmentAndNavigationBean> navigationBeans) {
        this.navigationBeans = navigationBeans;
        return this;
    }

    public HeadTitleFragmentAndListenerBean getTitleBean() {
        return titleBean;
    }

    public MultistageTandemBean setTitleBean(HeadTitleFragmentAndListenerBean titleBean) {
        this.titleBean = titleBean;
        return this;
    }

    public ViewHeightBean getHeightBean() {
        return mHeightBean;
    }

    /**
     * 高度自适应,所以暂时不用传高度了
     * @param heightBean
     * @return
     */
    @Deprecated
    public MultistageTandemBean setHeightBean(ViewHeightBean heightBean) {
        mHeightBean = heightBean;
        return this;
    }

    public MultistageTandemBean addNavigation(FragmentAndNavigationBean fragmentAndNavigationBean) {
        if (navigationBeans != null)
            navigationBeans.add(fragmentAndNavigationBean);
        return this;
    }


}
