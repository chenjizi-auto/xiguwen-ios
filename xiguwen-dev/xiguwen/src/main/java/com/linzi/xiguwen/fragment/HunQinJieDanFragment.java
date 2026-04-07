package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.jcodecraeer.xrecyclerview.ProgressStyle;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.HunQinJieDanAdapter;
import com.linzi.xiguwen.base.BaseFragment;
import com.linzi.xiguwen.ui.EditPriceActivity;
import com.linzi.xiguwen.ui.HQJieDanTuikuanDetailsActivity;
import com.linzi.xiguwen.ui.OrderDetailsActivity;
import com.linzi.xiguwen.ui.PingjiaAdapterActivity;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.CompleteDialog;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class HunQinJieDanFragment extends BaseFragment {
    @BindView(R.id.recycle_view)
    XRecyclerView recycleView;

    private int flag=-1;

    private boolean isPrepare = false;

    HunQinJieDanAdapter mAdapter;

    public static HunQinJieDanFragment newInstance (int FLAG) {
        Bundle args = new Bundle();
        args.putInt("type", FLAG);
        HunQinJieDanFragment fragment=new HunQinJieDanFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_history_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        initViews();
    }

    private void initViews(){
        Bundle bu = getArguments();
        flag = bu.getInt("type");

        LinearLayoutManager manager=new LinearLayoutManager(getActivity());
        recycleView.setRefreshProgressStyle(ProgressStyle.BallTrianglePath);
        recycleView.setLoadingMoreProgressStyle(ProgressStyle.BallScaleRipple);
        recycleView.setLoadingMoreEnabled(true);
        recycleView.setLayoutManager(manager);
        mAdapter=new HunQinJieDanAdapter(getActivity(), flag, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                Intent intent=new Intent(getActivity(),OrderDetailsActivity.class);
                startActivity(intent);
            }
        });
        mAdapter.setmPingjia(new CallBack.PingjiaListener() {
            @Override
            public void pingjia(View view, int in) {
                Intent intent=new Intent(getActivity(),PingjiaAdapterActivity.class);
                startActivity(intent);
            }
        });
        mAdapter.setmEditPrice(new CallBack.EditPriceListener() {
            @Override
            public void editPrice(View view, int in) {
                Intent intent=new Intent(getActivity(),EditPriceActivity.class);
                startActivity(intent);
            }
        });
        mAdapter.setmJiedan(new CallBack.JiedanListener() {
            @Override
            public void jiedan(View view, int in) {

            }
        });

        mAdapter.setmTuikuan(new CallBack.TuikuanClickListener() {
            @Override
            public void TuikuanClick(int in) {
                Intent intent=new Intent(getActivity(),HQJieDanTuikuanDetailsActivity.class);
                startActivity(intent);
            }
        });

        mAdapter.setmComlete(new CallBack.ComleteListener() {
            @Override
            public void complete(View view, int in) {
                new CompleteDialog(getActivity(),getActivity())
                        .setMessage("该订单还有款项未结清，请选择收款方式！")
                        .setCancleListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View v) {

                            }
                        })
                        .setSubmitListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View v) {

                            }
                        }).setChooseButton(new CallBack.ComleteTypeListener() {
                            @Override
                            public void completeType(int in) {
                                NToast.show(""+in);
                            }
                        }).show();
            }
        });
        recycleView.setAdapter(mAdapter);
    }

    @Override
    protected void lazyLoad() {
        if (!isVisible || !isPrepare) {
            return;
        }
    }
}
