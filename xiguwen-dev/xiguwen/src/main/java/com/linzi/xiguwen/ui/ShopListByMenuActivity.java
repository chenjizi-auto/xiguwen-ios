package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ShopSearchAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.CityEntity;
import com.linzi.xiguwen.bean.SearchSJBean;
import com.linzi.xiguwen.fragment.vm.RefreshViewModel;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.widget.NestRadioGroup;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by pc on 2018/4/25.
 */

public class ShopListByMenuActivity extends BaseActivity {


    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.ed_search)
    EditText edSearch;
    @BindView(R.id.tv_chadang)
    TextView tvChadang;
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
    RecyclerView hotRecycle;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;


    private CityEntity cityEntity;
    private String content = "";
    private int cityType = 1;
    private String price = null;
    private int salesvolume;
    private int comprehensive;
    private RefreshViewModel mRefreshViewModel;
    private int typeid;

    private ShopSearchAdapter mAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mall_list);
        ButterKnife.bind(this);
        typeid = getIntent().getIntExtra("id", -1);
        initView();
    }

    @Override
    protected void initData() {

    }

    private void initView() {
        setTopBarVisibility(View.GONE);

        llScreen.setVisibility(View.GONE);
        rbOne.setText("价格排序");
        rbTwo.setText("综合排序");
        rbThree.setText("销量排序");
        initList();

        rbGroup.setOnCheckedChangeListener(new NestRadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(NestRadioGroup group, int checkedId) {
                if (checkedId == rbTwo.getId()) {
                    price = null;
                    comprehensive = 1;
                    salesvolume = 0;
                    mRefreshViewModel.autoRefresh();
                } else if (checkedId == rbThree.getId()) {
                    price = null;
                    comprehensive = 0;
                    salesvolume = 1;
                    mRefreshViewModel.autoRefresh();
                }
            }
        });

        cityEntity = Preferences.getCity();
        setCityType(cityType);
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

    private void initList() {
        GridLayoutManager manager = new GridLayoutManager(mContext, 2);
        mAdapter = new ShopSearchAdapter(mContext);
        hotRecycle.setLayoutManager(manager);
        hotRecycle.setAdapter(mAdapter);
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
        ApiManager.searchGoodsByType(comprehensive, typeid, content, page, row, price, salesvolume, new OnRequestFinish<BaseBean<SearchSJBean>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishRefresh();
            }

            @Override
            public void onSuccess(BaseBean<SearchSJBean> data) {
                refreshLayout.finishRefresh();
                noDataView.setVisibility(View.GONE);
                mAdapter.addFirst(data.getData().getShop());
                hotRecycle.scrollToPosition(0);
                if (data.getData().getAnli().size() == 0) {
                    refreshLayout.setEnableLoadMore(false);
                    noDataView.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void loadMore(@NonNull final RefreshLayout refreshLayout, String page, String row) {

        ApiManager.searchGoodsByType(comprehensive, typeid, content, page, row, price, salesvolume, new OnRequestFinish<BaseBean<SearchSJBean>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishRefresh();
            }

            @Override
            public void onSuccess(BaseBean<SearchSJBean> data) {
                SearchSJBean bean = data.getData();
                refreshLayout.finishLoadMore();
                if (bean.getAnli().size() == 0) {
                    refreshLayout.setEnableLoadMore(false);
                } else {
                    mAdapter.addMore(bean.getShop());
                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    @OnClick({R.id.rb_one, R.id.tv_chadang, R.id.iv_back})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.rb_one:
                comprehensive = 0;
                salesvolume = 0;
                if (price != null && price.equals("desc")) {
                    price = "asc";
                } else {
                    price = "desc";
                }
                mRefreshViewModel.autoRefresh();
                break;
            case R.id.tv_chadang:
                String content = edSearch.getText().toString().trim();
                setSearchContent(content);
                break;
            case R.id.iv_back:
                finish();
                break;
        }

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
         
    }

}
