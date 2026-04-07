package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.LinearLayout;

import com.alibaba.fastjson.JSON;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.AddressManagerAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.AddressEntity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.luck.picture.lib.utils.ToastUtils;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class AddressManagerActivity extends BaseActivity {

    @BindView(R.id.recycle)
    RecyclerView recycle;

    AddressManagerAdapter managerAdapter;
    @BindView(R.id.ll_add)
    LinearLayout llAdd;

    private int tag = 0;
//    Handler mHandler = new Handler() {
//        @Override
//        public void handleMessage(Message msg) {
//            super.handleMessage(msg);
//            if (tag == 0) {
//                setRight("管理", managerListener);
//            } else {
//                setRight("完成", completeListener);
//            }
//        }
//    };

//    View.OnClickListener managerListener = new View.OnClickListener() {
//        @Override
//        public void onClick(View view) {
//            tag = 1;
//            managerAdapter.setTag(tag);
//            llAdd.setVisibility(View.VISIBLE);
////            mHandler.sendEmptyMessage(0);
//        }
//    };
//
//
//    View.OnClickListener completeListener = new View.OnClickListener() {
//        @Override
//        public void onClick(View view) {
//            tag = 0;
//            managerAdapter.setTag(tag);
//            llAdd.setVisibility(View.GONE);
//            mHandler.sendEmptyMessage(0);
//        }
//    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_address_manager);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {

        tag = getIntent().getIntExtra("tag", 0);
        setTitle("收货地址");
        setBack();

        EventBusUtil.register(this);
        LinearLayoutManager manager = new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);
        managerAdapter = new AddressManagerAdapter(mContext);
        recycle.setAdapter(managerAdapter);
        managerAdapter.setTag(tag);
        if (tag == 0) {
            setRight("管理", new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(mContext, AddressManagerActivity.class);
                    intent.putExtra("tag", 1);
                    startActivity(intent);
                }
            });
        } else {
            llAdd.setVisibility(View.VISIBLE);
        }
//        mHandler.sendEmptyMessage(0);

        llAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(mContext, AddAddressActivity.class);
                startActivity(intent);
            }
        });

        httpData();
        event();
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (tag==0){
            httpData();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        EventBusUtil.unregister(this);
    }

    private void event() {
        managerAdapter.setmDeleteListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener1() {
            @Override
            public void onItemClick(View view, int postion, Object data) {

                httpDelete(data.toString(), postion);
            }
        });

        managerAdapter.setmDefaultListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener1() {
            @Override
            public void onItemClick(View view, int postion, Object data) {

                httpDefault(data.toString(), postion);
            }
        });

        managerAdapter.setmUpdateListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener1() {
            @Override
            public void onItemClick(View view, int postion, Object data) {

                Intent intent = new Intent(mContext, AddAddressActivity.class);
                AddressEntity addressEntity = (AddressEntity) data;
                intent.putExtra("data", JSON.toJSONString(addressEntity));
                startActivity(intent);
            }
        });
    }

    private void httpData() {
        ApiManager.addressList(new OnRequestSubscribe<BaseBean<List<AddressEntity>>>() {
            @Override
            public void onSuccess(BaseBean<List<AddressEntity>> data) {
                managerAdapter.addFirst(data.getData());
            }

            @Override
            public void onError(Exception ex) {
                ToastUtils.showToast(mContext, ex.getMessage());
            }
        });
    }

    private void httpDefault(String id, final int position) {
        LoadDialog.showDialog(mContext);
        ApiManager.addressDefault(id, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                try {
                    managerAdapter.getDatas().get(managerAdapter.getDefaultPosition()).setHot(0);
                    managerAdapter.getDatas().get(position).setHot(1);
                    managerAdapter.notifyDataSetChanged();
                } catch (Exception e) {

                }


            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, ex.getMessage());
            }
        });
    }

    private void httpDelete(String id, final int position) {
        LoadDialog.showDialog(this);
        ApiManager.addressDelete(id, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                try {
                    managerAdapter.getDatas().remove(position);
                    managerAdapter.notifyDataSetChanged();
                } catch (Exception e) {
                }
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, ex.getMessage());
            }
        });
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.ADDRESS_ADD:
                    httpData();
                    break;
            }
        } catch (Exception e) {
        }
    }
}
