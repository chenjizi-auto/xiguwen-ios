package com.linzi.xiguwen.ui;

import com.linzi.xiguwen.bean.ShetuanIndexBean;
import com.linzi.xiguwen.bean.WeddingRingBean;

import java.util.List;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/27  14:20
 *
 * @author luyongjiang
 * @version 1.0
 */
public interface NewClubDetailsModel {
    List<ShetuanIndexBean.DynamiclistBean> getActionList();

    ShetuanIndexBean.InfoBean getHeadBean();
}
