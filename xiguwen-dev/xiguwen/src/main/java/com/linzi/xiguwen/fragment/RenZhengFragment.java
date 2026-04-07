package com.linzi.xiguwen.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.RenZhengAdapter;
import com.linzi.xiguwen.bean.RenZhengListBean;
import com.linzi.xiguwen.bean.RenZhengOrderBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.DianPuRenZhengActivity;
import com.linzi.xiguwen.ui.ToPayActivity;
import com.linzi.xiguwen.ui.ToRenZhengActivity;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.AlertDialog;
import com.linzi.xiguwen.view.RzDialog;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by PC on 2018-03-27.
 */

public class RenZhengFragment extends Fragment implements RenZhengAdapter.OnItemClickListener {

    public static final int TAG_RENZHENG_PINGTAI = 0x01; //平台
    public static final int TAG_RENZHENG_CHENGXIN = 0x10;  // c诚信
    public static final int TAG_RENZHENG_XUEYUAN = 0x11;    // 学院

    @BindView(R.id.rv_content)
    RecyclerView mRecyclerView;

    private int mTag;
    private RenZhengAdapter mAdapter;
    private List<RenZhengListBean.RenZhengBean> mDatas;

    public static RenZhengFragment newInstance(int tag) {
        RenZhengFragment fragment = new RenZhengFragment();
        Bundle bundle = new Bundle();
        bundle.putInt("tag", tag);
        fragment.setArguments(bundle);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_renzheng, null);
        ButterKnife.bind(this, view);
        EventBusUtil.register(this);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mTag = getArguments().getInt("tag");
        initVIews();

    }

    private void initVIews() {
        if (mDatas == null) {
            mDatas = new ArrayList<>();
        }
        DianPuRenZhengActivity activity = (DianPuRenZhengActivity) getActivity();
        List<RenZhengListBean.RenZhengBean> data = activity.getData(mTag);
        if (data != null) {
            mDatas.addAll(data);
        }
        mRecyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));
        mAdapter = new RenZhengAdapter(getContext(), mDatas, mTag);
        mRecyclerView.setAdapter(mAdapter);

        mAdapter.setOnItemClickListener(this);
    }

    // 提供给activity设置数据
    public void setDatas(List<RenZhengListBean.RenZhengBean> datas) {
        if (mRecyclerView != null) {
            mDatas.clear();
            mDatas.addAll(datas);
            mAdapter.notifyDataSetChanged();
        }
    }

    // 弹出认证对话框
    public void renZheng(final RenZhengListBean.RenZhengBean bean) {
        final RzDialog dialog = new RzDialog(getContext());
        dialog.setMessage("认证费用：");
        if (mTag == TAG_RENZHENG_CHENGXIN) {
            // 设置为列表
            dialog.setList(bean.getJine());
        } else {
            dialog.setPrice(Constans.RMB + bean.getParameter2());
        }
        dialog.setCancleListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
        if (mTag != TAG_RENZHENG_CHENGXIN) {
            dialog.showRemark(true);
        }
        dialog.setSubmitListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
                if (mTag == TAG_RENZHENG_CHENGXIN) {
                    RenZhengListBean.ChengXin chengXin = bean.getJine().get(dialog.getChooseId());
                    submitRenZheng(chengXin.getParameter2(), chengXin.getId(), dialog.getRemark());
                } else {
                    submitRenZheng(bean.getParameter2(), bean.getId(), dialog.getRemark());
                }
            }
        });
        dialog.show();
    }


    /**
     * 退保证金操作
     *
     * @param data
     */
    private void refund(final RenZhengListBean.RenZhengBean data) {
        final AlertDialog dialog = new AlertDialog(getContext());
        dialog.setTitle("提示");
        dialog.setMessage("您确定要退诚信保证金吗？这将导您无法加入消费者保障计划哦！");
        dialog.setCancleListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
            }
        });
        dialog.setConfirmListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
                requestRefund(data);
            }
        });
        dialog.show();
    }

    /**
     * 退保证金请求
     *
     * @param data
     */
    public void requestRefund(RenZhengListBean.RenZhengBean data) {
        MsgLoadDialog.showDialog(getContext(), "退款中...");
        ApiManager.refundRenZheng(data.getId(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("退款成功");
                ((DianPuRenZhengActivity) getActivity()).requestNetData();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    /**
     * 提交认证订单
     */
    public void submitRenZheng(final String price, int id, String remark) {
        if (price != null) {
            LoadDialog.showDialog(getContext());
            ApiManager.submitRenZheng(price, remark, id, new OnRequestFinish<BaseBean<RenZhengOrderBean>>() {
                @Override
                public void onFinished() {
                    LoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean<RenZhengOrderBean> data) {
                    //TODO 跳转支付界面
                    Intent intent = new Intent(getContext(), ToPayActivity.class);
                    intent.putExtra("price", price);
                    intent.putExtra("order_id_str", data.getData().getDingdanid());
                    intent.putExtra("intentType", 2);
                    startActivity(intent);
                }

                @Override
                public void onError(Exception ex) {
                    NToast.show(ex.getMessage());
                    com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                }
            });
        }
    }

    @Override
    public void onClick(RenZhengListBean.RenZhengBean data, int position) {
        switch (mTag) {
            case TAG_RENZHENG_PINGTAI: {
                switch (data.getState()) {
                    case RenZhengListBean.RenZhengBean.STATE_NO:
                    case RenZhengListBean.RenZhengBean.STATE_REFUND:// 已退款，点击重新认证
                        renZheng(data);
                        break;
                    case RenZhengListBean.RenZhengBean.STATE_FINISH: // 审核完成，不能操作
                    case RenZhengListBean.RenZhengBean.STATE_ON: //审核中， 不能操作
                        break;

                }
            }
            break;
            case TAG_RENZHENG_CHENGXIN: {
                switch (data.getState()) {
                    case RenZhengListBean.RenZhengBean.STATE_NO:
                    case RenZhengListBean.RenZhengBean.STATE_REFUND:// 已退款， 点击重新认证
                        renZheng(data);
                        break;
                    case RenZhengListBean.RenZhengBean.STATE_FINISH: // 审核完成，点击可以退款
                    case RenZhengListBean.RenZhengBean.STATE_ON: //审核中， 点击可以退款
                        refund(data);
                        break;

                }
            }
            break;
            case TAG_RENZHENG_XUEYUAN: {
                // 学院单独处理
                switch (data.getState()) {
                    case RenZhengListBean.RenZhengBean.STATE_XY_NO:
                        renZheng(data);
                        break;
                    case RenZhengListBean.RenZhengBean.STATE_XY_NOTSUBMIT:// 未提交资料 ,跳转到提交资料
                        ToRenZhengActivity.startActivityForResult(this, data.getParameter1(), data.getId(), ToRenZhengActivity.TYPE_SUBMIT, 100);
                        break;
                    case RenZhengListBean.RenZhengBean.STATE_XY_ON: // 审核中，点击跳转到查看资料
                        ToRenZhengActivity.startActivity(getContext(), data.getParameter1(), data.getId(), ToRenZhengActivity.TYPE_WATCH);
                        break;
                    case RenZhengListBean.RenZhengBean.STATE_XY_UNPASS: //审核失败，重新提交资料
                        ToRenZhengActivity.startActivityForResult(this, data.getParameter1(), data.getId(), ToRenZhengActivity.TYPE_RESUBMIT, 100);
                        break;
                    case RenZhengListBean.RenZhengBean.STATE_XY_PASS:   // 审核通过，不能点击
                        break;
                }
            }
            break;
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
//        // 如果是认证回来或者提交资料回来，那么刷新界面
//        if(requestCode == 100){
//            // 认证资料提交回来
//        }else{
//            //TODO 支付回来的时候哟。
//        }
        if (resultCode == Activity.RESULT_OK) {
            ((DianPuRenZhengActivity) getActivity()).requestNetData();
        }
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event event) {
        if (event == null)
            return;
        try {
            int code = event.getCode();
            switch (code) {
                case EventCode.PAY_SUCCRSS:
                    ((DianPuRenZhengActivity) getActivity()).requestNetData();
                    break;
            }
        } catch (Exception e) {
        }

    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
        EventBusUtil.unregister(this);
    }
}
