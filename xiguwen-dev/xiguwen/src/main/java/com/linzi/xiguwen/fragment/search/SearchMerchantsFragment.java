package com.linzi.xiguwen.fragment.search;

/**
 * Created by PC on 2018-04-14.
 */

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RadioButton;

import com.alibaba.fastjson.JSONArray;
import com.example.zhouwei.library.CustomPopWindow;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.AreasAdapter;
import com.linzi.xiguwen.adapter.HistoryAdapter;
import com.linzi.xiguwen.adapter.ProfessionalAdapter;
import com.linzi.xiguwen.bean.CityEntity;
import com.linzi.xiguwen.bean.ClassificationBean;
import com.linzi.xiguwen.bean.SearchSJBean;
import com.linzi.xiguwen.cache.OnCacheRequestFinish;
import com.linzi.xiguwen.cache.repository.CityDictionaryRepository;
import com.linzi.xiguwen.fragment.discover.BaseFragment;
import com.linzi.xiguwen.fragment.vm.RefreshViewModel;
import com.linzi.xiguwen.interfacelistener.PopSelectListener;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.view.ScreenPopWindow;
import com.linzi.xiguwen.widget.NestRadioGroup;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.OnClick;

/**
 * 搜索商家列表
 */
public class SearchMerchantsFragment extends BaseFragment implements PopSelectListener, ScreenPopWindow.ScreenPopSelectListener {
    @BindView(R.id.rb_one)
    RadioButton rbOne;
    @BindView(R.id.rb_two)
    RadioButton rbTwo;
    @BindView(R.id.rb_three)
    RadioButton rbThree;
    @BindView(R.id.ll_three)
    LinearLayout llThree;
    @BindView(R.id.rb_screen)
    RadioButton rbScreen;
    @BindView(R.id.ll_screen)
    LinearLayout llScreen;
    @BindView(R.id.rb_group)
    NestRadioGroup rbGroup;
    @BindView(R.id.no_data_view)
    ImageView noDataView;
    @BindView(R.id.hot_recycle)
    RecyclerView mRecycle;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;

    private CityEntity cityEntity;
    private CustomPopWindow mListPopWindow;

    private List<ClassificationBean> classificationBeans;
    private List<CityEntity> areas;

    private int cityType;
    private String content;
    private int areaId;
    private int jobId;


    private int comprehensive;
    private String floorprice;
    private String ceilingprice;
    private int college;
    private int isshopvip;
    private int platform;
    private int sincerity;
    private int team;


    private RefreshViewModel mRefreshViewModel;
    private HistoryAdapter mAdapter;

    public static SearchMerchantsFragment newInstance(String content, int cityType) {
        Bundle args = new Bundle();
        args.putInt("cityType", cityType);
        args.putString("content", content);
        SearchMerchantsFragment fragment = new SearchMerchantsFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public int setlayoutResID() {
        return R.layout.fragment_search_merchants;
    }

    @Override
    public void initView() {

        cityType = getArguments().getInt("cityType", 1);
        content = getArguments().getString("content");
        initList();
    }

    @Override
    protected void initEvents() {
        rbGroup.setOnCheckedChangeListener(new NestRadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(NestRadioGroup group, int checkedId) {
                switch (checkedId) {
                    case R.id.rb_two:
                        comprehensive = 1;
                        mRefreshViewModel.autoRefresh();
                        break;
                    default:
                        comprehensive = 0;
                        break;
                }
            }
        });
    }

    @Override
    public void initData() {
        cityEntity = Preferences.getCity();
        try {
            String cls = Preferences.getString(Preferences.PROFESSIONAL);
            if (!AppUtil.isEmpty(cls)) {
                classificationBeans = JSONArray.parseArray(cls, ClassificationBean.class);
            }
        } catch (Exception e) {

        }

        httpArea();
        setCityType(cityType);
        mRefreshViewModel.autoRefresh();
    }


