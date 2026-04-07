package com.linzi.xiguwen.ui;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MineNeedDetailBean;
import com.linzi.xiguwen.bean.NeedJoinDetailBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginHepler;
import com.linzi.xiguwen.utils.LoginHeplerListener;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
//import com.netease.nim.uikit.api.NimUIKit;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class NeedJoinDetailsActivity extends BaseActivity implements LoginHeplerListener {

    @BindView(R.id.tv_content)
    TextView mTvContent;
    @BindView(R.id.iv_head)
    ImageView ivHead;
    @BindView(R.id.tv_name)
    TextView tvName;
    @BindView(R.id.tv_zhiye)
    TextView tvZhiye;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.iv_cx)
    ImageView ivCx;
    @BindView(R.id.iv_pt)
    ImageView ivPt;
    @BindView(R.id.iv_xy)
    ImageView ivXy;
    @BindView(R.id.tv_haopinglv)
    TextView tvHaopinglv;
    @BindView(R.id.tv_pinglun_num)
    TextView tvPinglunNum;
    @BindView(R.id.tv_fans_num)
    TextView tvFansNum;
    @BindView(R.id.ll_peo)
    LinearLayout llPeo;
    @BindView(R.id.iv_chat)
    ImageView ivChat;
    @BindView(R.id.iv_call_phone)
    ImageView ivCallPhone;
    @BindView(R.id.iv_care)
    ImageView ivCare;
    @BindView(R.id.ll_hezuo)
    LinearLayout llHezuo;
    @BindView(R.id.ll_bottom)
    LinearLayout llBottom;

    private MineNeedDetailBean.AffiliatedPerson mData;
    private NeedJoinDetailBean mDetailData;
    private boolean mCouldCooperation; // 是否可以合作

    public static void startActivityForResult(Activity activity, MineNeedDetailBean.AffiliatedPerson data, boolean couldCooperation, int resultCode) {
        Intent intent = new Intent(activity, NeedJoinDetailsActivity.class);
        intent.putExtra("data", data);
        intent.putExtra("couldCooperation", couldCooperation);
        activity.startActivityForResult(intent, resultCode);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_need_join_details);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mData = (MineNeedDetailBean.AffiliatedPerson) getIntent().getSerializableExtra("data");
        mCouldCooperation = getIntent().getBooleanExtra("couldCooperation", false);
        setTitle("参与详情");
        setBack();
        setRightAdd(R.mipmap.icon_share, new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //TODO 分享
            }
        });

        llHezuo.setClickable(mCouldCooperation);
        llHezuo.setEnabled(mCouldCooperation);
        llHezuo.setBackgroundColor(mCouldCooperation ? getResources().getColor(R.color.colorTitleRed) : getResources().getColor(R.color.text_gray));

        if(mData != null){
            requestNetData();
        }else{
            NToast.show("跳转异常");
            finish();
        }
    }

    private void requestNetData() {
        LoadDialog.showDialog(this);
        ApiManager.getNeedJoinDetail(mData.getCid(), new OnRequestFinish<BaseBean<NeedJoinDetailBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<NeedJoinDetailBean> data) {
                mDetailData = data.getData();
                refreshView(mDetailData);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    private void refreshView(NeedJoinDetailBean detail) {
        if(detail != null){
            mTvContent.setText(detail.getJdshuoming());
            tvName.setText(detail.getNickname());
            tvZhiye.setText(detail.getOccupationid());
            tvPrice.setText(Constans.RMB + detail.getMinimumprice() + "起");
            ivCx.setVisibility(detail.isSincerity() ? View.VISIBLE : View.GONE);
            ivPt.setVisibility(detail.isPlatform() ? View.VISIBLE : View.GONE);
            ivXy.setVisibility(detail.isCollege() ? View.VISIBLE : View.GONE);
            tvHaopinglv.setText(String.format("好评率：%d%%", detail.getGoodscore()));
//            tvPinglunNum.setText(String.format("评论：%d", detail.get));
//            tvFansNum.setText(String.format("粉丝：%d", detail.get));
            ivCare.setImageResource(detail.isFollow() ?  R.mipmap.icon_cared2 : R.mipmap.icon_care2);
            GlideLoad.GlideLoadImg(this, detail.getHead(), ivHead);
        }
    }

    //关注操作
    private void careClick(){
        MsgLoadDialog.showDialog(this, "请稍候...");
        ApiManager.controlShangJiaCare(mDetailData.getUserid(), !mDetailData.isFollow(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show(data.getMessage());
                mDetailData.setFollow(mDetailData.isFollow() ? 0 : 1);
                ivCare.setImageResource(mDetailData.isFollow() ?  R.mipmap.icon_cared2 : R.mipmap.icon_care2);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    // 拨打电话
    private void callUser(){
        if (mDetailData.getMobile() != null) {
            Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + mDetailData.getMobile()));
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
        } else {
            NToast.show("抱歉，暂时没有该商家的联系方式！");
        }
    }

    // 合作
    private void cooperation(){
        MsgLoadDialog.showDialog(this, "请稍候...");
        ApiManager.needCooperation(mData.getCid(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show(data.getMessage());
                setResult(RESULT_OK);
                llHezuo.setClickable(false);
                llHezuo.setEnabled(false);
                llHezuo.setBackgroundColor(getResources().getColor(R.color.text_gray));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    @OnClick({R.id.ll_peo, R.id.iv_chat, R.id.iv_call_phone, R.id.iv_care, R.id.ll_hezuo})
    public void onClick(View view) {
        Intent intent;
        switch (view.getId()) {
            case R.id.ll_peo:
                 intent=new Intent(mContext,MallDetailsActivity.class);
                 intent.putExtra("shop_id", (int)mData.getUserid());
                startActivity(intent);
                break;
            case R.id.iv_chat:
                LoginHepler.LoginHepler(mContext, 666, true, this);
                break;
            case R.id.iv_call_phone:
                if(mDetailData != null){
                    callUser();
                }
                break;
            case R.id.iv_care:
                if(mDetailData != null){
                    careClick();
                }
                break;
            case R.id.ll_hezuo:
                if(mDetailData != null){
                    cooperation();
                }
                break;
        }
    }


    @Override
    public void loginOpinion(int code) {
        switch (code){
            case 666:
//                NimUIKit.startP2PSession(this, "user" + mDetailData.getUserid());
            break;
        }
    }
}
