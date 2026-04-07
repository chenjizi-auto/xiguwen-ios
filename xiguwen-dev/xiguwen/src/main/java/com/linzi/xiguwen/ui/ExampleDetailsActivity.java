package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import androidx.core.view.ViewCompat;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.BaojiaImgAdapter;
import com.linzi.xiguwen.adapter.ExampleDetailsAdapter;
import com.linzi.xiguwen.bean.BaseBean;
import com.linzi.xiguwen.bean.CaseDetailsBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.FullScreenUtil;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.view.CusScrollView;

import org.xutils.common.Callback;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class ExampleDetailsActivity extends AppCompatActivity implements Callback.CommonCallback<String> {

    @BindView(R.id.iv_img)
    ImageView ivImg;
    @BindView(R.id.tv_example_title)
    TextView tvExampleTitle;
    @BindView(R.id.tv_time)
    TextView tvTime;
    @BindView(R.id.tv_address)
    TextView tvAddress;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.bt_enter_mall)
    Button btEnterMall;
    @BindView(R.id.tv_context)
    TextView tvContext;
    @BindView(R.id.recycle_img)
    RecyclerView recycleImg;
    @BindView(R.id.iv_head)
    ImageView ivHead;
    @BindView(R.id.tv_user_name)
    TextView tvUserName;
    @BindView(R.id.tv_zhiwu)
    TextView tvZhiwu;
    @BindView(R.id.iv_rz_cx)
    ImageView ivRzCx;
    @BindView(R.id.iv_rz_pt)
    ImageView ivRzPt;
    @BindView(R.id.iv_rz_xy)
    ImageView ivRzXy;
    @BindView(R.id.tv_haopinlv)
    TextView tvHaopinlv;
    @BindView(R.id.tv_pinglun_count)
    TextView tvPinglunCount;
    @BindView(R.id.tv_fans)
    TextView tvFans;
    @BindView(R.id.bt_enter)
    Button btEnter;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.scrollView)
    CusScrollView scrollView;
    @BindView(R.id.iv_chat)
    ImageView ivChat;
    @BindView(R.id.iv_call_phone)
    ImageView ivCallPhone;
    @BindView(R.id.iv_care)
    ImageView ivCare;
    @BindView(R.id.ll_buy)
    LinearLayout llBuy;
    @BindView(R.id.ll_yuyue)
    LinearLayout llYuyue;
    @BindView(R.id.ll_bottom)
    LinearLayout llBottom;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.ll_title)
    RelativeLayout llTitle;
    @BindView(R.id.ll_back)
    LinearLayout llBack;
    @BindView(R.id.ll_right)
    LinearLayout llRight;
    @BindView(R.id.iv_to_top)
    ImageView ivToTop;
    @BindView(R.id.tv_cart_num)
    TextView tvCartNum;
    @BindView(R.id.iv_cart)
    RelativeLayout ivCart;
    @BindView(R.id.ll_parent)
    RelativeLayout llParent;

    Context mContext;

    private Intent intent;
    private int caseid;//案例id
    private CaseDetailsBean.DataBean bean;
    private BaojiaImgAdapter photourladapter;
    private ExampleDetailsAdapter detailsAdapter;
    private int iscare;//1关注
    private int shop_id;
    private ArrayList<String> photoList;//图片集合，浏览使用

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(ExampleDetailsActivity.this, R.color.trans);
        }
        setContentView(R.layout.activity_example_details);
        ButterKnife.bind(this);
        mContext = this;
        if (intent == null) {
            intent = getIntent();
            caseid = intent.getIntExtra("caseid", -1);
            NToast.log(mContext, caseid + "");

        }
        if (caseid != -1) {
            initViews();
            getData();
        } else {
            NToast.show("跳转错误请重试！");
            finish();
        }

    }

    //初始化案例数据源
    private void getData() {
        if (!SPUtil.get("token", SPUtil.Type.STR).equals("") && SPUtil.get("token", SPUtil.Type.STR) != null) {
            LoadDialog.showDialog(mContext);
            new ApiManager().getCaseDetails(caseid + "", (String) SPUtil.get("token", SPUtil.Type.STR), (int) SPUtil.get("userid", SPUtil.Type.INT) + "", this);
        } else {
            new ApiManager().getCaseDetails(caseid + "", null, null + "", this);
            LoadDialog.showDialog(mContext);
        }
    }

    private void initViews() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(ExampleDetailsActivity.this));
        llBar.setLayoutParams(params);

        ViewCompat.setAlpha(llTitle, 0);
        ViewCompat.setAlpha(llBar, 0);
        scrollView.setScrollViewListener(new CusScrollView.ScrollViewListener() {
            @Override
            public void onScrollChanged(CusScrollView scrollView, int x, int y, int oldx, int oldy) {
                float percent = Float.valueOf("" + y) / Float.valueOf("" + dip2px(mContext, 200));
                if ((1 - percent) < 0.1) {
                    percent = 1;
                }
                if (percent > 1) {
                    percent = 1;
                }
                ViewCompat.setAlpha(llBar, percent);
                ViewCompat.setAlpha(llTitle, percent);

                if (y > 0) {
                    ivToTop.setVisibility(View.VISIBLE);
                } else {
                    ivToTop.setVisibility(View.GONE);
                }
            }
        });

        ivToTop.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                scrollView.fullScroll(ScrollView.FOCUS_UP);
                scrollView.scrollTo(0, 0);
                scrollView.setFocusable(true);
            }
        });

        llBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

        LinearLayoutManager manager1 = new LinearLayoutManager(mContext);
        recycleImg.setLayoutManager(manager1);
        photourladapter = new BaojiaImgAdapter(mContext, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                if (photoList != null && photoList.size() > 0) {
                    FullScreenUtil.showFullScreenDialog(mContext,postion,photoList);
                }
            }
        });
        recycleImg.setAdapter(photourladapter);

        detailsAdapter = new ExampleDetailsAdapter(mContext);
        LinearLayoutManager manager2 = new LinearLayoutManager(mContext) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager2);
        recycle.setAdapter(detailsAdapter);

        llBuy.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(mContext, GetSuggestActivity.class);//免费获取方案
                startActivity(intent);
            }
        });

    }

    //请求成功后更新View
    private void refreshView() {
        tvTitle.setText("" + bean.getInfo().getTitle());
        tvExampleTitle.setText("" + bean.getInfo().getTitle());
        tvTime.setText("婚礼时间：" + bean.getInfo().getWeddingtime());
        tvAddress.setText("婚礼地址：" + bean.getInfo().getWeddingplace());
        tvPrice.setText("￥" + bean.getInfo().getWeddingexpenses());
        tvContext.setText("" + bean.getInfo().getWeddingdescribe());
        GlideLoad.GlideLoadImg(mContext, bean.getInfo().getWeddingcover(), ivImg);
        GlideLoad.GlideLoadImg(mContext, bean.getUser().getHead(), ivHead);
        tvUserName.setText("" + bean.getUser().getNickname());
        tvHaopinlv.setText("" + bean.getUser().getGoodscore());
        tvPinglunCount.setText("" + bean.getUser().getEvaluate());
        tvFans.setText("" + bean.getUser().getFans());
        if (bean.getUser().getCollege() == 1) {
            ivRzXy.setVisibility(View.VISIBLE);
        } else {
            ivRzXy.setVisibility(View.GONE);
        }
        if (bean.getUser().getPlatform() == 1) {
            ivRzPt.setVisibility(View.VISIBLE);
        } else {
            ivRzPt.setVisibility(View.GONE);
        }
        if (bean.getUser().getSincerity() == 1) {
            ivRzCx.setVisibility(View.VISIBLE);
        } else {
            ivRzCx.setVisibility(View.GONE);
        }
    }

    //将dp转换为px
    public int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }

    @Override
    public void onSuccess(String result) {
        NToast.log("TAG-----案例详情", result.toString());
        bean = new Gson().fromJson(result, CaseDetailsBean.class).getData();
        if (bean.getUserf() == 1) {
            iscare = 1;
            ivCare.setBackgroundResource(R.mipmap.icon_cared2);
        } else {
            iscare = 0;
            ivCare.setBackgroundResource(R.mipmap.icon_care2);
        }

        if (bean.getInfo().getPhotourl().size() > 0) {
            photoList = new ArrayList<>();
            for (int i = 0; i < bean.getInfo().getPhotourl().size(); i++) {
                photoList.add(bean.getInfo().getPhotourl().get(i).getPhotourl());
            }
        }


        if (bean != null)
            refreshView();
        if (bean.getInfo().getPhotourl().size() > 0) {
            photourladapter.setData(bean.getInfo().getPhotourl());//设置更多环境图片数据源
        }
        if (bean.getTeam().size() > 0) {
            detailsAdapter.setTeamData(bean.getTeam());
        }
        if (bean.getPinglun().size() > 0) {
            detailsAdapter.setPinglunshu(bean.getPinglunshu());
            detailsAdapter.setPingjiaData(bean.getPinglun());
        }
        if (bean.getGdanli().size() > 0) {
            detailsAdapter.setGdanliBeanList(bean.getGdanli());
            detailsAdapter.setmorecasenum(bean.getGdanli().size());
        }
        shop_id = bean.getUser().getUserid();
    }

    @Override
    public void onError(Throwable ex, boolean isOnCallback) {
        NToast.log("TAG-----案例详情", ex.toString());
    }

    @Override
    public void onCancelled(CancelledException cex) {

    }

    @Override
    public void onFinished() {
        LoadDialog.CancelDialog();
    }

    @OnClick({R.id.ll_phone, R.id.ll_care, R.id.bt_enter_mall, R.id.iv_chat, R.id.bt_enter})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.ll_phone:
                if (bean.getUser().getMobile() != null) {
                    Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + bean.getUser().getMobile()));
                    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    startActivity(intent);
                } else {
                    NToast.show("抱歉，暂时没有该商家的联系方式！");
                }
                break;
            case R.id.ll_care:
                if (iscare == 1) {
                    delCare(caseid);
                } else {
                    addCare(caseid);
                }
                break;
            case R.id.bt_enter_mall:
                Intent intent = new Intent(ExampleDetailsActivity.this, CheckCaseDetailsActivity.class);//查看明细、
                intent.putExtra("case_id", caseid);
                startActivity(intent);
                break;
            case R.id.iv_chat:
                NToast.show("即将上线，敬请期待！");
                break;
            case R.id.bt_enter:
                Intent intent1 = new Intent(mContext, NewMallDetailsActivity.class);//进店看看
                intent1.putExtra("shop_id", shop_id);
                startActivity(intent1);
                break;
        }
    }

    //关注商家
    private void addCare(final int id) {
        LoadDialog.showDialog(mContext);
        new ApiManager().isCarUser("" + id, "" + SPUtil.get("token", SPUtil.Type.STR), "" + SPUtil.get("userid", SPUtil.Type.INT), new CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                NToast.log("TAG-------关注结果", result + "   TAG-------案例id" + id);
                BaseBean base = JSONObject.parseObject(result, BaseBean.class);
                if (base.getCode() == 0) {
                    ivCare.setBackgroundResource(R.mipmap.icon_cared2);
                    iscare = 1;
                }

            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {

            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }
        });
    }

    //取消关注商家
    private void delCare(final int id) {
        LoadDialog.showDialog(mContext);
        new ApiManager().cancelCarUser("" + id, "" + SPUtil.get("token", SPUtil.Type.STR), "" + SPUtil.get("userid", SPUtil.Type.INT), new CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {

                NToast.log("TAG-------取关结果", result + "   TAG-------案例id" + id);
                BaseBean base = JSONObject.parseObject(result, BaseBean.class);
                if (base.getCode() == 0) {
                    ivCare.setBackgroundResource(R.mipmap.icon_care2);
                    iscare = 0;
                }
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {

            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }
        });
    }
}