    private void initList() {

        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        mAdapter = new HistoryAdapter(getActivity());
        mRecycle.setLayoutManager(manager);
        mRecycle.setAdapter(mAdapter);
        mRefreshViewModel = RefreshViewModel.initRefresh(refreshLayout).addOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull final RefreshLayout refreshLayout) {
                mRefreshViewModel.resetPage();
                refreshLayout.setEnableLoadMore(true);
                requestData(refreshLayout, mRefreshViewModel.getPage(), true);
            }
        }).addOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                mRefreshViewModel.pageAddOne();
                requestData(refreshLayout, mRefreshViewModel.getPage(), false);
            }
        });

    }


    //---------------------------跟View相关的请求操作---------------------------------

    /**
     * @param refreshLayout
     * @param p
     * @param isRefreshOrLoadMore true 刷新  false 加载更多
     */
    private void requestData(@NonNull final RefreshLayout refreshLayout, int p, boolean isRefreshOrLoadMore) {
        String page = p + "";
        String row = "15";
        if (isRefreshOrLoadMore) {
            refresh(refreshLayout, page, row);
        } else {
            loadMore(refreshLayout, page, row);
        }
    }

    private void refresh(@NonNull final RefreshLayout refreshLayout, String page, String row) {
        ApiManager.searchDetail(page, row, content, cityEntity.getId(), cityType,
                "sj", areaId, jobId, comprehensive, floorprice, ceilingprice, college,
                isshopvip, platform, sincerity, team,
                new OnRequestSubscribe<BaseBean<SearchSJBean>>() {
                    @Override
                    public void onSuccess(BaseBean<SearchSJBean> data) {
                        refreshLayout.finishRefresh();
                        mRecycle.scrollToPosition(0);
                        noDataView.setVisibility(View.GONE);
                        mAdapter.addFirst(data.getData().getShangjia());
                        if (data.getData().getShangjia().size() == 0) {
                            refreshLayout.setEnableLoadMore(false);
                            noDataView.setVisibility(View.VISIBLE);
                        }
                    }

                    @Override
                    public void onError(Exception ex) {
                        refreshLayout.finishRefresh();
                    }
                });
    }

    private void loadMore(@NonNull final RefreshLayout refreshLayout, String page, String row) {

        ApiManager.searchDetail(page, row, content, cityEntity.getId(), cityType,
                "sj", areaId, jobId, comprehensive, floorprice, ceilingprice, college,
                isshopvip, platform, sincerity, team,
                new OnRequestSubscribe<BaseBean<SearchSJBean>>() {
                    @Override
                    public void onSuccess(BaseBean<SearchSJBean> data) {
                        SearchSJBean bean = data.getData();
                        refreshLayout.finishLoadMore();
//                        mAdapter.addMore(bean.getShangjia());
                        if (bean.getShangjia().size() == 0) {
                            refreshLayout.setEnableLoadMore(false);
                        } else {
                            mAdapter.addMore(bean.getShangjia());
                        }
                    }

                    @Override
                    public void onError(Exception ex) {
                        refreshLayout.finishRefresh();
                    }
                });
    }

    private void httpArea() {
        if (cityEntity == null) {
            return;
        }
        CityDictionaryRepository.getInstance(getActivity()).getAreas(cityEntity.getId(), new OnCacheRequestFinish<ArrayList<CityEntity>>() {
            @Override
            public void onSuccess(ArrayList<CityEntity> data, boolean fromCache) {
                areas = data;
            }

            @Override
            public void onError(Exception ex) {

            }

            @Override
            public void onFinished() {
            }
        });

    }


    public void setCityType(int cityType) {
        this.cityType = cityType;
        if (llThree == null) {
            return;
        }
        if (cityType == 1) {
            llThree.setVisibility(View.VISIBLE);
        } else {
            llThree.setVisibility(View.GONE);
        }
        mRefreshViewModel.autoRefresh();
    }


    public void setSearchContent(String content) {
        this.content = content;
//        refresh(null, "1", "15");
        if (mRefreshViewModel != null)
            mRefreshViewModel.autoRefresh();
    }

    private ListView listView;
    private ProfessionalAdapter prefrentialAdapter;
    private AreasAdapter areasAdapter;

    private void showPopListView(int code) {
        if (mListPopWindow == null) {
            View contentView = LayoutInflater.from(getActivity()).inflate(R.layout.pop_list, null);
            //处理popWindow 显示内容
            listView = contentView.findViewById(R.id.pop_list);
            handleListView(listView);
            //创建并显示popWindow
            mListPopWindow = new CustomPopWindow.PopupWindowBuilder(getActivity())
                    .setView(contentView)
                    .size(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)//显示大小
                    .setOutsideTouchable(true)
                    .create();
        }

        if (code == ProfessionalAdapter.Code) {
            handleListView(listView);
        } else if (code == AreasAdapter.Code) {
            handleAreaListView(listView);
        }
        mListPopWindow.showAsDropDown(rbGroup, 0, 0);
    }


    private void handleListView(ListView listView) {
        if (prefrentialAdapter == null) {
            prefrentialAdapter = new ProfessionalAdapter(getActivity(), this);
        }
        listView.setAdapter(prefrentialAdapter);
        prefrentialAdapter.addFirst(classificationBeans);

    }

    private void handleAreaListView(ListView listView) {
        if (areasAdapter == null) {
            areasAdapter = new AreasAdapter(getActivity(), this);
        }
        listView.setAdapter(areasAdapter);
        areasAdapter.addFirst(areas);

    }


    private ScreenPopWindow screenPopView;

