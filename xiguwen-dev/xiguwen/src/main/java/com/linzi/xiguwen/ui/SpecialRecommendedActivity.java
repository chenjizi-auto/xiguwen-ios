package com.linzi.xiguwen.ui;

import android.content.Context;
import android.graphics.Color;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.SpecialRecommendedAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.SpecialRecommendBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GetShareContentUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/4/5.
 */

public class SpecialRecommendedActivity extends BaseActivity {
    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.no_data_view)
    ImageView noDataView;
    private Context mContext;
    private int adid;
    private List<SpecialRecommendBean> list;
    private SpecialRecommendedAdapter mAdapter;
    private String color;
    private String title;
    private int cityid;
    private int types;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.specialrecommended_layout);
        ButterKnife.bind(this);
        mContext = this;
        adid = getIntent().getIntExtra("adid", -1);
        color = getIntent().getStringExtra("color");
        title = getIntent().getStringExtra("title");
        types = getIntent().getIntExtra("types", -1);
//        if (color != null && !color.equals("")) {
//            recycleview.setBackgroundColor(Color.parseColor(color));
//        }
        initView();
        if (adid != -1) {
            getData();
        } else {
            NToast.show("跳转错误，请重试！");
            finish();
        }
    }

    @Override
    protected void initData() {

    }

    private void initView() {
        setBack();
        setTitle(title);
        setRightAdd(R.mipmap.icon_share, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                GetShareContentUtil.getContent(SpecialRecommendedActivity.this, adid, 9, types);
            }
        });

        LinearLayoutManager manager = new LinearLayoutManager(mContext);
        if (color.equals("#ffffff")) {
            mAdapter = new SpecialRecommendedAdapter(mContext, null);
        } else {
            mAdapter = new SpecialRecommendedAdapter(mContext, "#ffffff");
        }
        recycleview.setLayoutManager(manager);
        recycleview.setAdapter(mAdapter);
    }


    @Override
    protected void onDestroy() {
        super.onDestroy();
         
    }

    private void getData() {
        LoadDialog.showDialog(mContext);
        cityid = Preferences.getCity().getId();
        ApiManager.getAdSecData(cityid, adid, new OnRequestFinish<BaseBean<ArrayList<SpecialRecommendBean>>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ArrayList<SpecialRecommendBean>> data) {
                list = data.getData();
                if (list != null && list.size() > 0) {
                    mAdapter.setList(list);
                    noDataView.setVisibility(View.GONE);
                } else {
                    noDataView.setVisibility(View.VISIBLE);
                    recycleview.setBackgroundColor(Color.parseColor("#ffffff"));
                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }
}
