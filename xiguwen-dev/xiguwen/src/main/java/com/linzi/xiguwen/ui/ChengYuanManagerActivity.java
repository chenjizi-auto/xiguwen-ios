package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ChengyuanManagerAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.CommunityCenterEntity;
import com.linzi.xiguwen.bean.CommunityUserEntity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.yanzhenjie.recyclerview.swipe.SwipeMenu;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuBridge;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuCreator;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuItem;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuItemClickListener;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuRecyclerView;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

import static android.view.ViewGroup.LayoutParams.MATCH_PARENT;

public class ChengYuanManagerActivity extends BaseActivity {
    @BindView(R.id.ed_search)
    EditText edSearch;
    @BindView(R.id.recycle)
    SwipeMenuRecyclerView recycle;

    private ChengyuanManagerAdapter mAdapter;
    private String communityId;
    private String name;
    private int myJiaose;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_cheng_yuan_manager);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("成员管理");
        setBack();
        Intent intent = getIntent();
        communityId = intent.getStringExtra("id");
        myJiaose = intent.getIntExtra("jiaose", 1);
        LinearLayoutManager manager = new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);

        recycle.setSwipeMenuCreator(new SwipeMenuCreator() {
            @Override
            public void onCreateMenu(SwipeMenu swipeLeftMenu, SwipeMenu swipeRightMenu, int viewType) {
                SwipeMenuItem deleteItem = new SwipeMenuItem(mContext);
                deleteItem.setBackgroundColor(mContext.getResources().getColor(R.color.colorTitleRed));
                deleteItem.setHeight(MATCH_PARENT);
                deleteItem.setWidth(dip2px(66));
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

//                NToast.show("" + direction);
                CommunityUserEntity entity = mAdapter.getDatas().get(adapterPosition);
                if (myJiaose == 2) {
                    if (entity.getJiaose() == 1 || entity.getJiaose() == 2) {
                        NToast.show("无权限操作");
                        return;
                    }
                }

                if (myJiaose == 1 && entity.getJiaose() == 1) {
                    NToast.show("无法删除自己");
                    return;
                }
                httpUpdate(entity.getId(), Constans.Action.COMMUNITY_USER_MAMAGER_ADMIN_DELETE, adapterPosition);
            }
        });

        mAdapter = new ChengyuanManagerAdapter(mContext);
        mAdapter.setCloseListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener1() {
            @Override
            public void onItemClick(View view, int postion, Object data) {
                CommunityUserEntity entity = (CommunityUserEntity) data;
                httpUpdate(entity.getId(), Constans.Action.COMMUNITY_USER_MAMAGER_ADMIN_CANCEL, postion);
            }
        });
        mAdapter.setChooseGoodsListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener1() {
            @Override
            public void onItemClick(View view, int postion, Object data) {
                CommunityUserEntity entity = (CommunityUserEntity) data;
                httpUpdate(entity.getId(), Constans.Action.COMMUNITY_USER_MAMAGER_ADMIN_ADD, postion);
            }
        });
        mAdapter.setMyjiaose(myJiaose);
        recycle.setAdapter(mAdapter);

        edSearch.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {

                name = edSearch.getText().toString().trim();
                httpData();
            }
        });

        httpData();
    }


    private void httpData() {
        LoadDialog.showDialog(this);
        ApiManager.communityUserManagerList(communityId, name, new OnRequestSubscribe<BaseBean<List<CommunityUserEntity>>>() {
            @Override
            public void onSuccess(BaseBean<List<CommunityUserEntity>> data) {
//                NToast.show(data.getMessage());
                LoadDialog.CancelDialog();
                mAdapter.addFirst(data.getData());
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });
    }

    private void httpUpdate(String id, final String api, final int position) {
        LoadDialog.showDialog(this);
        ApiManager.communityUserManager(id, api, new OnRequestSubscribe<BaseBean<CommunityCenterEntity>>() {
            @Override
            public void onSuccess(BaseBean<CommunityCenterEntity> data) {
                LoadDialog.CancelDialog();
                NToast.show(data.getMessage());
                if (api.equals(Constans.Action.COMMUNITY_USER_MAMAGER_ADMIN_ADD)) {
                    mAdapter.getDatas().get(position).setJiaose(2);
                } else if (api.equals(Constans.Action.COMMUNITY_USER_MAMAGER_ADMIN_CANCEL)) {
                    mAdapter.getDatas().get(position).setJiaose(3);
                } else if (api.equals(Constans.Action.COMMUNITY_USER_MAMAGER_ADMIN_DELETE)) {
                    mAdapter.getDatas().remove(position);
                }
                mAdapter.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });
    }
}
