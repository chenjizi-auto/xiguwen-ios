package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import android.view.View;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ChooseBankCardAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.BankCardEntity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.luck.picture.lib.utils.ToastUtils;
import com.yanzhenjie.recyclerview.swipe.SwipeMenu;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuBridge;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuCreator;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuItem;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuItemClickListener;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuRecyclerView;


import butterknife.BindView;
import butterknife.ButterKnife;

import static android.view.ViewGroup.LayoutParams.MATCH_PARENT;

public class ChooseBankCardActivity extends BaseActivity {

    @BindView(R.id.recycle)
    SwipeMenuRecyclerView recycle;

    ChooseBankCardAdapter mAdapter;
    private int bandId;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_choose_bank_card);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("选择账户");
        setBack();
        bandId = getIntent().getIntExtra("bandId", -1);
        setRightAdd(R.mipmap.icon_right_add, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(mContext, AddCardStep1Activity.class);
                startActivity(intent);
            }
        });

        final LinearLayoutManager manager = new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);

        recycle.setSwipeMenuCreator(new SwipeMenuCreator() {
            @Override
            public void onCreateMenu(SwipeMenu swipeLeftMenu, SwipeMenu swipeRightMenu, int viewType) {
                SwipeMenuItem deleteItem = new SwipeMenuItem(mContext);
                deleteItem.setBackgroundColor(mContext.getResources().getColor(R.color.colorTitleRed));
                deleteItem.setHeight(MATCH_PARENT);
                deleteItem.setWidth(AppUtil.dip2px(mContext, 100));
                deleteItem.setText("删除");
                deleteItem.setTextColor(mContext.getResources().getColor(R.color.white));
                // 各种文字和图标属性设置。
                swipeRightMenu.addMenuItem(deleteItem); // 在Item左侧添加一个菜单。
            }
        });
        recycle.setSwipeMenuItemClickListener(new SwipeMenuItemClickListener() {
            @Override
            public void onItemClick(SwipeMenuBridge menuBridge) {
                // 任何操作必须先关闭菜单，否则可能出现Item菜单打开状态错乱。
                menuBridge.closeMenu();

                int direction = menuBridge.getDirection(); // 左侧还是右侧菜单。
                int adapterPosition = menuBridge.getAdapterPosition(); // RecyclerView的Item的position。
                int menuPosition = menuBridge.getPosition(); // 菜单在RecyclerView的Item中的Position。
//                delGoods(list.get(adapterPosition));
                delete(adapterPosition);
            }
        });

        mAdapter = new ChooseBankCardAdapter(mContext, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                mAdapter.setChoose(postion);
            }
        });
        recycle.setAdapter(mAdapter);


    }

    @Override
    protected void onResume() {
        super.onResume();
        httpData();
    }

//    private void httpData() {
//        ApiManager.bankCardList(new OnRequestSubscribe<BaseBean<List<BankCardEntity>>>() {
//            @Override
//            public void onSuccess(BaseBean<List<BankCardEntity>> data) {
//                mAdapter.addFirst(data.getData());
//                mAdapter.setChoose(bandId);
//            }
//
//            @Override
//            public void onError(Exception ex) {
//
//            }
//        });
//    }

    private void httpData() {
        ApiManager.aliPayList(new OnRequestSubscribe<BaseBean<BankCardEntity>>() {
            @Override
            public void onSuccess(BaseBean<BankCardEntity> data) {
                mAdapter.addFirst(data.getData().getList());
                mAdapter.setChoose(bandId);
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void delete(final int position) {
        LoadDialog.showDialog(mContext);
        String id = mAdapter.getDatas().get(position).getId() + "";
        ApiManager.aliPayDelete(id, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, data.getMessage());
                mAdapter.getDatas().remove(position);
                mAdapter.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, ex.getMessage());
            }
        });
    }
}
