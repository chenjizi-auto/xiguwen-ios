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
import com.linzi.xiguwen.adapter.DaiTongGuoAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.CommunityUserEntity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class DaiTongGuoActivity extends BaseActivity {

    @BindView(R.id.ed_search)
    EditText edSearch;
    @BindView(R.id.recycle)
    RecyclerView recycle;

    DaiTongGuoAdapter mADpater;

    private String id;
    private String name;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dai_tong_guo);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("待通过成员");
        setBack();
        id = getIntent().getStringExtra("id");
        LinearLayoutManager manager = new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);
        mADpater = new DaiTongGuoAdapter(mContext);
        recycle.setAdapter(mADpater);
        event();
        LoadDialog.showDialog(this);
        httpData();
    }

    private void event() {
        mADpater.setAgreeListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener1() {
            @Override
            public void onItemClick(View view, int postion, Object data) {
                CommunityUserEntity entity= (CommunityUserEntity) data;
                httpUpdate(entity.getId(), Constans.Action.COMMUNITY_USER_WAITING_AGREE,postion);
            }
        });

        mADpater.setRefuseListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener1() {
            @Override
            public void onItemClick(View view, int postion, Object data) {
                CommunityUserEntity entity= (CommunityUserEntity) data;
                httpUpdate(entity.getId(), Constans.Action.COMMUNITY_USER_WAITING_REFUSE,postion);
            }
        });
        edSearch.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                name = edSearch.getText().toString().trim();
                httpData();
            }
        });

    }

    private void httpData() {
        ApiManager.communityUserWaitingList(id, name, new OnRequestSubscribe<BaseBean<List<CommunityUserEntity>>>() {
            @Override
            public void onSuccess(BaseBean<List<CommunityUserEntity>> data) {
                mADpater.addFirst(data.getData());
                LoadDialog.CancelDialog();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                LoadDialog.CancelDialog();
            }
        });
    }


    private void httpUpdate(String id, String api, final int position){
        LoadDialog.showDialog(this);
        ApiManager.communityUserWaiting(id, api, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                mADpater.remove(position);
                NToast.show(data.getMessage());
                LoadDialog.CancelDialog();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                LoadDialog.CancelDialog();
            }
        });
    }
}
