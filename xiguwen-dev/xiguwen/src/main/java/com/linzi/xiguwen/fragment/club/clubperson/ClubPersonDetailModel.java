package com.linzi.xiguwen.fragment.club.clubperson;

import com.linzi.xiguwen.bean.SynamicdetailsBean;

import java.util.List;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/28  12:08
 *
 * @author luyongjiang
 * @version 1.0
 */
public interface ClubPersonDetailModel {
    List<SynamicdetailsBean.ZanlistBean> getZanList();

    List<SynamicdetailsBean.CommentlistBean> getCommentList();
}
