package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.CommunityInvatedAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.CommunityDanEntity;
import com.linzi.xiguwen.bean.CommuntiyInvitationEntity;
import com.linzi.xiguwen.bean.ShareEntity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.ShareUtils;
import com.umeng.socialize.bean.SHARE_MEDIA;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by PC on 2018-04-21.
 */

public class InvatedActivity extends BaseActivity {

    @BindView(R.id.ed_search)
    EditText edSearch;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    private CommunityInvatedAdapter mAdapter;
    private String id;
    private String name;

    private String shareTitle;
    private String shareDesc;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_community_invitation);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        id = getIntent().getStringExtra("id");
        String sTitle = getIntent().getStringExtra("name");
        shareTitle = "我用喜顾问创建了“" + sTitle + "”";
        shareDesc = "邀请你加入最好用的婚礼工具，我们在喜顾问等你哦！";
        setTitle("邀请新成员");
        setBack();
        initview();
        httpData();
        httpShare();
    }

    private void initview() {
        LinearLayoutManager manager = new LinearLayoutManager(this);
        recycle.setLayoutManager(manager);
        mAdapter = new CommunityInvatedAdapter(this);
        mAdapter.setItemClickListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener1() {
            @Override
            public void onItemClick(View view, int postion, Object data) {
                CommuntiyInvitationEntity entity = (CommuntiyInvitationEntity) data;
                httpSend(id, entity.getUserid(), postion);
            }
        });
        recycle.setAdapter(mAdapter);
        edSearch.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                name = edSearch.getText().toString();
                httpData();
            }
        });
    }

    @OnClick({R.id.ll_share_fri, R.id.ll_share_wx, R.id.ll_share_qq})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.ll_share_fri:
                ShareUtils.showShare(this, entity.getUrl(), shareTitle, entity.getErweima(), shareDesc, SHARE_MEDIA.WEIXIN_CIRCLE);
                break;
            case R.id.ll_share_wx:
                ShareUtils.showShare(this, entity.getUrl(), shareTitle, entity.getErweima(), shareDesc, SHARE_MEDIA.WEIXIN);
                break;
            case R.id.ll_share_qq:
                ShareUtils.showShare(this, entity.getUrl(), shareTitle, entity.getErweima(), shareDesc, SHARE_MEDIA.QQ);
                break;
        }
    }


    private void httpData() {

        ApiManager.communityInvitationList(id, name, new OnRequestSubscribe<BaseBean<List<CommuntiyInvitationEntity>>>() {
            @Override
            public void onSuccess(BaseBean<List<CommuntiyInvitationEntity>> data) {
                mAdapter.setmList(data.getData());
                recycle.scrollToPosition(0);
                LoadDialog.CancelDialog();
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });
    }

    private void httpSend(String id, String yid, int position) {
        LoadDialog.showDialog(this);
        ApiManager.communityInvitationSend(id, yid, new OnRequestSubscribe<BaseBean<List<CommunityDanEntity>>>() {
            @Override
            public void onSuccess(BaseBean<List<CommunityDanEntity>> data) {
                LoadDialog.CancelDialog();
                NToast.show(data.getMessage());
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });
    }

    ShareEntity entity;

    private void httpShare() {
        ApiManager.invitationFriend(new OnRequestSubscribe<BaseBean<ShareEntity>>() {
            @Override
            public void onSuccess(BaseBean<ShareEntity> data) {
                entity = data.getData();
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }
}
