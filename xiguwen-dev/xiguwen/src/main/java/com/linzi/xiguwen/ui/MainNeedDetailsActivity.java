package com.linzi.xiguwen.ui;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.text.TextUtils;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MineNeedBean;
import com.linzi.xiguwen.bean.MineNeedDetailBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GetShareContentUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.TimeUtils;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class MainNeedDetailsActivity extends BaseActivity {

    @BindView(R.id.tv_shengyushijian)
    TextView tvShengyushijian;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.tv_location)
    TextView tvLocation;
    @BindView(R.id.tv_time)
    TextView tvTime;
    @BindView(R.id.tv_liulan)
    TextView tvLiulan;
    @BindView(R.id.tv_canyu)
    TextView tvCanyu;
    @BindView(R.id.tv_context)
    TextView tvContext;
    @BindView(R.id.ed_shuoming)
    EditText edShuoming;
    @BindView(R.id.ll_chat)
    LinearLayout llChat;
    @BindView(R.id.ll_call)
    LinearLayout llCall;
    @BindView(R.id.ll_jiedan)
    LinearLayout llJiedan;

    private MineNeedBean mData;
    private MineNeedDetailBean mDetailData;
    private Handler mHandler;

    private int need_id;//需求Id

    public static void startActivity(Activity context, MineNeedBean data) {
        Intent intent = new Intent(context, MainNeedDetailsActivity.class);
        intent.putExtra("data", data);
        context.startActivityForResult(intent, 100);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_need_details);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mData = (MineNeedBean) getIntent().getSerializableExtra("data");
        setTitle("需求详情");
        setBack();
        setRightAdd(R.mipmap.icon_share, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                GetShareContentUtil.getContent(MainNeedDetailsActivity.this, need_id, 6, -1);
            }
        });

        refreshView(mData);
    }

    private void refreshView(MineNeedBean data) {
        if (data != null) {
            tvTitle.setText(data.getTitle());
            tvPrice.setText(Constans.RMB + data.getPrice());
            int length = data.getCreate_ti().length();
            tvLocation.setText(data.getAddress());
            tvTime.setText("发布时间：" + data.getCreate_ti().substring(0, length == 19 ? 16 : length));
            tvLiulan.setText("浏览：" + data.getBrowsingvolume() + "");
            tvCanyu.setText("参与：" + data.getRenshu() + "");
            tvContext.setText(data.getDetails());
            if (data.isJieDan()) {
                llJiedan.setEnabled(false);
                llJiedan.setClickable(false);
                llJiedan.setBackgroundColor(getResources().getColor(R.color.main_txt));
            } else {
                llJiedan.setEnabled(true);
                llJiedan.setClickable(true);
                llJiedan.setBackgroundColor(getResources().getColor(R.color.main_red));
            }
            requestDetail(mData);
        } else {
            NToast.show("数据异常");
        }
    }

    private void refreshView(MineNeedDetailBean data) {
        if (data != null) {
            if (mHandler != null) {
                mHandler.removeCallbacksAndMessages(null);
            }
            mHandler = TimeUtils.getReturnTime(data.getXuquxiangqing().getCountdown(), tvShengyushijian);
        }
    }

    private void requestDetail(MineNeedBean data) {
        LoadDialog.showDialog(this);
        ApiManager.getMineNeedDetail(data.getId(), new OnRequestFinish<BaseBean<MineNeedDetailBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<MineNeedDetailBean> data) {
                mDetailData = data.getData();
                refreshView(mDetailData);
                need_id = mData.getId();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }


    //联系商家
    private void callUser() {
        if (mData.getMobile() != null) {
            Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + mData.getMobile()));
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
        } else {
            NToast.show("抱歉，暂时没有该商家的联系方式！");
        }
    }

    // 接单
    private void takeOrder() {
        MsgLoadDialog.showDialog(this, "请稍候...");
        ApiManager.takeNeedOrder(mData.getId(), edShuoming.getText().toString().trim(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("接单成功");
                // 接单成功然后要干嘛？
                llJiedan.setEnabled(false);
                llJiedan.setBackgroundColor(getResources().getColor(R.color.main_txt));
                setResult(RESULT_OK);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    @OnClick({R.id.ll_chat, R.id.ll_jiedan, R.id.ll_call})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_call:
                if (mData.isOpenPhone()) {
                    callUser();
                } else {
                    NToast.show("该用户开启了电话隐私保护!");
                }
                break;
            case R.id.ll_jiedan:
                if (TextUtils.isEmpty(edShuoming.getText().toString())) {
                    NToast.show("请输入接单说明");
                    return;
                }
                takeOrder();
                break;
            case R.id.ll_chat:
                // 私信
                if (mData.isOpenMessage()) {
                    Intent intent = new Intent(mContext, MallDetailsActivity.class);
                    intent.putExtra("shop_id", (int) mData.getUserid());
                    startActivity(intent);
                } else {
                    NToast.show("该用户开启了私信隐私保护!");
                }
                break;
        }
    }

    @Override
    protected void onDestroy() {
        if (mHandler != null) {
            mHandler.removeCallbacksAndMessages(null);
            mHandler = null;
        }
        super.onDestroy();
    }
}
