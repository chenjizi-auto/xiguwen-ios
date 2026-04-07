package com.linzi.xiguwen.ui;

import android.content.Context;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.AllClassAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MenuTypeBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/4/8.
 */

public class ShopAllMenuActivity extends BaseActivity {
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.no_data_view)
    ImageView noDataView;
    private List<MenuTypeBean> list;
    private Context mContext;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_all_classic);
        ButterKnife.bind(this);
        mContext = this;

    }

    @Override
    protected void initData() {
        setTitle("全部分类");
        setBack();
        LinearLayoutManager manager = new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);
        getData();
    }

    private void getData() {
        LoadDialog.showDialog(mContext);
        ApiManager.getShopMenuType(new OnRequestFinish<BaseBean<ArrayList<MenuTypeBean>>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ArrayList<MenuTypeBean>> data) {
                list = data.getData();
                if (list != null && list.size() > 0) {
                    recycle.setAdapter(new AllClassAdapter(mContext, new CallBack.OnMenuItemClickListener() {
                        @Override
                        public void itemClick(int position) {
                            NToast.show("菜单" + position);
                        }

                        @Override
                        public void itemClick(int position, String name) {

                        }
                    }, list,1));
                    noDataView.setVisibility(View.GONE);
                } else {
                    noDataView.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }
}