//    private MyPopWindow screenPopView;
//
//
//
//
//    private void showScreenPop() {
//        if (screenPopView == null) {
//            View contentView = LayoutInflater.from(getActivity()).inflate(R.layout.pop_search_screen, null);
//            //处理popWindow 显示内容
////            listView = contentView.findViewById(R.id.pop_list);
////            handleListView(listView);
//            //创建并显示popWindow
//            int width = AppUtil.getWidth(getActivity()) * 3 / 4;
//            screenPopView = new MyPopWindow.PopupWindowBuilder(getActivity())
//                    .setView(contentView)
//                    .size(width, ViewGroup.LayoutParams.MATCH_PARENT)//显示大小
//                    .setOutsideTouchable(true)
//                    .enableBackgroundDark(true)
//                    .create();
//        }
//
////        screenPopView.showAsDropDown(rbScreen, 0, 1);
//        screenPopView.showBackgroundDark();
//        screenPopView.showAtLocation(rbScreen, Gravity.RIGHT, 0, 0);
//
//
//    }


    @OnClick({R.id.rb_one, R.id.rb_three, R.id.rb_screen})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.rb_one:
                showPopListView(ProfessionalAdapter.Code);
                break;
            case R.id.rb_three:
                showPopListView(AreasAdapter.Code);
                break;
            case R.id.rb_screen:
                if (screenPopView == null) {
                    screenPopView = new ScreenPopWindow(getActivity(), this);
                }
                screenPopView.show(llScreen);
                break;
        }
    }

    @Override
    public void popSelect(int code, int id, String title) {
        if (code == ProfessionalAdapter.Code) {
            jobId = id;
            rbOne.setText(title);

        } else if (code == AreasAdapter.Code) {
            areaId = id;
            rbThree.setText(title);
        }
        mListPopWindow.dissmiss();
        mRefreshViewModel.autoRefresh();
    }


    @Override
    public void ScreenSelect(String floorprice, String ceilingprice, int college, int isshopvip, int platform, int sincerity, int team) {
        this.floorprice = floorprice;
        this.ceilingprice = ceilingprice;
        this.college = college;
        this.isshopvip = isshopvip;
        this.platform = platform;
        this.sincerity = sincerity;
        this.team = team;
        mRefreshViewModel.autoRefresh();
    }
}
