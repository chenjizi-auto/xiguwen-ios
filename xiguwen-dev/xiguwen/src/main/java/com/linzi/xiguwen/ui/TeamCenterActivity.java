package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.CommunityCenterEntity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.AskDialog;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class TeamCenterActivity extends BaseActivity {

    @BindView(R.id.iv_head)
    ImageView ivHead;
    @BindView(R.id.tv_name)
    TextView tvName;
    @BindView(R.id.tv_zhiye)
    TextView tvZhiye;
    @BindView(R.id.tv_location)
    TextView tvLocation;
    @BindView(R.id.tv_peo_num)
    TextView tvPeoNum;
    @BindView(R.id.tv_order_num)
    TextView tvOrderNum;
    @BindView(R.id.tv_today_num)
    TextView tvTodayNum;
    @BindView(R.id.tv_dangqi_num)
    TextView tvDangqiNum;
    @BindView(R.id.ll_index)
    LinearLayout llIndex;
    @BindView(R.id.ll_invated)
    LinearLayout llInvated;
    @BindView(R.id.ll_daitongguo)
    LinearLayout llDaitongguo;
    @BindView(R.id.textView4)
    TextView textView4;
    @BindView(R.id.ll_sort)
    LinearLayout llSort;
    @BindView(R.id.ll_manager)
    LinearLayout llManager;
    @BindView(R.id.ll_exit)
    LinearLayout llExit;
    @BindView(R.id.tv_order_num_item)
    LinearLayout tvOrderNumItem;
    @BindView(R.id.tv_today_num_item)
    LinearLayout tvTodayNumItem;
    @BindView(R.id.tv_dangqi_num_item)
    LinearLayout tvDangqiNumItem;

    private String id;
    private int userId;
    private String name;
    private int jiaose = 3;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_team_center);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("团队中心");
        setBack();

        tvOrderNumItem.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(mContext, TodayAddTeamActivity.class);
                intent.putExtra("id", id);
                startActivity(intent);
            }
        });
        tvTodayNumItem.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(mContext, TodayHaveOrderActivity.class);
                intent.putExtra("id", id);
                startActivity(intent);
            }
        });
        tvDangqiNumItem.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(mContext, ChengyuanDangqiActivity.class);
                intent.putExtra("id", id);
                startActivity(intent);
            }
        });
        LoadDialog.showDialog(this);
        httpData();

    }

    @OnClick({R.id.iv_head,R.id.ll_index, R.id.ll_invated, R.id.ll_daitongguo, R.id.ll_sort, R.id.ll_manager, R.id.ll_exit})
    public void onClick(View view) {
        Intent intent;
        switch (view.getId()) {
            case R.id.iv_head:
                intent = new Intent(this, NewMallDetailsActivity.class);
                intent.putExtra("shop_id",userId );
                startActivity(intent);
                break;
            case R.id.ll_index:
                intent = new Intent(this, NewClubDetailsActivity.class);
                intent.putExtra(ClubDetailsActivity.ID_KEY, Integer.parseInt(id));
                startActivity(intent);
                break;
            case R.id.ll_invated:
                if (jiaose == 3) {
                    NToast.show("您不是管理员，无权限操作");
                    break;
                }
//                intent = new Intent(this, InvatedNewPeoActivity.class);
                intent = new Intent(this, InvatedActivity.class);
                intent.putExtra("name", name);
                intent.putExtra("id", id);
                startActivity(intent);
                break;
            case R.id.ll_daitongguo:
                if (jiaose == 3) {
                    NToast.show("您不是管理员，无权限操作");
                    break;
                }
                intent = new Intent(this, DaiTongGuoActivity.class);
                intent.putExtra("id", id);
                startActivity(intent);
                break;
            case R.id.ll_sort:
                break;
            case R.id.ll_manager:
                if (jiaose == 3) {
                    NToast.show("您不是管理员，无权限操作");
                    break;
                }
                if (id != null) {
                    intent = new Intent(this, ChengYuanManagerActivity.class);
                    intent.putExtra("id", id);
                    intent.putExtra("jiaose", jiaose);
                    startActivity(intent);
                }
                break;
            case R.id.ll_exit:
//                outCenter(id);
                showOutDialog();
                break;
        }
    }

    private void httpData() {

        ApiManager.communityCenter(new OnRequestSubscribe<BaseBean<CommunityCenterEntity>>() {
            @Override
            public void onSuccess(BaseBean<CommunityCenterEntity> data) {
                setData(data.getData());
                LoadDialog.CancelDialog();
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });
    }

    private void setData(CommunityCenterEntity entity) {
        GlideLoad.GlideLoadImg(entity.getLogourl(), ivHead);
        tvName.setText(entity.getName() + "");
        tvZhiye.setText(entity.getType() + "");
        tvLocation.setText(entity.getDizhi() + "");
        tvOrderNum.setText(entity.getJrxinzeng() + "单");
        tvTodayNum.setText(entity.getJryoudan() + "单");
        tvDangqiNum.setText(entity.getCydangqi() + "单");
        tvPeoNum.setText("成员" + entity.getChengyuan());
        name = entity.getName();
        id = entity.getId();
        jiaose = entity.getJiaose();
        userId=entity.getUserid();
    }

    private void outCenter(String id) {
        LoadDialog.showDialog(this);
        ApiManager.communityAddApplyDeal(id, Constans.Action.COMMUNITY_OUT, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                NToast.show(data.getMessage());
                finish();
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });
    }

    private void showOutDialog(){
        final AskDialog dialog=new AskDialog(mContext,this);
        if (jiaose==1){
            dialog.setTitle("你是创始人，确定要退出团队吗？");
            dialog.setMessage("创始人退出后整个团队都会解散哦！");
        }else {
            dialog.setTitle("确定要退出团队吗？");
            dialog.setMessage("");
        }

        dialog.setCancleListener("我点错了", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
            }
        });
        dialog.setSubmitListener("确认退出", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
                outCenter(id);
            }
        });
        dialog.show();
    }
}
