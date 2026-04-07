package com.linzi.xiguwen.ui;

import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.LiJingBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnRefreshLoadMoreListener;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/6/15.
 */

public class GiftsActivity extends AppCompatActivity {

    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.ll_title)
    RelativeLayout llTitle;
    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.ll_back)
    LinearLayout llBack;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.tv_price)
    TextView tvPrice;

    private int qingjianid;
    private Context context;
    private BaseAdapter baseAdapter;
    private int page = 1;
    private int limit = 10;
    private LiJingBean bean;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(GiftsActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(GiftsActivity.this, R.color.white);
        }
        setContentView(R.layout.gifts_layout);
        ButterKnife.bind(this);
        context = this;
        initView();
    }

    private void initView() {
        llBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(GiftsActivity.this));
        llBar.setLayoutParams(params);
        // ViewCompat.setAlpha(llBar, 0);
        llBar.setBackgroundColor(GiftsActivity.this.getResources().getColor(R.color.white));

        recycleview.addOnScrollListener(new RecyclerView.OnScrollListener() {
            @Override
            public void onScrolled(RecyclerView recyclerView, int dx, int dy) {
                super.onScrolled(recyclerView, dx, dy);


                int position = ((LinearLayoutManager) recyclerView.getLayoutManager()).findFirstVisibleItemPosition();
                if (position > 0) {
                    llBar.setAlpha(1); // 显示
                    llTitle.setAlpha(1); // 显示
                    tvTitle.setTextColor(context.getResources().getColor(R.color.colorTitle));
                    ivBack.setBackgroundResource(R.mipmap.icon_back);
                    return;
                } else {
                    int top = recyclerView.getChildAt(0).getTop();
                    float v = -(top * 1.0f / recyclerView.getChildAt(0).getHeight());
                    if (v > 1) {
                        v = 1;
                    } else if (v < 0) {
                        v = 0;
                    } else {
                        if (v < 0.5) {
                            tvTitle.setTextColor(context.getResources().getColor(R.color.white));

                            ivBack.setBackgroundResource(R.mipmap.icon_back_white);
                        } else {
                            tvTitle.setTextColor(context.getResources().getColor(R.color.colorTitle));
                            ivBack.setBackgroundResource(R.mipmap.icon_back);
                        }
                    }
                    llBar.setAlpha(v);
//                    tvTitle.setTextColor(context.getResources().getColor(R.color.white));
//                    tvRight.setTextColor(context.getResources().getColor(R.color.white));
//                    ivBack.setBackgroundResource(R.mipmap.icon_back_white);
                    llTitle.setAlpha(v);
                }
            }
        });

        refreshLayout.setEnableRefresh(true);
        refreshLayout.setEnableLoadMore(true);
        refreshLayout.setRefreshHeader(new MyRefreshHeader(context));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(context));
        refreshLayout.setEnableLoadMoreWhenContentNotFull(true); // 设置没有满屏也可以加载更多
        refreshLayout.setOnRefreshLoadMoreListener(new OnRefreshLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                getData(true);
            }

            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                refreshLayout.setEnableLoadMore(true);
                getData(false);
            }
        });

        qingjianid = getIntent().getIntExtra("qingjianid", -1);
        if (qingjianid != -1) {
            baseAdapter = createAdapter();
            recycleview.setAdapter(baseAdapter);
            refreshLayout.autoRefresh();
        } else {
            NToast.show("跳转失败，请重试！~");
            finish();
        }
    }

    CreateHolderDelegate<String> nodata = new CreateHolderDelegate<String>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.nodata_text_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new BaseViewHolder<String>(itemView) {
                @Override
                protected void bindView(String o) {

                }
            };
        }
    };

    CreateHolderDelegate<String> headerDel = new CreateHolderDelegate<String>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.lijin_header_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new HeaderHolder(itemView);
        }
    };

    class HeaderHolder extends BaseViewHolder<String> {
        @BindView(R.id.tv_price)
        TextView tvPrice;

        public HeaderHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(String s) {
            tvPrice.setText(s);
        }
    }

    CreateHolderDelegate<LiJingBean.ListBean> itemDel = new CreateHolderDelegate<LiJingBean.ListBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.lijin_item_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new ItemHolder(itemView);
        }
    };

    class ItemHolder extends BaseViewHolder<LiJingBean.ListBean> {
        @BindView(R.id.tv_name)
        TextView name;
        @BindView(R.id.tv_phone)
        TextView time;
        @BindView(R.id.tv_type)
        TextView price;

        public ItemHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(LiJingBean.ListBean listBean) {
            name.setText(listBean.getName() + "");
            time.setText(listBean.getPaytime() + "");
            price.setText("+" + listBean.getLijin() + "");
        }
    }

    private BaseAdapter createAdapter() {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        //baseAdapter.injectHolderDelegate(headerDel.addData("0.00"));
        baseAdapter.injectHolderDelegate(new CreateHolderDelegate<String>() {
            @Override
            protected int getLayoutRes() {
                return R.layout.lijin_titile_layout;
            }

            @Override
            protected BaseViewHolder onCreateHolder(View itemView) {
                return new BaseViewHolder<String>(itemView) {
                    @Override
                    protected void bindView(String o) {

                    }
                };
            }
        }.addData(""));
        baseAdapter.injectHolderDelegate(itemDel);
        baseAdapter.injectHolderDelegate(nodata);
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    private void getData(final boolean isLoadMore) {
        nodata.clearAll();
        if (isLoadMore) {
            page++;
        } else {
            page = 1;
        }
        ApiManager.getLiJing(qingjianid, page, limit, new OnRequestFinish<BaseBean<LiJingBean>>() {
            @Override
            public void onFinished() {
                if (isLoadMore) {
                    refreshLayout.finishLoadMore();
                } else {
                    refreshLayout.finishRefresh();
                }
            }

            @Override
            public void onSuccess(BaseBean<LiJingBean> data) {
                LiJingBean liJingBean = data.getData();
                if (liJingBean.getList() != null && liJingBean.getList().size() > 0) {
                    if (isLoadMore) {
                        bean.getList().addAll(liJingBean.getList());
                    } else {
                        bean = liJingBean;
                    }
                    tvPrice.setText(bean.getLijinzongshu() + "");
                    //headerDel.cleanAfterAddData(bean.getLijinzongshu());
                    itemDel.cleanAfterAddAllData(bean.getList());
                    nodata.clearAll();
                } else {
                    if (isLoadMore) {
                        refreshLayout.setEnableLoadMore(false);
                    }
                    nodata.addData("");
                }

                baseAdapter.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                if (isLoadMore) {
                    page--;
                }
            }
        });
    }

}
