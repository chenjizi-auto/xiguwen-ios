package com.linzi.xiguwen.ui;

import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;

import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MineJizhangAdapter;
import com.linzi.xiguwen.bean.BillDataBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.DPUtils;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.PopJiZhangKeyBordeUtils;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.TimeSeletctUtil;
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

import java.text.SimpleDateFormat;
import java.util.Calendar;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class MineJizhangzhushouActivity extends AppCompatActivity {

    @BindView(R.id.LL_bar)
    LinearLayout LLBar;
    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.iv_add)
    ImageView ivAdd;
    @BindView(R.id.tv_date)
    TextView tvDate;
    @BindView(R.id.tv_zhichu)
    TextView tvZhichu;
    @BindView(R.id.tv_shouru)
    TextView tvShouru;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;

    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.recycle)
    SwipeMenuRecyclerView recycle;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;

    private Context mContext;

    private int mPage = 1;
    private int mRows = 10;
    MineJizhangAdapter mAdapter;
    private BillDataBean mDatas;
    private long mDate;

    private Calendar mJiZhangDate;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(MineJizhangzhushouActivity.this, R.color.trans);
        }

        setContentView(R.layout.activity_mine_jizhangzhushou);
        ButterKnife.bind(this);
        mContext = this;
        initViews();
    }

    private void initViews() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(MineJizhangzhushouActivity.this));
        LLBar.setLayoutParams(params);

        LinearLayoutManager manager = new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);
        recycle.setSwipeMenuCreator(new SwipeMenuCreator() {
            @Override
            public void onCreateMenu(SwipeMenu swipeLeftMenu, SwipeMenu swipeRightMenu, int viewType) {
                if(viewType == MineJizhangAdapter.TYPE_CHILD){
                    SwipeMenuItem item = new SwipeMenuItem(MineJizhangzhushouActivity.this);
                    item.setBackgroundColorResource(R.color.red_color);
                    item.setText("删除");
                    item.setTextColorResource(R.color.colorWhite);
                    item.setHeight(ViewGroup.LayoutParams.MATCH_PARENT);
                    item.setWidth((int) DPUtils.DPToPX(MineJizhangzhushouActivity.this, 80));
                    swipeRightMenu.addMenuItem(item);
                }
            }
        });
        recycle.setSwipeMenuItemClickListener(new SwipeMenuItemClickListener() {
            @Override
            public void onItemClick(SwipeMenuBridge menuBridge) {
                int position = menuBridge.getAdapterPosition();
                BillDataBean.Bill child = mAdapter.getChild(position);
                delBill(position, child);

            }
        });

        mAdapter = new MineJizhangAdapter(mContext);
        recycle.setAdapter(mAdapter);




        refreshLayout.setEnableRefresh(true);
        refreshLayout.setEnableLoadMore(true);
        refreshLayout.setRefreshHeader(new MyRefreshHeader(this));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(this));
        refreshLayout.setEnableLoadMoreWhenContentNotFull(true); // 设置没有满屏也可以加载更多
        refreshLayout.setOnRefreshLoadMoreListener(new OnRefreshLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                requestNetData(false, mDate);
            }

            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                requestNetData(true, mDate);
            }
        });

        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        mDate = calendar.getTimeInMillis() / 1000;

        tvDate.setText(new SimpleDateFormat("yyyy年MM月").format(calendar.getTime()));
        refreshLayout.autoRefresh();
    }

    private void delBill(final int position, final BillDataBean.Bill bill) {
        if(bill != null){
            final AskDialog dialog = new AskDialog(this, this );
            dialog.setTitle("警告");
            dialog.setMessage("是否删除该记录？");
            dialog.setCancleListener("我点错了", new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    dialog.dismiss();
                }
            });

            dialog.setSubmitListener("确认删除", new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    _delBill(position, bill);
                }
            });
            dialog.show();
        }
    }

    private void _delBill(final int position, final BillDataBean.Bill bill) {
        MsgLoadDialog.showDialog(this, "删除中...");
        ApiManager.delBill(bill.getId(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("删除成功");
                for (BillDataBean.BillList billList : mDatas.getList()) {
                    if(billList != null && billList.getTian() != null && billList.getTian().contains(bill)){
                        billList.getTian().remove(bill);
                        mAdapter.notifyItemRemoved(position);
                    }
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    //请求网络数据
    private void requestNetData(final boolean refresh, final long date){
        ApiManager.getBillList(refresh ? 1 : mPage, mRows, date, new OnRequestFinish<BaseBean<BillDataBean>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishRefresh(0);
                refreshLayout.finishLoadMore(0);
            }

            @Override
            public void onSuccess(BaseBean<BillDataBean> data) {
                if (refresh) {
                    mPage = 1;
                    mDatas = data.getData();
                    mAdapter.setData(mDatas);
                }else{
                    mDatas.append(data.getData());
                    mAdapter.notifyDataSetChanged();
                }
                tvZhichu.setText(mDatas.getDzhichu() + "");
                tvShouru.setText(mDatas.getDshuru() + "");
                mPage++;
                int cacheCount = 0;
                for (BillDataBean.BillList billList : data.getData().getList()) {
                    cacheCount += billList.getTian().size();
                }
                if(cacheCount < mRows){
                    refreshLayout.setNoMoreData(true);
                }else{
                    refreshLayout.setNoMoreData(false);
                }

                if(mDatas.getList() == null || mDatas.getList().size() == 0){
                    mNodataLayout.setVisibility(View.VISIBLE);
                }else{
                    mNodataLayout.setVisibility(View.GONE);
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                if (mDatas == null || mDatas.getList().size() == 0) {
                    mNodataLayout.setVisibility(View.VISIBLE);
                } else {
                    mNodataLayout.setVisibility(View.GONE);
                }
            }
        });
    }

    // 添加记账
    private void addBill(int type, String price, String remark, final long timeInMillis){
        MsgLoadDialog.showDialog(this, "添加中...");
        ApiManager.addBill(price, timeInMillis, remark, type, new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                if(popJiZhangKeyBordeUtils != null){
                    popJiZhangKeyBordeUtils.dismiss();
                    popJiZhangKeyBordeUtils = null;
                }
//                if(timeInMillis == mDate){
                    requestNetData(true, mDate);
//                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }


    PopJiZhangKeyBordeUtils popJiZhangKeyBordeUtils;
    @OnClick({R.id.iv_back, R.id.iv_add, R.id.tv_date, R.id.iv_date})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.iv_back:
                finish();
                break;
            case R.id.iv_add:
                mJiZhangDate = Calendar.getInstance();
                mJiZhangDate.set(Calendar.HOUR, 0);
                mJiZhangDate.set(Calendar.MINUTE, 0);
                mJiZhangDate.set(Calendar.SECOND, 0);
                popJiZhangKeyBordeUtils = new PopJiZhangKeyBordeUtils(MineJizhangzhushouActivity.this)
                        .setKeyListenner(new PopJiZhangKeyBordeUtils.KeyClickListener() {
                            @Override
                            public void keyListener(StringBuffer values_key) {

                            }
                        })
                        .setTodayListener(new PopJiZhangKeyBordeUtils.TodayListener() {
                            @Override
                            public void todayListener(View view) {
                                popJiZhangKeyBordeUtils.dismiss();
                                chooseDate();
                            }
                        })
                        .setSubmitListenner(new PopJiZhangKeyBordeUtils.SubmitListener() {
                            @Override
                            public void submitListener(PopJiZhangKeyBordeUtils utils, View view) {
                                if(utils.getRemark().trim().length() > 12){
                                    NToast.show("备注内容不能超过12个字");
                                    return;
                                }
                                addBill(utils.getType(), utils.getPrice(), utils.getRemark(), mJiZhangDate.getTimeInMillis() / 1000);
                            }
                        })
                        .show(llParent);
                break;
            case R.id.tv_date:
            case R.id.iv_date:
                new TimeSeletctUtil(this).isDay(false).setListener(new TimeSeletctUtil.getDataListener() {
                    @Override
                    public void getData(int y, int m, int d, String w) {
                        Calendar calendar = Calendar.getInstance();
                        calendar.set(y, m, d);
                        calendar.set(Calendar.HOUR, 0);
                        calendar.set(Calendar.MINUTE, 0);
                        calendar.set(Calendar.SECOND, 0);
                        calendar.set(Calendar.DAY_OF_MONTH, 1);
                        mDate = calendar.getTimeInMillis() / 1000;

                        tvDate.setText(new SimpleDateFormat("yyyy年MM月").format(calendar.getTime()));
                        refreshLayout.autoRefresh();
                    }

                    @Override
                    public void getToday(int toyear, int tomonth, int today) {

                    }

                    @Override
                    public void getHous(int hour, int m) {

                    }
                }).selectDate(llParent);
                break;
        }
    }

    private void chooseDate(){
        new TimeSeletctUtil(this).isDay(true).setListener(new TimeSeletctUtil.getDataListener() {
            @Override
            public void getData(int y, int m, int d, String w) {
                mJiZhangDate = Calendar.getInstance();
                mJiZhangDate.set(y, m, d, 0, 0 , 0);
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                popJiZhangKeyBordeUtils.setTodayText(dateFormat.format(mJiZhangDate.getTime()));
                popJiZhangKeyBordeUtils.show();
            }

            @Override
            public void getToday(int toyear, int tomonth, int today) {

            }

            @Override
            public void getHous(int hour, int m) {

            }
        }).selectDate(llParent);
    }
}
