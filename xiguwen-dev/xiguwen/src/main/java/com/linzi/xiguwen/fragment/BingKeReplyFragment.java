package com.linzi.xiguwen.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.DefaultItemAnimator;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.DaiDingAdapter;
import com.linzi.xiguwen.adapter.FuyanAdapter;
import com.linzi.xiguwen.adapter.ZhufuAdapter;
import com.linzi.xiguwen.base.BaseFragment;
import com.linzi.xiguwen.bean.FuYanBean;
import com.linzi.xiguwen.bean.ZhuFuBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.BingkeReplyActivity;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.AskDialog;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnRefreshLoadMoreListener;
import com.yanzhenjie.recyclerview.swipe.SwipeMenu;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuBridge;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuCreator;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuItem;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuItemClickListener;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuRecyclerView;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

import static android.view.ViewGroup.LayoutParams.MATCH_PARENT;

public class BingKeReplyFragment extends BaseFragment {

    public static final int PAGE_TYPE_ZHUFU = 1;
    public static final int PAGE_TYPE_FUYAN = 2;
    public static final int PAGE_TYPE_DAIDING = 3;


    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.recycle)
    SwipeMenuRecyclerView recycleView;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;

    private int mPageType = -1;

    private boolean isPrepare = false;
    RecyclerView.Adapter mAdapter;

    private List<ZhuFuBean.InfoBean> mZhuFus;
    private List<FuYanBean.InfoBean> mFuYans;
    private List<FuYanBean.InfoBean> mDaiDing;

    private int mPage = 1;
    private int mRows = 15;
    private int qingjianid;

    public static BingKeReplyFragment newInstance(int pageType, int qingjianid) {
        Bundle args = new Bundle();
        args.putInt("page_type", pageType);
        args.putInt("qingjianid", qingjianid);
        BingKeReplyFragment fragment = new BingKeReplyFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_refresh_list_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        initViews();
    }

    private void initViews() {
        Bundle bu = getArguments();
        mPageType = bu.getInt("page_type");
        qingjianid = bu.getInt("qingjianid");
        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        recycleView.setLayoutManager(manager);

        if (mPageType == PAGE_TYPE_ZHUFU) {
            mZhuFus = new ArrayList<>();
            mAdapter = new ZhufuAdapter(getContext(), mZhuFus);
        } else if (mPageType == PAGE_TYPE_DAIDING) {
            mDaiDing = new ArrayList<>();
            mAdapter = new DaiDingAdapter(getContext(), mDaiDing);
        } else {
            mFuYans = new ArrayList<>();
            mAdapter = new FuyanAdapter(getContext(), mFuYans);
        }

        recycleView.setItemAnimator(new DefaultItemAnimator());

        recycleView.setSwipeMenuCreator(new SwipeMenuCreator() {
            @Override
            public void onCreateMenu(SwipeMenu swipeLeftMenu, SwipeMenu swipeRightMenu, int viewType) {
                SwipeMenuItem deleteItem = new SwipeMenuItem(getActivity());
                deleteItem.setBackgroundColor(getActivity().getResources().getColor(R.color.colorTitleRed));
                deleteItem.setHeight(MATCH_PARENT);
                deleteItem.setWidth(AppUtil.dip2px(getActivity(), 60));
                deleteItem.setText("删除");
                deleteItem.setTextColor(getActivity().getResources().getColor(R.color.white));
                // 各种文字和图标属性设置。
                swipeRightMenu.addMenuItem(deleteItem); // 在Item左侧添加一个菜单。
            }
        });
        recycleView.setSwipeMenuItemClickListener(new SwipeMenuItemClickListener() {
            @Override
            public void onItemClick(SwipeMenuBridge menuBridge) {
                // 任何操作必须先关闭菜单，否则可能出现Item菜单打开状态错乱。
                menuBridge.closeMenu();

                int direction = menuBridge.getDirection(); // 左侧还是右侧菜单。
                int adapterPosition = menuBridge.getAdapterPosition(); // RecyclerView的Item的position。
                int menuPosition = menuBridge.getPosition(); // 菜单在RecyclerView的Item中的Position。
                del(adapterPosition);
            }
        });

        //recycleView item动画


        recycleView.setAdapter(mAdapter);

        refreshLayout.setEnableRefresh(true);
        refreshLayout.setEnableLoadMore(true);
        refreshLayout.setRefreshHeader(new MyRefreshHeader(getContext()));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(getContext()));
        refreshLayout.setEnableLoadMoreWhenContentNotFull(true); // 设置没有满屏也可以加载更多
        refreshLayout.setOnRefreshLoadMoreListener(new OnRefreshLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                requestNetData(false);
            }

            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                requestNetData(true);
            }
        });

        refreshLayout.autoRefresh();
    }

    /**
     * 请求网络数据
     *
     * @param isRefresh
     */
    private void requestNetData(final boolean isRefresh) {
        if (mPageType == PAGE_TYPE_ZHUFU) {
            requestZhuFu(isRefresh);
        } else if (mPageType == PAGE_TYPE_DAIDING) {
            requestDaiDing(isRefresh);
        } else {
            requestFuYan(isRefresh);
        }
    }

    private void requestDaiDing(final boolean isRefresh) {
        if (isRefresh) {
            mPage = 1;
        } else {
            mPage++;
        }
        ApiManager.getBinKeDaiDing(qingjianid, mPage, mRows, new OnRequestFinish<BaseBean<FuYanBean>>() {
            @Override
            public void onFinished() {
                if (isRefresh) {
                    refreshLayout.finishRefresh(0);
                } else {
                    refreshLayout.finishLoadMore(0);
                }
            }

            @Override
            public void onSuccess(BaseBean<FuYanBean> data) {
                if (isRefresh) {
                    if (mDaiDing != null)
                        mDaiDing.clear();
                }
                if (data.getData() != null && data.getData().getInfo() != null) {
                    ((BingkeReplyActivity) getActivity()).refreshTab(mPageType, data.getData().getNum());
                    mDaiDing.addAll(data.getData().getInfo());
                    if (data.getData().getInfo().size() < mRows) {
                        refreshLayout.setNoMoreData(true);
                    } else {
                        refreshLayout.setNoMoreData(false);
                    }
                }
                if (mDaiDing.size() == 0) {
                    mNodataLayout.setVisibility(View.VISIBLE);
                } else {
                    mNodataLayout.setVisibility(View.GONE);
                }
                mAdapter.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                if (mDaiDing.size() == 0) {
                    mNodataLayout.setVisibility(View.VISIBLE);
                }
                if (!isRefresh) {
                    mPage--;
                }
            }
        });
    }


    private void requestFuYan(final boolean isRefresh) {
        if (isRefresh) {
            mPage = 1;
        } else {
            mPage++;
        }
        ApiManager.getBinKeFuYan(qingjianid, mPage, mRows, new OnRequestFinish<BaseBean<FuYanBean>>() {
            @Override
            public void onFinished() {
                if (isRefresh) {
                    refreshLayout.finishRefresh(0);
                } else {
                    refreshLayout.finishLoadMore(0);
                }
            }

            @Override
            public void onSuccess(BaseBean<FuYanBean> data) {
                if (isRefresh) {
                    if (mFuYans != null)
                        mFuYans.clear();
                }
                if (data.getData() != null && data.getData().getInfo() != null) {
                    ((BingkeReplyActivity) getActivity()).refreshTab(mPageType, data.getData().getNum());
                    mFuYans.addAll(data.getData().getInfo());
                    if (data.getData().getInfo().size() < mRows) {
                        refreshLayout.setNoMoreData(true);
                    } else {
                        refreshLayout.setNoMoreData(false);
                    }
                }
                if (mFuYans.size() == 0) {
                    mNodataLayout.setVisibility(View.VISIBLE);
                } else {
                    mNodataLayout.setVisibility(View.GONE);
                }
                mAdapter.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                if (mFuYans.size() == 0) {
                    mNodataLayout.setVisibility(View.VISIBLE);
                }
                if (!isRefresh) {
                    mPage--;
                }
            }
        });
    }

    private void requestZhuFu(final boolean isRefresh) {
        if (isRefresh) {
            mPage = 1;
        } else {
            mPage++;
        }

        ApiManager.getBinKeZhuFu(qingjianid, mPage, mRows, new OnRequestFinish<BaseBean<ZhuFuBean>>() {
            @Override
            public void onFinished() {
                if (isRefresh) {
                    refreshLayout.finishRefresh(0);
                } else {
                    refreshLayout.finishLoadMore(0);
                }
            }

            @Override
            public void onSuccess(BaseBean<ZhuFuBean> data) {
                if (isRefresh) {
                    if (mZhuFus != null)
                        mZhuFus.clear();
                }

                if (data.getData() != null && data.getData().getInfo() != null) {
                    ((BingkeReplyActivity) getActivity()).refreshTab(mPageType, data.getData().getNum());
                    mZhuFus.addAll(data.getData().getInfo());
                    if (data.getData().getInfo().size() < mRows) {
                        refreshLayout.setNoMoreData(true);
                    } else {
                        refreshLayout.setNoMoreData(false);
                    }
                }
                if (mZhuFus.size() == 0) {
                    mNodataLayout.setVisibility(View.VISIBLE);
                } else {
                    mNodataLayout.setVisibility(View.GONE);
                }
                mAdapter.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                if (mZhuFus.size() == 0) {
                    mNodataLayout.setVisibility(View.VISIBLE);
                }
                if (!isRefresh) {
                    mPage--;
                }
            }
        });
    }

    @Override
    protected void lazyLoad() {
        if (!isVisible || !isPrepare) {
            return;
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK) {
            refreshLayout.autoRefresh();
        }
    }

    //删除数据
    private void delData(int index) {
        if (mPageType == PAGE_TYPE_ZHUFU) {
            requstDel(mZhuFus.get(index).getId(), index);
        } else if (mPageType == PAGE_TYPE_FUYAN) {
            requstDel(mFuYans.get(index).getId(), index);
        } else {
            requstDel(mDaiDing.get(index).getId(), index);
        }
    }


    // 删除提醒
    private void del(final int index) {
        final AskDialog dialog = new AskDialog(getActivity(), getActivity());
        dialog.setTitle("警告");
        dialog.setMessage("是否删除该条回复？");
        dialog.setCancleListener("我点错了", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
        dialog.setSubmitListener("确认删除", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
                delData(index);
            }
        });
        dialog.show();
    }

    //删除请求
    private void requstDel(int id, final int index) {
        LoadDialog.showDialog(getActivity());
        ApiManager.delZhuFu(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                if (mPageType == PAGE_TYPE_ZHUFU) {
                    mZhuFus.remove(index);
                    ((BingkeReplyActivity) getActivity()).refreshTab(mPageType, mZhuFus.size());
                } else if (mPageType == PAGE_TYPE_FUYAN) {
                    mFuYans.remove(index);
                    ((BingkeReplyActivity) getActivity()).refreshTab(mPageType, mFuYans.size());
                } else {
                    mDaiDing.remove(index);
                    ((BingkeReplyActivity) getActivity()).refreshTab(mPageType, mDaiDing.size());
                }
                mAdapter.notifyItemRemoved(index);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }
}
