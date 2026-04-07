package com.linzi.xiguwen.fragment.club;

import androidx.fragment.app.Fragment;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.NewBaseFragment;
import com.linzi.xiguwen.bean.ShetuanIndexBean;
import com.linzi.xiguwen.ui.NewClubDetailsModel;
import com.linzi.xiguwen.utils.GlideLoad;

import butterknife.BindView;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/27  12:06
 *
 * @author luyongjiang
 * @version 1.0
 */
public class HeadFragment extends NewBaseFragment {

    public static Fragment create() {
        return new HeadFragment();
    }


    @Override
    public int onLayoutId() {
        return R.layout.fr_head;
    }

    @BindView(R.id.iv_img)
    ImageView ivBg;
    @BindView(R.id.iv_head_img)
    ImageView ivHead;
    @BindView(R.id.tv_name)
    TextView tvName;
    @BindView(R.id.tv_location)
    TextView tvLocation;
    @BindView(R.id.tv_look)
    TextView tvLook;

    @Override
    public void initView() {
        ShetuanIndexBean.InfoBean headBean = ((NewClubDetailsModel) getActivity()).getHeadBean();
        GlideLoad.GlideLoadImg(headBean.getAppphotourl(), ivBg);
        GlideLoad.GlideLoadCircle(headBean.getLogourl(), ivHead);
        tvName.setText(headBean.getName());
        tvLocation.setText(headBean.getAddress());
        tvLook.setText("浏览 " + headBean.getClicked());
    }
}
