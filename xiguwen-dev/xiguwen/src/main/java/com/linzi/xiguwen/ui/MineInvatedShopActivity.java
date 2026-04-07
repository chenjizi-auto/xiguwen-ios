package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.ShareEntity;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.ShareUtils;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by pc on 2018/5/4.
 */

public class MineInvatedShopActivity extends BaseActivity {
    @BindView(R.id.iv_erweima)
    ImageView ivErweima;
    @BindView(R.id.bt_invated)
    Button btInvated;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;
    private ShareEntity shareEntity;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_invated_fri);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("邀请商家");
        btInvated.setText("邀请商家");
        setBack();
        getData();
    }

    @OnClick(R.id.bt_invated)
    public void onClick() {
//        new SharePop(MineInvatedFriActivity.this)
//                .setListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
//                    @Override
//                    public void onItemClick(View view, int postion) {
//
//                    }
//                })
//                .show(llParent);
        ShareUtils.showShare(MineInvatedShopActivity.this, shareEntity.getUrl(), "你的好友送来50元现金抵扣券，快点我领取吧。", shareEntity.getErweima(), "下载喜顾问做最美新娘，婚嫁一站式服务平台，专业，贴心，高质量婚礼服务！");
    }

    private void getData() {
        LoadDialog.showDialog(mContext);
        ApiManager.invitationShop(new OnRequestFinish<BaseBean<ShareEntity>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ShareEntity> data) {
                shareEntity = data.getData();
                GlideLoad.GlideLoadImg2(shareEntity.getErweima(), ivErweima);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

}
