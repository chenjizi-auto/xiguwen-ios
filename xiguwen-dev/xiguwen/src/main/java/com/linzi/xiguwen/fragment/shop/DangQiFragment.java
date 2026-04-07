package com.linzi.xiguwen.fragment.shop;

import android.graphics.Color;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.ScheduleBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;


/**
 * Created by pc on 2018/3/28.
 */

public class DangQiFragment extends BaseLazyFragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.no_data)
    TextView noData;
    private int shop_id;
    private BaseAdapter mAdapter;
    private List<ScheduleBean> list;

    public static Fragment create(int shop_id) {
        DangQiFragment fragment = new DangQiFragment();
        Bundle bundle = new Bundle();
        bundle.putInt("shop_id", shop_id);
        fragment.setArguments(bundle);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_mall_index_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        shop_id = getArguments().getInt("shop_id");
        getData();
    }

    @Override
    public void onLazyLoad() {
    }

    private void afterView(List<ScheduleBean> bean) {
        mAdapter = createAdapter(bean);
        recycle.setAdapter(mAdapter);
    }

    //初始化数据
    private void getData() {
       // LoadDialog.showDialog(getActivity());
        ApiManager.getSchedule(shop_id + "", new OnRequestFinish<BaseBean<ArrayList<ScheduleBean>>>() {
            @Override
            public void onFinished() {
               // LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ArrayList<ScheduleBean>> data) {
                if (data.getData() != null && data.getData().size() > 0) {
                    list = data.getData();
                    afterView(list);
                    noData.setVisibility(View.GONE);
                } else {
                    noData.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onError(Exception ex) {
            }
        });
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    //标题Delegate
    class TitleDelegate extends CreateHolderDelegate<String> {

        @Override
        protected int getLayoutRes() {
            return R.layout.item_mall_title;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new TitleHolder(itemView);
        }
    }

    //标题Holder
    class TitleHolder extends BaseViewHolder<String> {

        public TitleHolder(View itemView) {
            super(itemView);
        }

        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_more)
        TextView tvMore;

        @Override
        protected void bindView(String s) {
            tvName.setText(s);
            tvName.setTextColor(Color.parseColor("#FFFC5887"));
        }

    }

    //档期Holder
    class DangQiHolder extends BaseViewHolder<ScheduleBean.DangqiBean> {
        @BindView(R.id.tv_day)
        TextView tvDay;
        @BindView(R.id.tv_time)
        TextView tvTime;

        public DangQiHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(ScheduleBean.DangqiBean dangqiBean) {
            tvDay.setText(dangqiBean.getDate() + "");
            tvTime.setText(dangqiBean.getTimeslot() + "");
        }
    }

    //全局view Adapter
    private BaseAdapter createAdapter(List<ScheduleBean> list) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();

        for (int i = 0; i < list.size(); i++) {
            baseAdapter.injectHolderDelegate(new TitleDelegate() {
                @Override
                protected int onSpanSize() {
                    return 6;
                }
            }.cleanAfterAddData(list.get(i).getDateye()))
                    .injectHolderDelegate(new CreateHolderDelegate<ScheduleBean.DangqiBean>() {
                        @Override
                        protected int getLayoutRes() {
                            return R.layout.item_mall_dangqi_item_layout;
                        }

                        @Override
                        protected BaseViewHolder onCreateHolder(View itemView) {
                            return new DangQiHolder(itemView);
                        }
                    }.addAllData(list.get(i).getDangqi()))
                    .injectHolderDelegate(new CreateHolderDelegate<String>() {
                        @Override
                        protected int onSpanSize() {
                            return 6;
                        }

                        @Override
                        protected int getLayoutRes() {
                            return R.layout.item_dev;
                        }

                        @Override
                        protected BaseViewHolder onCreateHolder(View itemView) {
                            return new BaseViewHolder<String>(itemView) {
                                @Override
                                protected void bindView(String o) {

                                }
                            };
                        }
                    }.addData(""));//分割线View;

        }
        baseAdapter.setLayoutManager(recycle);

        return baseAdapter;
    }
}
