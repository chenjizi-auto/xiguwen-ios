package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RadioButton;

import com.alibaba.fastjson.JSONObject;
import com.example.zhouwei.library.CustomPopWindow;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.CaseClassificationAdapter;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ExampleFragmentAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.CaseTypeEntity;
import com.linzi.xiguwen.bean.CityEntity;
import com.linzi.xiguwen.bean.SearchSJBean;
import com.linzi.xiguwen.cache.OnCacheRequestFinish;
import com.linzi.xiguwen.cache.repository.WeddingDictionaryRepository;
import com.linzi.xiguwen.fragment.vm.RefreshViewModel;
import com.linzi.xiguwen.interfacelistener.PopSelectListener;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.view.ScreenPopWindow;
import com.linzi.xiguwen.widget.NestRadioGroup;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import org.xutils.common.Callback;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by pc on 2018/4/25.
 */

public class    SearchExampleActivty extends BaseActivity implements ScreenPopWindow.ScreenPopSelectListener, PopSelectListener, com.jcodecraeer.xrecyclerview.OnItemClickListener {

    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.ed_search)
    EditText edSearch;
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
    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.no_data_view)
    ImageView noDataView;

    private ScreenPopWindow screenPopWindow;

    private List<CaseTypeEntity> typeEntities;
    private List<CaseTypeEntity> environMentEntites;

    private CityEntity cityEntity;
    private String content = "";
    private int cityType = 1;
    private int cityid;
    private String floorprice;
    private String ceilingprice;
    private int comprehensive;
    private RefreshViewModel mRefreshViewModel;
    private int typeId;
    private int envitonmentId;

    private ExampleFragmentAdapter mAdapter;

    private CaseTypeEntity typeEntity0;
    private CaseTypeEntity typeEntity1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.search_case_layout);
        ButterKnife.bind(this);
        initView();
    }

    private void initView() {
        setTopBarVisibility(View.GONE);

        rbOne.setText("类型");
        rbTwo.setText("环境");
        rbThree.setText("综合排序");

        typeEntity0 = new CaseTypeEntity();
        typeEntity0.setTitle("全部类型");
        typeEntity0.setId(0);

        typeEntity1 = new CaseTypeEntity();
        typeEntity1.setTitle("全部环境");
        typeEntity1.setId(0);

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

        initList();
        event();
        cityEntity = Preferences.getCity();
        setCityType(cityType);
        mRefreshViewModel.autoRefresh();
        httpType();
        httpEnvironment();
        mRefreshViewModel.autoRefresh();
    }

    @Override
    protected void initData() {

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
         
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

    private void event() {
        rbGroup.setOnCheckedChangeListener(new NestRadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(NestRadioGroup group, int checkedId) {
                if (checkedId == rbThree.getId()) {
                    comprehensive = 1;
                    mRefreshViewModel.autoRefresh();
                } else {
                    comprehensive = 0;
                }
            }
        });


        mAdapter.setListener(new CallBack.CaseCareClikListener() {
            @Override
            public void CaseCareClik(int postion) {
                if (mAdapter.getData().get(postion).getAfollow() == 1) {
                    delCare(mAdapter.getData().get(postion).getId(), postion);
                } else {
                    addCare(mAdapter.getData().get(postion).getId(), postion);
                }
            }
        });

        mAdapter.setListener(new CallBack.CaseUserClikListener() {
            @Override
            public void CaseUserClik(int postion) {
                Intent intent = new Intent(mContext, NewMallDetailsActivity.class);
                intent.putExtra("shop_id", mAdapter.getData().get(postion).getUserid());
                startActivity(intent);
            }
        });
    }


    //关注商家
    private void addCare(final int id, final int postion) {
        LoadDialog.showDialog(mContext);
        new ApiManager().isCarUser("" + id, "" + SPUtil.get("token", SPUtil.Type.STR), "" + SPUtil.get("userid", SPUtil.Type.INT), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                NToast.log("TAG-------关注结果", result + "   TAG-------案例id" + id);
                com.linzi.xiguwen.bean.BaseBean base = JSONObject.parseObject(result, com.linzi.xiguwen.bean.BaseBean.class);
                if (base.getCode() == 0) {
                    mAdapter.refreshCare(postion, 1);
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

    //取消关注
    private void delCare(final int id, final int postion) {
        LoadDialog.showDialog(mContext);
        new ApiManager().cancelCarUser("" + id, "" + SPUtil.get("token", SPUtil.Type.STR), "" + SPUtil.get("userid", SPUtil.Type.INT), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {

                NToast.log("TAG-------取关结果", result + "   TAG-------案例id" + id);
                com.linzi.xiguwen.bean.BaseBean base = JSONObject.parseObject(result, com.linzi.xiguwen.bean.BaseBean.class);
                if (base.getCode() == 0) {
                    mAdapter.refreshCare(postion, 0);
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

    private void httpType() {
        WeddingDictionaryRepository.getInstance(this).getWeddingCaseTypes(new OnCacheRequestFinish<List<CaseTypeEntity>>() {
            @Override
            public void onSuccess(List<CaseTypeEntity> data, boolean fromCache) {
                typeEntities = data;
                typeEntities.add(0, typeEntity0);
            }

            @Override
            public void onError(Exception ex) {

            }

            @Override
            public void onFinished() {
            }
        });
    }

    private void httpEnvironment() {
        WeddingDictionaryRepository.getInstance(this).getWeddingCaseEnvironments(new OnCacheRequestFinish<List<CaseTypeEntity>>() {
            @Override
            public void onSuccess(List<CaseTypeEntity> data, boolean fromCache) {
                environMentEntites = data;
                environMentEntites.add(0, typeEntity1);
            }

            @Override
            public void onError(Exception ex) {

            }

            @Override
            public void onFinished() {
            }
        });
    }

    private void initList() {
        LinearLayoutManager manager = new LinearLayoutManager(mContext);
        mAdapter = new ExampleFragmentAdapter(mContext, this);
        recycleview.setLayoutManager(manager);
        recycleview.setAdapter(mAdapter);
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
        ApiManager.searchCase(page, row, content, cityEntity.getId(), cityType,
                "al", envitonmentId, typeId, comprehensive, floorprice, ceilingprice,
                new OnRequestSubscribe<BaseBean<SearchSJBean>>() {
                    @Override
                    public void onSuccess(BaseBean<SearchSJBean> data) {
                        refreshLayout.finishRefresh();
                        recycleview.scrollToPosition(0);
                        mAdapter.addFirst(data.getData().getAnli());
                        noDataView.setVisibility(View.GONE);
                        if (data.getData().getAnli().size() == 0) {
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

        if(Preferences.getCity()!=null &&  ((Integer) Preferences.getCity().getId()) != null) {
            cityid = Preferences.getCity().getId();
        }else{
            cityid=273;
        }
        ApiManager.searchCase(page, row, content, cityid, cityType,
                "al", envitonmentId, typeId, comprehensive, floorprice, ceilingprice,
                new OnRequestSubscribe<BaseBean<SearchSJBean>>() {
                    @Override
                    public void onSuccess(BaseBean<SearchSJBean> data) {
                        SearchSJBean bean = data.getData();
                        refreshLayout.finishLoadMore();
                        if (bean.getAnli().size() == 0) {
                            refreshLayout.setEnableLoadMore(false);
                        } else {
                            mAdapter.addMore(bean.getAnli());
                        }
                    }

                    @Override
                    public void onError(Exception ex) {
                        refreshLayout.finishRefresh();
                    }
                });
    }


    private ListView listView;
    private CaseClassificationAdapter listAdapter;
    private CustomPopWindow mListPopWindow;

    private void showPopListView(int code) {
        if (mListPopWindow == null) {
            View contentView = LayoutInflater.from(mContext).inflate(R.layout.pop_list, null);
            //处理popWindow 显示内容
            listView = contentView.findViewById(R.id.pop_list);
            listAdapter = new CaseClassificationAdapter(mContext, this);
            listView.setAdapter(listAdapter);
            //创建并显示popWindow
            mListPopWindow = new CustomPopWindow.PopupWindowBuilder(mContext)
                    .setView(contentView)
                    .size(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)//显示大小
                    .setOutsideTouchable(true)
                    .create();
        }
        listAdapter.setCode(code);
        if (code == CaseClassificationAdapter.CODE_TYPE) {
            listAdapter.addFirst(typeEntities);
        } else if (code == CaseClassificationAdapter.CODE_ENVITONMENT) {
            listAdapter.addFirst(environMentEntites);
        }
        mListPopWindow.showAsDropDown(rbGroup, 0, 0);
    }


    @OnClick({R.id.rb_one, R.id.rb_two, R.id.rb_screen, R.id.tv_chadang,R.id.iv_back})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.rb_one:
                showPopListView(CaseClassificationAdapter.CODE_TYPE);
                break;
            case R.id.rb_two:
                showPopListView(CaseClassificationAdapter.CODE_ENVITONMENT);
                break;
            case R.id.rb_screen:
                if (screenPopWindow == null) {
                    screenPopWindow = new ScreenPopWindow(SearchExampleActivty.this, this);
                    screenPopWindow.hideHeaderView();
                }
                screenPopWindow.show(rbScreen);
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
    public void ScreenSelect(String floorprice, String ceilingprice, int college, int isshopvip, int platform, int sincerity, int team) {
        this.floorprice = floorprice;
        this.ceilingprice = ceilingprice;
        mRefreshViewModel.autoRefresh();
    }


    @Override
    public void popSelect(int code, int id, String title) {

        if (code == CaseClassificationAdapter.CODE_TYPE) {
            typeId = id;
            rbOne.setText(title);
        } else if (code == CaseClassificationAdapter.CODE_ENVITONMENT) {
            listAdapter.addFirst(environMentEntites);
            envitonmentId = id;
            rbTwo.setText(title);
        }
        mListPopWindow.dissmiss();
        mRefreshViewModel.autoRefresh();
    }

    @Override
    public void onItemClick(View view, int postion) {
        Intent intent = new Intent(mContext, NewExampleDetailsActivity.class);
        intent.putExtra("caseid", mAdapter.getData().get(postion).getId());//传递案例id
        mContext.startActivity(intent);
    }
}
