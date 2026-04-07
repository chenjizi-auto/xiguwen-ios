package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.android.material.tabs.TabLayout;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.FindChildAdapter;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.bean.ClassificationBean;
import com.linzi.xiguwen.bean.WeddingRingBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.ActivitiesDetailsActivity;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/21.
 */

public class FindChildFragment extends BaseLazyFragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;

    FindChildAdapter mAdapter;

    View view;

    int tag = 0;//0婚庆 1商城
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.no_data_view)
    ImageView noDataView;
    @BindView(R.id.tab_title2)
    TabLayout tabTitle2;

    private ArrayList<String> urls;

    private String follow;//关注
    private String hot;//热门
    private String newest;//最新
    private int type;//职业 0代表全部
    private int page = 1;
    private int limit = 10;
    private ArrayList<WeddingRingBean> list;
    List<String> title1;
    List<String> title2;
    private boolean isCare;


    private BaseBean<ArrayList<ClassificationBean>> bean;
    private FindChildFragment.FindFragmentSerachAdapter serachadapter;
    private RecyclerView poprecyclerView;
    private PopupWindow popupWindow;

    //FLAG 区分是婚庆还是商城
    public static FindChildFragment newInstance(int FLAG) {
        Bundle args = new Bundle();
        args.putInt("type", FLAG);
        FindChildFragment fragment = new FindChildFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_club_detail_activity_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        tag = getArguments().getInt("type");
        initView();
        if (tag == 0) {
            getClassification();
            getData(true);
        } else {
            getShopData(true, false);
        }
    }

    private void initView() {
        title1 = new ArrayList<>();
        title1.add("全部");
        title1.add("最新");
        title1.add("热门");
        title1.add("关注");

        title2 = new ArrayList<>();
        title2.add("最新");
        title2.add("热门");
        title2.add("关注");

        refreshLayout.setRefreshHeader(new MyRefreshHeader(getActivity()));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(getActivity()));
        setTab(tag);

        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        recycle.setLayoutManager(manager);

        mAdapter = new FindChildAdapter(getActivity(), tag, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                Intent intent = new Intent(getActivity(), ActivitiesDetailsActivity.class);
                startActivity(intent);
            }
        });
        mAdapter.setCareClikListener(new CallBack.CaseCareClikListener() {
            @Override
            public void CaseCareClik(int postion) {
                //是否关注
                if (isCare) {
                    disCare();
                } else {
                    care();
                }
            }
        });
        recycle.setAdapter(mAdapter);

        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                if (tag == 0) {
                    getData(false);
                } else {
                    getShopData(true, false);
                }
                refreshLayout.finishRefresh();
                refreshLayout.setNoMoreData(false);
            }
        });
        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                page++;
                if (tag == 0) {
                    getMoreData();
                } else {
                    getShopData(false, true);
                }
            }
        });

        initPop();

        tabTitle2.addOnTabSelectedListener(new TabLayout.OnTabSelectedListener() {
            @Override
            public void onTabSelected(TabLayout.Tab tab) {
                selecTab(tab, true);
            }

            @Override
            public void onTabUnselected(TabLayout.Tab tab) {

            }

            @Override
            public void onTabReselected(TabLayout.Tab tab) {

            }
        });
    }

    //处理tab选中逻辑
    private void selecTab(TabLayout.Tab tab, boolean isSelect) {
        TextView textView = (TextView) tab.getCustomView().findViewById(R.id.tv_title);
        if (isSelect) {
            if (tag == 0) {
                switch (textView.getText().toString()) {
                    case "最新":
                        type = 0;
                        newest = "asc";
                        hot = null;
                        follow = null;
                        page = 1;
                        refreshLayout.autoRefresh();
                        break;
                    case "热门":
                        type = 0;
                        newest = null;
                        hot = "asc";
                        follow = null;
                        page = 1;
                        refreshLayout.autoRefresh();
                        break;
                    case "关注":
                        type = 0;
                        newest = null;
                        hot = null;
                        follow = "1";
                        page = 1;
                        refreshLayout.autoRefresh();
                        break;
                }
            } else {
                switch (textView.getText().toString()) {
                    case "最新":
                        newest = "asc";
                        hot = null;
                        follow = null;
                        mAdapter.removeList();
                        page = 1;
                        refreshLayout.autoRefresh();
                        break;
                    case "热门":
                        newest = null;
                        hot = "asc";
                        follow = null;
                        page = 1;
                        refreshLayout.autoRefresh();
                        break;
                    case "关注":
                        newest = null;
                        hot = null;
                        follow = "1";
                        page = 1;
                        refreshLayout.autoRefresh();
                        break;
                }
            }
        }
    }

    //设置tablayout tab
    private void setTab(int type) {
        List<String> list = type == 0 ? title1 : title2;
        for (int i = 0; i < list.size(); i++) {
            TabLayout.Tab tab = tabTitle2.newTab();
            tab.setCustomView(setTabView(type, i));
            tabTitle2.addTab(tab);
            View tabview = (View) tab.getCustomView().getParent();
            tabview.setOnClickListener(null);//重置点击
            if (i == 0 && type == 0) {
                tabview.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        //是否展开pop
                        if (popupWindow.isShowing()) {
                            popupWindow.dismiss();
                        } else {
                            popupWindow.showAsDropDown(tabTitle2);
                        }
                    }
                });
            }
        }
    }


    private View setTabView(int type, int index) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.find_tab_layout, null);
        TextView textView = (TextView) view.findViewById(R.id.tv_title);
        textView.setText(type == 0 ? title1.get(index) : title2.get(index));
        textView.setTextSize(14);
        if (type == 0 && index == 0) {
            ImageView imageView = (ImageView) view.findViewById(R.id.icon);
            imageView.setVisibility(View.VISIBLE);
        }
        return view;
    }

    @Override
    public void onLazyLoad() {

    }

    //婚庆圈
    private void getData(boolean isFrist) {
        mAdapter.removeList();
        if (isFrist) {
            type = 0;
            page = 1;
        } else {
            page = 1;
        }
        ApiManager.getHunQingQuan(follow, hot, newest, page + "", limit + "", type + "", new OnRequestFinish<BaseBean<ArrayList<WeddingRingBean>>>() {
            @Override
            public void onFinished() {
            }

            @Override
            public void onSuccess(BaseBean<ArrayList<WeddingRingBean>> data) {
                if (data.getData() != null && data.getData().size() > 0) {
                    list = data.getData();
                    mAdapter.setData(list);
//                    recycle.scrollToPosition(0);
                    noDataView.setVisibility(View.GONE);
                } else {
                    noDataView.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.log(getContext(), ex.toString());
            }
        });
    }

    //婚庆圈
    private void getMoreData() {
        ApiManager.getHunQingQuan(follow, hot, newest, page + "", limit + "", type + "", new OnRequestFinish<BaseBean<ArrayList<WeddingRingBean>>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishLoadMore();
            }

            @Override
            public void onSuccess(BaseBean<ArrayList<WeddingRingBean>> data) {
                if (data.getData() != null && data.getData().size() > 0) {
                    list.addAll(data.getData());
                    mAdapter.setData(list);
                } else {
                    NToast.show("没有更多数据了！");
                    refreshLayout.finishLoadMoreWithNoMoreData();//将不会再次触发加载更多事件
                }
            }

            @Override
            public void onError(Exception ex) {
                page--;
            }
        });
    }

    //商城圈
    private void getShopData(boolean isFrist, final boolean isMore) {
        if (isFrist && isMore == false) {
            page = 1;
        }
        ApiManager.getShopQuan(follow, hot, newest, page + "", limit + "", new OnRequestFinish<BaseBean<ArrayList<WeddingRingBean>>>() {
            @Override
            public void onFinished() {
                if (isMore)
                    refreshLayout.finishLoadMore();
            }

            @Override
            public void onSuccess(BaseBean<ArrayList<WeddingRingBean>> data) {
                if (isMore == false) {
                    if (data.getData() != null && data.getData().size() > 0) {
                        list = data.getData();
                        mAdapter.setData(list);
                        recycle.scrollToPosition(0);
                        noDataView.setVisibility(View.GONE);
                    } else {
                        noDataView.setVisibility(View.VISIBLE);
                    }
                } else {
                    if (data.getData() != null && data.getData().size() > 0) {
                        list.addAll(data.getData());
                        mAdapter.setData(list);
                    } else {
                        NToast.show("没有更多数据了！");
                        refreshLayout.finishLoadMoreWithNoMoreData();//将不会再次触发加载更多事件
                    }
                }
            }

            @Override
            public void onError(Exception ex) {
                if (isMore)
                    page--;
            }
        });
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    //初始化职业列表
    private void getClassification() {
        ApiManager.getClassification(new OnRequestSubscribe<BaseBean<ArrayList<ClassificationBean>>>() {
            @Override
            public void onSuccess(BaseBean<ArrayList<ClassificationBean>> data) {
                bean = data;
                ClassificationBean allBean = new ClassificationBean();
                allBean.setOccupationid(-1);
                allBean.setProname("全部");
                bean.getData().add(0, allBean);
                serachadapter = new FindChildFragment.FindFragmentSerachAdapter();
                poprecyclerView.setAdapter(serachadapter);
                serachadapter.setData(bean.getData());
            }

            @Override
            public void onError(Exception ex) {
                NToast.log(getActivity(), ex.toString());
            }
        });
    }

    private void initPop() {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.find_pop_layout, null);
        poprecyclerView = (RecyclerView) view.findViewById(R.id.recycleview);
        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        poprecyclerView.setLayoutManager(manager);
        popupWindow = new PopupWindow(view, 300, WindowManager.LayoutParams.WRAP_CONTENT, true);
        popupWindow.setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        popupWindow.setOutsideTouchable(true);
        // 设置PopupWindow是否能响应点击事件
        popupWindow.setTouchable(true);
    }

    //关注
    private void care() {

    }

    //取消关注
    private void disCare() {

    }

    class FindFragmentSerachAdapter extends RecyclerView.Adapter<FindFragmentSerachAdapter.ViewHolder> {
        private ArrayList<ClassificationBean> list;
        private int index;

        private void setIndex(int index) {
            this.index = index;
            notifyDataSetChanged();
        }

        public void setData(ArrayList<ClassificationBean> list) {
            this.list = list;
            notifyDataSetChanged();
        }

        @Override
        public FindFragmentSerachAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(getActivity()).inflate(R.layout.find_text_item, parent, false);
            return new ViewHolder(view);
        }

        @Override
        public void onBindViewHolder(FindFragmentSerachAdapter.ViewHolder holder, int position) {
            holder.textView.setTextColor(position == index ? Color.parseColor("#FFFC5888") : Color.parseColor("#FF262626"));
            holder.textView.setText(list.get(position).getProname());
        }

        @Override
        public int getItemCount() {
            return list == null ? 0 : list.size();
        }

        class ViewHolder extends RecyclerView.ViewHolder {
            TextView textView;

            public ViewHolder(View itemView) {
                super(itemView);
                textView = (TextView) itemView.findViewById(R.id.tv_title);
                itemView.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        setIndex(getPosition());
                        TextView textView = (TextView) tabTitle2.getTabAt(0).getCustomView().findViewById(R.id.tv_title);
                        textView.setText(list.get(getPosition()).getProname());
                        type = list.get(getPosition()).getOccupationid();
                        if (type == -1) {
                            type = 0;
                        }
                        page = 1;
                        refreshLayout.autoRefresh();
                        popupWindow.dismiss();
                    }
                });

            }
        }

    }
}
