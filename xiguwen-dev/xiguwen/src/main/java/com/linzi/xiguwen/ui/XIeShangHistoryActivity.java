package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.XieShangHistoryAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MallXieShangHistoryBean;
import com.linzi.xiguwen.bean.WeddingXieShangHistoryBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginHepler;
import com.linzi.xiguwen.utils.LoginHeplerListener;
import com.linzi.xiguwen.utils.NToast;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class XIeShangHistoryActivity extends BaseActivity implements LoginHeplerListener {

    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.ll_contact)
    LinearLayout llContact;
    @BindView(R.id.ll_call)
    LinearLayout llCall;

    XieShangHistoryAdapter mADapter;
    @BindView(R.id.no_data_view)
    ImageView noDataView;
    @BindView(R.id.no_data)
    RelativeLayout noData;

    private int id;//退款编号
    private int intentType;
    private Context context;

    private WeddingXieShangHistoryBean weddingXieShangHistoryBean;
    private MallXieShangHistoryBean mallXieShangHistoryBean;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_xie_shang_history);
        ButterKnife.bind(this);
        context = this;
        id = getIntent().getIntExtra("id", -1);
        intentType = getIntent().getIntExtra("intentType", -1);
        initView();
    }

    private void initView() {
        setTitle("协商历史");
        setBack();

        if (intentType != -1) {

            LinearLayoutManager manager = new LinearLayoutManager(mContext);
            recycle.setLayoutManager(manager);
            switch (intentType) {
                case 0:
                    mADapter = new XieShangHistoryAdapter(mContext, 0);
                    getWeddingData();
                    break;
                case 1:
                    mADapter = new XieShangHistoryAdapter(mContext, 1);
                    getMallData();
                    break;
                case 2:
                    mADapter = new XieShangHistoryAdapter(mContext, 0);
                    getWeddingData();
                    break;
                case 3:
                    mADapter = new XieShangHistoryAdapter(mContext, 1);
                    getMallData();
                    break;
            }
            recycle.setAdapter(mADapter);

        } else {
            finish();
            NToast.show("跳转失败，请重试！");
        }

    }

    @Override
    protected void initData() {


    }

    @OnClick({R.id.ll_contact, R.id.ll_call})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_contact:
                LoginHepler.LoginHepler(mContext, 666, true, XIeShangHistoryActivity.this);
                break;
            case R.id.ll_call:
                switch (intentType) {
                    case 0:
                        callUser(weddingXieShangHistoryBean.getShop().getMobile());
                        break;
                    case 1:
                        callUser(mallXieShangHistoryBean.getShop().getMobile());
                        break;
                    case 2:
                        callUser(weddingXieShangHistoryBean.getShop().getMobile());
                        break;
                    case 3:
                        callUser(mallXieShangHistoryBean.getShop().getMobile());
                        break;
                }
                break;
        }
    }


    //婚庆协商历史
    private void getWeddingData() {
        LoadDialog.showDialog(context);
        ApiManager.getWeddingXieShang(id, new OnRequestFinish<BaseBean<WeddingXieShangHistoryBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<WeddingXieShangHistoryBean> data) {
                weddingXieShangHistoryBean = data.getData();
                if (weddingXieShangHistoryBean.getData() != null && weddingXieShangHistoryBean.getData().size() > 0) {
                    mADapter.setWeddinglist(weddingXieShangHistoryBean.getData());
                    noData.setVisibility(View.GONE);
                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    //商城协商历史
    private void getMallData() {
        LoadDialog.showDialog(context);
        ApiManager.getMallXieShang(id, new OnRequestFinish<BaseBean<MallXieShangHistoryBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<MallXieShangHistoryBean> data) {
                mallXieShangHistoryBean = data.getData();
                if (mallXieShangHistoryBean.getData() != null && mallXieShangHistoryBean.getData().size() > 0) {
                    mADapter.setMalllist(mallXieShangHistoryBean.getData());
                    noData.setVisibility(View.GONE);
                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    @Override
    public void loginOpinion(int code) {
        switch (intentType) {
            case 0:
//                NimUIKit.startP2PSession(this, weddingXieShangHistoryBean.getShop().getShop_im());
                break;
            case 1:
//                NimUIKit.startP2PSession(this, mallXieShangHistoryBean.getShop().getShop_im());
                break;
            case 2:
//                NimUIKit.startP2PSession(this, weddingXieShangHistoryBean.getShop().getUser_im());
                break;
            case 3:
//                NimUIKit.startP2PSession(this, mallXieShangHistoryBean.getShop().getUser_im());
                break;
        }
    }

    //联系商家
    private void callUser(String phoneNum) {
        if (phoneNum != null) {
            Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + phoneNum));
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
        } else {
            NToast.show("抱歉，暂时没有该商家的联系方式！");
        }
    }
}
