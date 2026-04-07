package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.JiFenDetailsBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/5/23.
 */

public class JiFenDetailsActivity extends BaseActivity {
    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;

    private BaseAdapter baseAdapter;

    private int page = 1;
    private int limit = 10;

    private JiFenDetailsBean jiFenDetailsBean;


    @Override
    protected void initData() {

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.jifen_mall_goods_layout);
        ButterKnife.bind(this);
        initView();
    }

    private void initView() {
        setBack();
        setTitle("积分明细");

        refreshLayout.setRefreshHeader(new MyRefreshHeader(mContext));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(mContext));


        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                resetDel();
                getData(false);
                refreshLayout.setEnableLoadMore(true);
            }
        });

        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                getData(true);
            }
        });

        afterView();

        refreshLayout.autoRefresh();
    }

    private void getData(final boolean isLoadMore) {
        if (isLoadMore) {
            page++;
        } else {
            page = 1;
        }
        ApiManager.getJiFenMingXi(page, limit, new OnRequestFinish<BaseBean<JiFenDetailsBean>>() {
            @Override
            public void onFinished() {
                if (isLoadMore) {
                    refreshLayout.finishLoadMore();
                } else {
                    refreshLayout.finishRefresh();
                }
            }

            @Override
            public void onSuccess(BaseBean<JiFenDetailsBean> data) {
                JiFenDetailsBean bean = data.getData();
                if (!isLoadMore)
                    jiFenDetailsBean = bean;
                else
                    jiFenDetailsBean.getData().addAll(bean.getData());
                if (bean.getData() != null && bean.getData().size() > 0) {
                    noData.clearAll();
                    goodsDel.cleanAfterAddAllData(jiFenDetailsBean.getData());
                } else {
                    refreshLayout.setEnableLoadMore(false);
                    if (isLoadMore) {
                        baseAdapter.injectHolderDelegate(new CreateHolderDelegate<String>() {

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
                        }.addData(""));
                    }
                }
                baseAdapter.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                if (isLoadMore)
                    page--;
            }
        });
    }

    private void afterView() {
        baseAdapter = createAdapter();
        recycleview.setAdapter(baseAdapter);
    }

    CreateHolderDelegate<String> noData = new CreateHolderDelegate<String>() {

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
    }.addData("");

    CreateHolderDelegate<JiFenDetailsBean.DataBean> goodsDel = new CreateHolderDelegate<JiFenDetailsBean.DataBean>() {

        @Override
        protected int getLayoutRes() {
            return R.layout.jifendetails_item;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new ItemHolder(itemView);
        }
    };

    class ItemHolder extends BaseViewHolder<JiFenDetailsBean.DataBean> {
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.jifen_num)
        TextView jifenNum;

        public ItemHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(JiFenDetailsBean.DataBean dataBean) {
            if (dataBean.getType() == 1) {
                //获得
                jifenNum.setTextColor(mContext.getResources().getColor(R.color.color_green_00d3a9));
                jifenNum.setText("+" + dataBean.getJifen());
            } else {
                //支出
                jifenNum.setTextColor(mContext.getResources().getColor(R.color.red));
                jifenNum.setText("-" + dataBean.getJifen());
            }
            tvTime.setText(dataBean.getHuodeshijian());
            tvTitle.setText(dataBean.getTitle());
        }
    }

    private BaseAdapter createAdapter() {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(noData);
        baseAdapter.injectHolderDelegate(goodsDel);
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    //重置adapter代理
    private void resetDel() {
        baseAdapter.clearAllDelegate();
        baseAdapter.injectHolderDelegate(noData);
        baseAdapter.injectHolderDelegate(goodsDel);
    }
}
