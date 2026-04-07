package com.linzi.xiguwen.ui;

import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import androidx.core.view.ViewCompat;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MallDangqiAdapter;
import com.linzi.xiguwen.utils.ArcImageView;
import com.linzi.xiguwen.utils.SharePop;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.view.CusScrollView;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class ShengchengDangqikaActivity extends AppCompatActivity {

    @BindView(R.id.aiv_img)
    ArcImageView aivImg;
    @BindView(R.id.iv_head_img)
    ImageView ivHeadImg;
    @BindView(R.id.ll_head)
    LinearLayout llHead;
    @BindView(R.id.tv_name_zhiye)
    TextView tvNameZhiye;
    @BindView(R.id.tv_phone)
    TextView tvPhone;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.tv_contact_phone)
    TextView tvContactPhone;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.tv_city)
    TextView tvCity;
    @BindView(R.id.tv_web)
    TextView tvWeb;
    @BindView(R.id.iv_share_pengyouquan)
    ImageView ivSharePengyouquan;
    @BindView(R.id.iv_share_wx)
    ImageView ivShareWx;
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
    @BindView(R.id.scrollView)
    CusScrollView scrollView;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;

    private Context mContext;
    private MallDangqiAdapter mAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(ShengchengDangqikaActivity.this, R.color.trans);
        }
        setContentView(R.layout.activity_shengcheng_dangqika);
        ButterKnife.bind(this);
        mContext = this;
        initViews();
    }

    private void initViews() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(ShengchengDangqikaActivity.this));
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
            }
        });

        llBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        LinearLayoutManager manager = new LinearLayoutManager(mContext) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        mAdapter = new MallDangqiAdapter(mContext);
        recycle.setAdapter(mAdapter);
    }

    //将dp转换为px
    public int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }

    @OnClick({R.id.iv_share_pengyouquan, R.id.iv_share_wx})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.iv_share_pengyouquan:
                new SharePop(ShengchengDangqikaActivity.this).setListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
                    @Override
                    public void onItemClick(View view, int postion) {

                    }
                }).show(llParent);
                break;
            case R.id.iv_share_wx:
                break;
        }
    }
}
