package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ClubFragmentAdapter;
import com.linzi.xiguwen.bean.AssociationBean;
import com.linzi.xiguwen.fragment.vm.RefreshViewModel;
import com.linzi.xiguwen.fragment.vm.club.CityVM;
import com.linzi.xiguwen.fragment.vm.club.ClassificationVM;
import com.linzi.xiguwen.fragment.vm.club.ScreenPopVM;
import com.linzi.xiguwen.fragment.vm.club.SortVM;
import com.linzi.xiguwen.fragment.vm.club.model.CityModel;
import com.linzi.xiguwen.fragment.vm.club.model.ClassificationModel;
import com.linzi.xiguwen.fragment.vm.club.model.SortModel;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.ClubDetailsActivity;
import com.linzi.xiguwen.ui.NewClubDetailsActivity;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.view.CusRadioButton;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/15.
 */

public class ClubFragment extends Fragment {

    @BindView(R.id.rb_all)
    CusRadioButton rbAll;
    @BindView(R.id.rb_sort)
    CusRadioButton rbSort;
    @BindView(R.id.rb_location)
    CusRadioButton rbLocation;
    @BindView(R.id.rb_saixuan)
    CusRadioButton rbSaixuan;
    @BindView(R.id.ll_group)
    LinearLayout llGroup;
    @BindView(R.id.hot_recycle)
    RecyclerView hotRecycle;

    ClubFragmentAdapter mAdapter;
    private RefreshViewModel mRefreshViewModel;
    private ClassificationVM mClassificationVm;
    private SortVM mSortVm;
    private CityVM mCityVm;
    private int cityid;
    private ScreenPopVM mScreenPopVM;


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_club_layout, null);
        ButterKnife.bind(this, view);
        initViews(view);
        mRefreshViewModel.autoRefresh();
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        EventBusUtil.register(this);
    }

    private void initViews(View view) {
        setData();
        mRefreshViewModel = RefreshViewModel.initRefresh(view).addOnRefreshListener(new OnRefreshListener() {
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
        mClassificationVm = (ClassificationVM) new ClassificationVM(llGroup, rbAll).addModel(ClassificationModel.createModel()).setRequestListDelegate(mRefreshViewModel.mRequestListDelegate);
        mSortVm = (SortVM) new SortVM(llGroup, rbSort).addModel(SortModel.createModel()).setRequestListDelegate(mRefreshViewModel.mRequestListDelegate);
        mCityVm = (CityVM) new CityVM(llGroup, rbLocation).addModel(CityModel.createModel()).setRequestListDelegate(mRefreshViewModel.mRequestListDelegate);
        mScreenPopVM = ScreenPopVM.initVM(rbSaixuan).setRequestListDelegate(mRefreshViewModel.mRequestListDelegate);
    }

    private void setData() {
        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        hotRecycle.setLayoutManager(manager);
        mAdapter = new ClubFragmentAdapter(getActivity(), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                Intent intent = new Intent(getActivity(), NewClubDetailsActivity.class);
                intent.putExtra(ClubDetailsActivity.ID_KEY, mAdapter.getItemBean(postion).getId());
                startActivity(intent);
            }
        });
        hotRecycle.setAdapter(mAdapter);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        EventBusUtil.unregister(this);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.CITY_SELECT:
                    mCityVm = (CityVM) new CityVM(llGroup, rbLocation).addModel(CityModel.createModel()).setRequestListDelegate(mRefreshViewModel.mRequestListDelegate);
                    refreshView();
                    break;
                case EventCode.LOGIN_SUCCESS:
                    refreshView();
                    break;
            }
        } catch (Exception e) {
        }
    }

    private void refreshView() {
        mRefreshViewModel.autoRefresh();
    }

    //---------------------------跟View相关的请求操作---------------------------------

    /**
     * @param refreshLayout
     * @param p
     * @param isRefreshOrLoadMore true 刷新  false 加载更多
     */
    private void requestData(@NonNull final RefreshLayout refreshLayout, int p, boolean isRefreshOrLoadMore) {
        String comprehensive = mSortVm.getValue();
        String cityId = mCityVm.getValue();
        String type = mClassificationVm.getValue();
        String page = p + "";
        String row = "30";
        String moneyMax = mScreenPopVM.getMaxPrice();
        String moneyMin = mScreenPopVM.getMinPrice();
        if (isRefreshOrLoadMore) {
            refresh(refreshLayout, comprehensive, cityId, type, page, row, moneyMax, moneyMin);
        } else {
            loadMore(refreshLayout, comprehensive, cityId, type, page, row, moneyMax, moneyMin);
        }
    }

    private void refresh(@NonNull final RefreshLayout refreshLayout, String comprehensive, String cityId, String type, String page, String row, String moneyMax, String moneyMin) {
        int cityid= 273;
       if(Preferences.getCity()!=null &&  ((Integer) Preferences.getCity().getId()) != null) {
            cityid = Preferences.getCity().getId();
        }else{
           cityid=273;
       }
        //cityid = Preferences.getCity().getId();
        ApiManager.getAssociation(cityId, comprehensive, moneyMax, moneyMin, page, row, type, cityid + "", new OnRequestSubscribe<BaseBean<AssociationBean>>() {
            @Override
            public void onSuccess(BaseBean<AssociationBean> data) {
                mAdapter.setData(data.getData());
                refreshLayout.finishRefresh();
                if (data.getData().getShetuan().size() == 0) {
                    refreshLayout.setEnableLoadMore(false);
                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void loadMore(@NonNull final RefreshLayout refreshLayout, String comprehensive, String cityId, String type, String page, String row, String moneyMax, String moneyMin) {
        ApiManager.getAssociation(cityId, comprehensive, null, null, page, row, type, Preferences.getCity().getId() + "", new OnRequestSubscribe<BaseBean<AssociationBean>>() {
            @Override
            public void onSuccess(BaseBean<AssociationBean> data) {
                refreshLayout.finishLoadMore();
                if (data.getData() == null || data.getData().getShetuan() == null || data.getData().getShetuan().size() == 0) {
                    refreshLayout.setEnableLoadMore(false);
                } else {
                    mAdapter.appendData(data.getData());
                }
            }

            @Override
            public void onError(Exception ex) {
                refreshLayout.finishRefresh();
            }
        });
    }

}
