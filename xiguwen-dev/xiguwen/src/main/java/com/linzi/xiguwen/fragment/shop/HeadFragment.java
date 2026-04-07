package com.linzi.xiguwen.fragment.shop;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import androidx.fragment.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.NewBaseFragment;
import com.linzi.xiguwen.bean.ShopUserDetailsBean;
import com.linzi.xiguwen.ui.LoginActivity;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
import com.linzi.xiguwen.utils.ArcImageView;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.NToast;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by pc on 2018/3/29.
 */

public class HeadFragment extends NewBaseFragment {
    @BindView(R.id.aiv_img)
    ArcImageView aivImg;
    @BindView(R.id.iv_head_img)
    ImageView ivHeadImg;
    @BindView(R.id.ll_head)
    LinearLayout llHead;
    @BindView(R.id.tv_name)
    TextView tvName;
    @BindView(R.id.iv_rz_cx)
    ImageView ivRzCx;
    @BindView(R.id.iv_rz_pt)
    ImageView ivRzPt;
    @BindView(R.id.iv_rz_xy)
    ImageView ivRzXy;
    @BindView(R.id.tv_team_name)
    TextView tvTeamName;
    @BindView(R.id.iv_zz)
    ImageView ivZz;
    @BindView(R.id.iv_hg)
    ImageView ivHg;
    @BindView(R.id.iv_zs)
    ImageView ivZs;
    @BindView(R.id.iv_xx)
    ImageView ivXx;
    @BindView(R.id.iv_hq)
    ImageView ivHq;
    @BindView(R.id.tv_see)
    TextView tvSee;
    @BindView(R.id.tv_chengjiao)
    TextView tvChengjiao;
    @BindView(R.id.tv_haoping)
    TextView tvHaoping;
    @BindView(R.id.tv_location)
    TextView tvLocation;
    @BindView(R.id.iv_call)
    ImageView ivCall;
    @BindView(R.id.tv_fans)
    TextView tvFans;
    @BindView(R.id.iv_rz_sm)
    ImageView ivRzSm;

    private ArrayList<ImageView> imageViewList;
    private String phonenum;

    public static Fragment create() {
        return new HeadFragment();
    }

    @Override
    public int onLayoutId() {
        return R.layout.mall_head_fr_layout;
    }

    @Override
    public void initView() {
        imageViewList = new ArrayList<>();
        imageViewList.add(ivZz);
        imageViewList.add(ivHg);
        imageViewList.add(ivZs);
        imageViewList.add(ivXx);
        imageViewList.add(ivHq);
        ShopUserDetailsBean.UserBean userBean = ((NewMallDetailsActivity) getActivity()).getUserBean();
        ShopUserDetailsBean.UserinfoBean userinfoBean = ((NewMallDetailsActivity) getActivity()).getUserinfoBean();
        phonenum = userBean.getMobile();
        GlideLoad.GlideLoadImg(userinfoBean.getBackground(), aivImg);
        GlideLoad.GlideLoadCircle(userBean.getHead(), ivHeadImg);
        tvName.setText(userBean.getNickname() + "");
        ivRzXy.setVisibility(View.VISIBLE);
        switch (userinfoBean.getXueyuan()) {
            case 6:
                ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan1);
                break;
            case 7:
                ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan2);
                break;
            case 8:
                ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan3);
                break;
            case 9:
                ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan4);
                break;
            case 10:
                ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan5);
                break;
            case 11:
                ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan6);
                break;
            case 12:
                ivRzXy.setBackgroundResource(R.mipmap.icon_xueyuan7);
                break;
            case 13:
                ivRzXy.setBackgroundResource(R.mipmap.icon_xing1);
                break;
            case 14:
                ivRzXy.setBackgroundResource(R.mipmap.icon_xing2);
                break;
            case 15:
                ivRzXy.setBackgroundResource(R.mipmap.icon_xing3);
                break;
            case 16:
                ivRzXy.setBackgroundResource(R.mipmap.icon_xing4);
                break;
            case 17:
                ivRzXy.setBackgroundResource(R.mipmap.icon_xing5);
                break;
            case 18:
                ivRzXy.setBackgroundResource(R.mipmap.icon_xing6);
                break;
            case 19:
                ivRzXy.setBackgroundResource(R.mipmap.icon_xing7);
                break;
            default:
                ivRzXy.setVisibility(View.GONE);
                break;
        }

        if ((userinfoBean.getShiming() == 1)) {
            ivRzSm.setVisibility(View.VISIBLE);
        } else {
            ivRzSm.setVisibility(View.GONE);
        }

        if (userinfoBean.getSincerity() == 1) {
            ivRzCx.setVisibility(View.VISIBLE);
        } else {
            ivRzCx.setVisibility(View.GONE);
        }

        if (userinfoBean.getPlatform() == 1) {
            ivRzPt.setVisibility(View.VISIBLE);
        } else {
            ivRzPt.setVisibility(View.GONE);
        }
        if (userinfoBean.getAssociation() != null) {
            tvTeamName.setText("" + userinfoBean.getAssociation());
        } else {
            tvTeamName.setText("");
        }


        switch (userBean.getXinyu().getB()) {
            case "1":
                ctrlCredibility(1, userBean.getXinyu().getA());
                break;
            case "2":
                ctrlCredibility(2, userBean.getXinyu().getA());
                break;
            case "3":
                ctrlCredibility(3, userBean.getXinyu().getA());
                break;
            case "4":
                ctrlCredibility(4, userBean.getXinyu().getA());
                break;
            case "5":
                ctrlCredibility(5, userBean.getXinyu().getA());
                break;
        }

        tvSee.setText("浏览 " + userBean.getPv());
        tvChengjiao.setText("成交 " + userBean.getNum());
        tvHaoping.setText("好评 " + userBean.getGoodscore());
        tvFans.setText("粉丝 " + userBean.getFans());
        tvLocation.setText(userinfoBean.getDizhi() + "");
    }

    //控制显示信誉等级
    private void ctrlCredibility(int index, String type) {
        int img = 0;
        switch (type) {
            case "q":
                img = R.mipmap.icon_hq;
                break;
            case "x":
                img = R.mipmap.icon_xx;
                break;
            case "z":
                img = R.mipmap.icon_zs;
                break;
            case "h":
                img = R.mipmap.icon_hg;
                break;
            case "j":
                img = R.mipmap.icon_zz;
                break;
        }
        for (int i = 0; i < index; i++) {
            imageViewList.get(i).setBackgroundResource(img);
            imageViewList.get(i).setVisibility(View.VISIBLE);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View rootView = super.onCreateView(inflater, container, savedInstanceState);
        ButterKnife.bind(this, rootView);
        return rootView;
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    @OnClick(R.id.iv_call)
    public void onViewClicked() {
        if (!LoginUtil.isLogin()) {
            LoginActivity.startAction(getActivity());
        } else {
            callUser();
        }
    }

    //联系商家
    private void callUser() {
        if (phonenum != null && !phonenum.equals("")) {
            Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + phonenum));
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
        } else {
            NToast.show("抱歉，暂时没有该商家的联系方式！");
        }
    }
}
