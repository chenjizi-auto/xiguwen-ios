package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.LinearLayout;

import com.baidu.location.BDLocation;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MineNeedAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.GetCityBean;
import com.linzi.xiguwen.bean.MineNeedBean;
import com.linzi.xiguwen.fragment.vm.model.BaseModel;
import com.linzi.xiguwen.fragment.vm.model.ModelBack;
import com.linzi.xiguwen.fragment.vm.need.PopwindowVM;
import com.linzi.xiguwen.fragment.vm.need.NeedVM;
import com.linzi.xiguwen.fragment.vm.need.bean.BaseBean;
import com.linzi.xiguwen.fragment.vm.need.bean.NeedBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.location.CustomLocationListener;
import com.linzi.xiguwen.utils.location.LocationHelper;
import com.linzi.xiguwen.view.CusRadioButton;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnRefreshLoadMoreListener;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MineChakanNeed2Activity extends BaseActivity {

    private static final String SORT_ASC = "asc";
    private static final String SORT_DESC = "desc";


    @BindView(R.id.rb_all)
    CusRadioButton rbAll;
    @BindView(R.id.rb_sort)
    CusRadioButton rbSort;
    @BindView(R.id.rb_location)
    CusRadioButton rbLocation;
    @BindView(R.id.ll_group)
    LinearLayout llGroup;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;


    private NeedVM mTypeVM;
    private NeedVM mSortVM;
    private NeedVM mCityVM;

    private String mType = "1" ; // 默认为婚庆
    private String mSort = SORT_DESC; // 排序方式 ,
    private String mCityId = ""; // 城市id
    private String mCountyId = ""; // 默认区id
    private String mCurrentSort = "浏览排序"; // 默认为浏览排序

    private ModelBack<List<BaseBean>> mCityCallBack;
    private BDLocation mCurrentLocation;
    private GetCityBean mCurrentCityBean;
    private NeedBean mAllCityBean; //全国
    private NeedBean mCityBean; //当前城市

    private List<MineNeedBean> mDatas;
    MineNeedAdapter mAdapter;

    private int mPage = 1;
    private int mRows = 10;

    // 计算倒计时的任务
    private CalculatorCountDownTask mCalculatorTask;

    private Handler calculatorHandler = new Handler(){
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            mCalculatorTask = new CalculatorCountDownTask();
            mCalculatorTask.execute();
        }
    };


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chakan_need);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("查看需求");
        setBack();

        mTypeVM = (NeedVM) new NeedVM(llGroup, rbAll).addModel(new BaseModel<List<BaseBean>>() {
            @Override
            public void getData(ModelBack<List<BaseBean>> modelBack) {
                List<BaseBean> datas = new ArrayList<>();
                datas.add(new NeedBean("1", "婚庆"));
                datas.add(new NeedBean("2", "商城"));
                modelBack.onBack(datas);
            }

            @Override
            public List<BaseBean> getData() {
                return null;
            }
        }).setRequestListDelegate(new PopwindowVM.RequestListDelegate() {
            @Override
            public void method(BaseBean baseBean) {
                mType = baseBean.getValue();
                requestNetData(true);
            }
        });

        mSortVM = (NeedVM) new NeedVM(llGroup, rbSort).addModel(new BaseModel<List<BaseBean>>() {
            @Override
            public void getData(ModelBack<List<BaseBean>> modelBack) {
                List<BaseBean> datas = new ArrayList<>();
                datas.add(new NeedBean(null, "浏览排序"));
                datas.add(new NeedBean(null, "价格排序"));
                datas.add(new NeedBean(null, "时间排序"));
                modelBack.onBack(datas);
            }

            @Override
            public List<BaseBean> getData() {
                return null;
            }
        }).setRequestListDelegate(new PopwindowVM.RequestListDelegate() {
            @Override
            public void method(BaseBean baseBean) {
                if(mCurrentSort.equals(baseBean.getName())){
                    mSort = SORT_DESC.equals(mSort) ? SORT_ASC : SORT_DESC;
                }else{
                    mSort = SORT_DESC; //如果选择了其他排序方式，则默认为由高到低
                }
                mCurrentSort = baseBean.getName();
                requestNetData(true);
            }
        });
        mCityVM = (NeedVM) new NeedVM(llGroup, rbLocation).addModel(new BaseModel<List<BaseBean>>() {
            @Override
            public void getData(ModelBack<List<BaseBean>> modelBack) {
                List<BaseBean> datas = new ArrayList<>();
                datas.add(createAllCityBean());
                modelBack.onBack(datas);
                requestCity(modelBack);
            }

            @Override
            public List<BaseBean> getData() {
                return null;
            }
        }).setRequestListDelegate(new PopwindowVM.RequestListDelegate() {
            @Override
            public void method(BaseBean baseBean) {
                if(baseBean == createAllCityBean()){//如果是全国
                    mCityId = baseBean.getValue();
                    mCountyId = "";// 清空区id
                }else if(baseBean == mCityBean){ // 选择的是当前城市
                    //选择的是当前城市，
                    mCityId = baseBean.getValue();
                    mCountyId = "";// 清空区id
                }else{// 选择的是区
                    mCountyId = baseBean.getValue();
                    mCityId = mCityBean.getValue();
                }
                requestNetData(true);
            }
        });

        LinearLayoutManager manager=new LinearLayoutManager(this);
        recycle.setLayoutManager(manager);
        mDatas = new ArrayList<>();
        mAdapter=new MineNeedAdapter(this, mDatas, false, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                MainNeedDetailsActivity.startActivity(MineChakanNeed2Activity.this, mDatas.get(postion));
            }
        });
        recycle.setAdapter(mAdapter);

        refreshLayout.setEnableRefresh(true);
        refreshLayout.setEnableLoadMore(true);
        refreshLayout.setRefreshHeader(new MyRefreshHeader(this));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(this));
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

    private void requestNetData(final boolean isRefresh){
        ApiManager.getNeedList(mType, mCityId, mCountyId,
                "浏览排序".equals(mCurrentSort) ? mSort : "",
                "价格排序".equals(mCurrentSort) ? mSort : "",
                "时间排序".equals(mCurrentSort) ? mSort : "",
                isRefresh ? 1 : mPage, mRows, new OnRequestFinish<com.linzi.xiguwen.net.base.BaseBean<List<MineNeedBean>>>() {
                    @Override
                    public void onFinished() {
                        refreshLayout.finishRefresh(0);
                        refreshLayout.finishLoadMore(0);
                    }

                    @Override
                    public void onSuccess(com.linzi.xiguwen.net.base.BaseBean<List<MineNeedBean>> data) {
                        if (isRefresh) {
                            mPage = 1;
                            mDatas.clear();
                        }
                        mPage++;
                        mDatas.addAll(data.getData());
                        mAdapter.notifyDataSetChanged();
                        if (mDatas.size() == 0) {
                            mNodataLayout.setVisibility(View.VISIBLE);
                        } else {
                            mNodataLayout.setVisibility(View.GONE);
                        }
                        if (data.getData().size() < mRows) {
                            refreshLayout.setNoMoreData(true);
                        } else {
                            refreshLayout.setNoMoreData(false);
                        }
                    }

                    @Override
                    public void onError(Exception ex) {
                        NToast.show(ex.getMessage());
                        com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                        if (mDatas.size() == 0) {
                            mNodataLayout.setVisibility(View.VISIBLE);
                        } else {
                            mNodataLayout.setVisibility(View.GONE);
                        }
                    }
                });
    }

    // 开始倒计时
    private void startCalcultor(){

    }


    //创建全国的条目对象
    private NeedBean createAllCityBean(){
        if(mAllCityBean == null){
            mAllCityBean = new NeedBean("", "全国");
        }
        return mAllCityBean;
    }

    private NeedBean createCurrentCityBean(GetCityBean cityBean){
        if(mCityBean == null){
            mCityBean = new NeedBean(cityBean.getId() + "", cityBean.getName());
        }
        return mCityBean;
    }

    /**
     * 获取当前城市, 及当前城市的区县信息
     * @param callBack
     */
    private void requestCity(final ModelBack<List<BaseBean>> callBack) {
        LocationHelper.requestLocation(new CustomLocationListener.ReceiveLocation() {
            @Override
            public void onLocation(BDLocation bdLocation) {
                mCurrentLocation = bdLocation;
                ApiManager.getCityId(bdLocation.getCity(), new OnRequestFinish<com.linzi.xiguwen.net.base.BaseBean<GetCityBean>>() {
                    @Override
                    public void onFinished() {

                    }

                    @Override
                    public void onSuccess(com.linzi.xiguwen.net.base.BaseBean<GetCityBean> data) {
                        mCurrentCityBean = data.getData();
                        List<BaseBean> datas = new ArrayList<>();
                        datas.add(createCurrentCityBean(mCurrentCityBean));
                        callBack.onBack(datas);
                        ApiManager.getCiteListe(data.getData().getId() + "", new OnRequestSubscribe<com.linzi.xiguwen.net.base.BaseBean<ArrayList<GetCityBean>>>() {
                            @Override
                            public void onSuccess(com.linzi.xiguwen.net.base.BaseBean<ArrayList<GetCityBean>> data) {
                                //获取城市列表
                                List<BaseBean> datas = new ArrayList<>();
                                for (GetCityBean cityBean : data.getData()) {
                                    datas.add(new NeedBean(cityBean.getId()+ "", cityBean.getName()));
                                }
                                callBack.onBack(datas);
                            }

                            @Override
                            public void onError(Exception ex) {
                                NToast.show("获取城市列表失败");
                            }
                        });
                    }

                    @Override
                    public void onError(Exception ex) {
                        NToast.show("获取城市id失败");
                    }
                });
            }
        });
    }

    class CalculatorCountDownTask extends AsyncTask<Void, Void, Boolean>{

        @Override
        protected Boolean doInBackground(Void... voids) {
            boolean result = false;
            if(mDatas != null){
                for (MineNeedBean data : mDatas) {
                    if(data.getCountdown() >= 60){ //大于等于1分钟
                        data.setCountdown(data.getCountdown() - 60);
                        result = true;
                    }else{
                        data.setCountdown(0);// 时间到了。
                    }
                }
            }
            return result;
        }

        @Override
        protected void onPostExecute(Boolean result) {
            super.onPostExecute(result);
            //执行完成， 通知刷新适配器
            if(result){
                mAdapter.notifyDataSetChanged();
                //一分钟刷新一次哟
                calculatorHandler.sendEmptyMessageDelayed(0, 60 * 1000);
            }
            mCalculatorTask = null;
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(resultCode == RESULT_OK){
            refreshLayout.autoRefresh();
        }
    }
}
