package com.linzi.xiguwen.fragment.cart;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.MallCartBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.NewGoodsDetailsActivity;
import com.linzi.xiguwen.ui.NewShopMallDetailsActivity;
import com.linzi.xiguwen.ui.NewSureOrderActivity;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.NumberUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.ViewUtil;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;
import com.yanzhenjie.recyclerview.swipe.SwipeMenu;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuBridge;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuCreator;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuItem;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuItemClickListener;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuRecyclerView;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

import static android.view.ViewGroup.LayoutParams.MATCH_PARENT;

/**
 * Created by pc on 2018/4/9.
 */

public class MallCartFragment extends BaseLazyFragment {
    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.tv_to_jiesuan)
    TextView tvToJiesuan;
    @BindView(R.id.cb_all)
    CheckBox cbAll;
    @BindView(R.id.ll_jiesuan)
    LinearLayout llJiesuan;
    @BindView(R.id.ll)
    LinearLayout ll;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;

    private BaseAdapter baseAdapter;
    private MallCartBean bean;
    private HashMap<Integer, List<MallCartBean.DataBean>> map;
    private boolean isAllSelect;
    private String price = "0.00";

    public static Fragment create() {
        MallCartFragment fragment = new MallCartFragment();
        return fragment;
    }

    @Override
    public void onLazyLoad() {

    }

    private CreateHolderDelegate<String> noData = new CreateHolderDelegate<String>() {
        @Override
        protected int onSpanSize() {
            return 2;
        }

        @Override
        protected int getLayoutRes() {
            return R.layout.cart_nodata_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new BaseViewHolder<String>(itemView) {
                @Override
                protected void bindView(String o) {

                }
            };
        }
    }.addData("");

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.cart_layout, null);
        ButterKnife.bind(this, view);
        EventBusUtil.register(this);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        refreshLayout.autoRefresh();
        initView();
    }

    private void initView() {
        refreshLayout.setRefreshHeader(new MyRefreshHeader(getActivity()));
        refreshLayout.setEnableLoadMore(false);
        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                getData();
                refreshLayout.finishRefresh();
            }
        });
    }

    private void getData() {
        ApiManager.getMallCart(new OnRequestFinish<BaseBean<MallCartBean>>() {
            @Override
            public void onFinished() {

            }

            @Override
            public void onSuccess(BaseBean<MallCartBean> data) {
                baseAdapter = createAdapter();
                bean = data.getData();
                if (bean.getData() != null && bean.getData().size() > 0) {
                    noData.clearAll();
                    dealBean(bean);
                    cbAll.setClickable(true);
                    llJiesuan.setClickable(true);
                    ll.setVisibility(View.VISIBLE);
                } else {
                    cbAll.setClickable(false);
                    llJiesuan.setClickable(false);
                    if (!noData.getData().equals("")) {
                        noData.cleanAfterAddData("");
                    }
                    ll.setVisibility(View.GONE);
                }
                //baseAdapter.injectHolderDelegate(new TitleDelegate().addData(R.mipmap.icon_guess_love));
                baseAdapter.injectHolderDelegate(new CreateHolderDelegate<MallCartBean.TuijianBean>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.cart_guess_you_like_item;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new GuessYouLikeHolder(itemView);
                    }
                }.cleanAfterAddAllData(bean.getTuijian()));
                baseAdapter.notifyDataSetChanged();
                recycleview.setAdapter(baseAdapter);
                tvPrice.setText("￥0.00");
                cbAll.setChecked(false);
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private BaseAdapter createAdapter() {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(noData);
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    private void dealBean(MallCartBean bean) {
        map = new HashMap<>();
        List<MallCartBean.DataBean> list;
        for (int i = 0; i < bean.getData().size(); i++) {
            MallCartBean.DataBean bean1 = bean.getData().get(i);
            if (!map.containsKey(bean1.getStore_id())) {
                list = new ArrayList<>();
                list.add(bean1);
                map.put(bean1.getStore_id(), list);
            } else {
                map.get(bean1.getStore_id()).add(bean1);
            }
        }
        for (Integer key : map.keySet()) {
            baseAdapter
                    .injectHolderDelegate(new CreateHolderDelegate<Integer>() {
                        @Override
                        protected int onSpanSize() {
                            return 2;
                        }

                        @Override
                        protected int getLayoutRes() {
                            return R.layout.cart_father_item_layout;
                        }

                        @Override
                        protected BaseViewHolder onCreateHolder(View itemView) {
                            return new FatherItemHolder(itemView);
                        }
                    }.cleanAfterAddData(key));
        }
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
        EventBusUtil.unregister(this);
    }

    @OnClick({R.id.cb_all, R.id.ll_jiesuan})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.cb_all:
                isAllselect(true);
                break;
            case R.id.ll_jiesuan:
                if (getRec_id() != null && !getRec_id().equals("")) {
                    Intent intent = new Intent(getActivity(), NewSureOrderActivity.class);
                    intent.putExtra("rec_id", getRec_id());
                    intent.putExtra("intentType", 1);
                    startActivity(intent);
                }
                break;
        }
    }

    private void isAllselect(boolean isClicked) {
        if (isClicked) {
            isAllSelect = !isAllSelect;
            cbAll.setChecked(isAllSelect);
            for (List<MallCartBean.DataBean> bean : map.values()) {
                for (int i = 0; i < bean.size(); i++) {
                    bean.get(i).setChecked(isAllSelect);
                    for (int j = 0; j < bean.get(i).getGoods().size(); j++) {
                        bean.get(i).getGoods().get(j).setChecked(isAllSelect);
                    }
                }
            }
            baseAdapter.notifyDataSetChanged();
            getSelectCartPrice();
        } else {
            int listsize = 0;
            int num = 0;
            for (List<MallCartBean.DataBean> bean : map.values()) {
                for (int i = 0; i < bean.size(); i++) {
                    for (int j = 0; j < bean.get(i).getGoods().size(); j++) {
                        listsize++;
                        if (bean.get(i).getGoods().get(j).isChecked() == true) {
                            num++;
                        }
                    }
                }
            }
            if (num == listsize) {
                cbAll.setChecked(true);
            } else {
                cbAll.setChecked(false);
            }
        }
    }

    //为你推荐title Holder
    class TiltleHolder extends BaseViewHolder<Integer> {
        @BindView(R.id.iv_title)
        ImageView tiltle;

        public TiltleHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(Integer s) {

            itemView.setBackgroundColor(getResources().getColor(R.color.f0f0f0));
            tiltle.setBackgroundResource(s.intValue());
        }
    }

    //为你推荐title Delegate
    class TitleDelegate extends CreateHolderDelegate<Integer> {
        @Override
        protected int onSpanSize() {
            return 2;
        }

        @Override
        protected int getLayoutRes() {
            return R.layout.new_mall_title_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new TiltleHolder(itemView);
        }
    }

    //father item holder
    class FatherItemHolder extends BaseViewHolder<Integer> {
        @BindView(R.id.choose)
        CheckBox cbChoose;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.goods_recycle)
        SwipeMenuRecyclerView goodsRecycle;
        private GoodsAdapter adapter;
        private int shop_id;
        private List<MallCartBean.DataBean.GoodsBean> list;

        public FatherItemHolder(View itemView) {
            super(itemView);
            tvName.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewShopMallDetailsActivity.class);
                    intent.putExtra("shop_id", shop_id);
                    getActivity().startActivity(intent);
                }
            });

            LinearLayoutManager manager = new LinearLayoutManager(getActivity()) {
                @Override
                public boolean canScrollVertically() {
                    return false;
                }
            };
            goodsRecycle.setLayoutManager(manager);
            goodsRecycle.setSwipeMenuCreator(new SwipeMenuCreator() {
                @Override
                public void onCreateMenu(SwipeMenu swipeLeftMenu, SwipeMenu swipeRightMenu, int viewType) {
                    SwipeMenuItem deleteItem = new SwipeMenuItem(getActivity());
                    deleteItem.setBackgroundColor(getActivity().getResources().getColor(R.color.colorTitleRed));
                    deleteItem.setHeight(MATCH_PARENT);
                    deleteItem.setWidth(dip2px(getActivity(), 100));
                    deleteItem.setText("删除");
                    deleteItem.setTextColor(getActivity().getResources().getColor(R.color.white));
                    // 各种文字和图标属性设置。
                    swipeRightMenu.addMenuItem(deleteItem); // 在Item左侧添加一个菜单。
                }
            });
            goodsRecycle.setSwipeMenuItemClickListener(new SwipeMenuItemClickListener() {
                @Override
                public void onItemClick(SwipeMenuBridge menuBridge) {
                    // 任何操作必须先关闭菜单，否则可能出现Item菜单打开状态错乱。
                    menuBridge.closeMenu();

                    int direction = menuBridge.getDirection(); // 左侧还是右侧菜单。
                    int adapterPosition = menuBridge.getAdapterPosition(); // RecyclerView的Item的position。
                    int menuPosition = menuBridge.getPosition(); // 菜单在RecyclerView的Item中的Position。
                    delGoods(list.get(adapterPosition));
                }
            });
            adapter = new GoodsAdapter();
            goodsRecycle.setAdapter(adapter);
        }

        @Override
        protected void bindView(final Integer key) {
            if (map.get(key) != null) {
                shop_id = map.get(key).get(0).getStore_id();
                tvName.setText(map.get(key).get(0).getSeller().getNickname() + "");

                list = new ArrayList<>();
                for (int i = 0; i < map.get(key).size(); i++) {
                    list.add(map.get(key).get(i).getGoods().get(0));
                }

                int selectNum = 0;
                for (int i = 0; i < list.size(); i++) {
                    if (list.get(i).isChecked() == true) {
                        selectNum++;
                    }
                }
                if (selectNum == list.size()) {
                    cbChoose.setChecked(true);
                    map.get(key).get(0).setChecked(true);
                } else {
                    cbChoose.setChecked(false);
                    map.get(key).get(0).setChecked(false);
                }

                cbChoose.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        if (map.get(key).get(0).isChecked() == true) {
                            cbChoose.setChecked(false);
                            map.get(key).get(0).setChecked(false);
                            for (int i = 0; i < list.size(); i++) {
                                list.get(i).setChecked(false);
                            }
                            adapter.notifyDataSetChanged();
                        } else {
                            cbChoose.setChecked(true);
                            map.get(key).get(0).setChecked(true);
                            for (int i = 0; i < list.size(); i++) {
                                list.get(i).setChecked(true);
                            }
                            adapter.notifyDataSetChanged();
                        }
                        isAllselect(false);
                        getSelectCartPrice();
                    }
                });
                adapter.setList(list);
            }
        }

        public class GoodsAdapter extends RecyclerView.Adapter<GoodsAdapter.VH> {
            private List<MallCartBean.DataBean.GoodsBean> list;

            public void setList(List<MallCartBean.DataBean.GoodsBean> list) {
                this.list = list;
                notifyDataSetChanged();
            }

            @Override
            public VH onCreateViewHolder(ViewGroup parent, int viewType) {
                View view = LayoutInflater.from(getActivity()).inflate(R.layout.item_goods_cart_layout, parent, false);
                return new VH(view);
            }

            @Override
            public void onBindViewHolder(final VH vh, final int position) {
                GlideLoad.GlideLoadImg2(list.get(position).getGoods_image(), vh.ivImg);
                vh.cbChoose.setChecked(list.get(position).isChecked());

                vh.tvDate.setText(list.get(position).getSpecification() + "");
                vh.tvName.setText(list.get(position).getGoods_name() + "");
                vh.tvTime.setText("");
                vh.tvDanjia.setText(Constans.RMB + list.get(position).getPrice());
                vh.tvDingjin.setVisibility(View.GONE);
                vh.dingjintx.setVisibility(View.GONE);
                vh.edNum.setText(list.get(position).getQuantity() + "");

                vh.btJia.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        int Num = Integer.valueOf(vh.edNum.getText().toString());
                        Num++;
                        vh.edNum.setText("" + Num);
                        list.get(position).setQuantity(Num);
                        updateNum(list.get(position), vh.edNum, list.get(position).getRec_id(), Num);
                    }
                });
                vh.btJian.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        int Num = Integer.valueOf(vh.edNum.getText().toString());
                        Num--;
                        if (Num <= 0) {
                            Num = 1;
                        }
                        vh.edNum.setText("" + Num);
                        list.get(position).setQuantity(Num);
                        updateNum(list.get(position), vh.edNum, list.get(position).getRec_id(), Num);
                    }
                });

                vh.cbChoose.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        if (list.get(position).isChecked() == false) {
                            list.get(position).setChecked(true);
                        } else {
                            list.get(position).setChecked(false);
                        }
                        notifyDataSetChanged();
                        baseAdapter.notifyDataSetChanged();
                        getSelectCartPrice();
                        isAllselect(false);
                    }
                });
            }


            @Override
            public int getItemCount() {
                return list == null ? 0 : list.size();
            }

            class VH extends RecyclerView.ViewHolder {
                @BindView(R.id.cb_choose)
                CheckBox cbChoose;
                @BindView(R.id.iv_img)
                ImageView ivImg;
                @BindView(R.id.tv_name)
                TextView tvName;
                @BindView(R.id.tv_date)
                TextView tvDate;
                @BindView(R.id.tv_time)
                TextView tvTime;
                @BindView(R.id.tv_type_pay)
                TextView tvTypePay;
                @BindView(R.id.tv_danjia)
                TextView tvDanjia;
                @BindView(R.id.tv_dingjin)
                TextView tvDingjin;
                @BindView(R.id.bt_jian)
                Button btJian;
                @BindView(R.id.ed_num)
                EditText edNum;
                @BindView(R.id.bt_jia)
                Button btJia;
                @BindView(R.id.dingjintx)
                TextView dingjintx;


                VH(View view) {
                    super(view);
                    ButterKnife.bind(this, view);
                    view.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            if (list.get(getPosition()).isChecked() == false) {
                                list.get(getPosition()).setChecked(true);
                            } else {
                                list.get(getPosition()).setChecked(false);
                            }
                            notifyDataSetChanged();
                            baseAdapter.notifyDataSetChanged();
                            getSelectCartPrice();
                            isAllselect(false);
                        }
                    });
                    ivImg.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Intent intent = new Intent(getActivity(), NewGoodsDetailsActivity.class);
                            intent.putExtra("goods_id", list.get(getPosition()).getGoods_id());
                            getActivity().startActivity(intent);
                        }
                    });
                }
            }
        }

        //将dp转换为px
        public int dip2px(Context context, float dpValue) {
            final float scale = context.getResources().getDisplayMetrics().density;
            return (int) (dpValue * scale + 0.5f);
        }
    }

    //猜你喜欢 Holder
    class GuessYouLikeHolder extends BaseViewHolder<MallCartBean.TuijianBean> {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_zhiwei)
        TextView tvZhiwei;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.iv_rz_cx)
        ImageView ivRzCx;
        @BindView(R.id.iv_rz_pt)
        ImageView ivRzPt;
        @BindView(R.id.iv_rz_xy)
        ImageView ivRzXy;
        @BindView(R.id.baojianum)
        TextView baojianum;
        @BindView(R.id.anlinum)
        TextView anlinum;
        @BindView(R.id.pingjianum)
        TextView pingjianum;
        @BindView(R.id.iv_rz)
        ImageView ivRZ;
        private int id;

        public GuessYouLikeHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewShopMallDetailsActivity.class);
                    intent.putExtra("shop_id", id);
                    getActivity().startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(MallCartBean.TuijianBean tuijianBean) {
            ViewUtil.setTwoColumnCardLayout(getActivity(), itemView, ivImg, getRecommendPosition(tuijianBean), 10, 4, 5);

            id = tuijianBean.getUserid();
            GlideLoad.GlideLoadImg2(tuijianBean.getHead(), ivImg);
            tvTitle.setText(tuijianBean.getNickname() + "");
            tvZhiwei.setText(tuijianBean.getOccupationid() + "");
            tvPrice.setText("￥" + tuijianBean.getZuidijia() + "起");
            baojianum.setText("报价：" + tuijianBean.getShopnum());
            anlinum.setText("案例：" + tuijianBean.getAnlinum());
            pingjianum.setText("评价：" + tuijianBean.getEvaluate());
            if (tuijianBean.getIsshopvip() == 1) {
                ivRZ.setVisibility(View.VISIBLE);
            } else {
                ivRZ.setVisibility(View.GONE);
            }
            if (tuijianBean.getPlatform() == 1) {
                ivRzPt.setVisibility(View.VISIBLE);
            } else {
                ivRzPt.setVisibility(View.GONE);
            }
            if (tuijianBean.getSincerity() == 1) {
                ivRzCx.setVisibility(View.VISIBLE);
            } else {
                ivRzCx.setVisibility(View.GONE);
            }
            if (tuijianBean.getCollege() == 1) {
                ivRzXy.setVisibility(View.VISIBLE);
            } else {
                ivRzXy.setVisibility(View.GONE);
            }
        }

        private int getRecommendPosition(MallCartBean.TuijianBean tuijianBean) {
            if (bean != null && bean.getTuijian() != null) {
                int index = bean.getTuijian().indexOf(tuijianBean);
                if (index >= 0) {
                    return index;
                }
            }
            return 0;
        }
    }


    //计算选中的购物车金额
    private void getSelectCartPrice() {
        String price = "0.00";
        for (List<MallCartBean.DataBean> bean : map.values()) {
            for (int i = 0; i < bean.size(); i++) {
                for (int j = 0; j < bean.get(i).getGoods().size(); j++) {
                    if (bean.get(i).getGoods().get(j).isChecked() == true) {
                        price = NumberUtil.add(price, NumberUtil.AmultiplyB(bean.get(i).getGoods().get(j).getPrice(), bean.get(i).getGoods().get(j).getQuantity() + ""));
                    }
                }
            }
        }
        if (price.equals("0.00")){
            llJiesuan.setBackgroundColor(getActivity().getResources().getColor(R.color.colorHint));
        }else {
            llJiesuan.setBackgroundColor(getActivity().getResources().getColor(R.color.colorMain));
        }
        this.price = price;
        tvPrice.setText("￥" + this.price);
    }

    //修改商品数量
    private void updateNum(final MallCartBean.DataBean.GoodsBean goodsBean, final TextView textView, int rec_id, final int num) {
        LoadDialog.showDialog(getActivity());
        ApiManager.updateCartNumber(rec_id, num + "", new OnRequestFinish<BaseBean<MallCartBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<MallCartBean> data) {
                if (data.getCode() == 0) {
                    goodsBean.setQuantity(num);
                    textView.setText("" + num);
                } else {
                    NToast.show("修改失败！");
                }
                getSelectCartPrice();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show("修改失败！");
            }
        });
    }

    //删除商品
    private void delGoods(final MallCartBean.DataBean.GoodsBean goodsBean) {
        final int rec_id = goodsBean.getRec_id();
        final int key = goodsBean.getStore_id();
        LoadDialog.showDialog(getActivity());
        ApiManager.removeCart(rec_id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                if (data.getCode() == 0) {
                    List<MallCartBean.DataBean> list = map.get(key);
                    int size = list.size();
                    if (size == 1) {
                        getData();
                    } else if (size > 1) {
                        for (int i = 0; i < list.size(); i++) {
                            if (list.get(i).getGoods().get(0).getRec_id() == rec_id) {
                                list.remove(list.get(i));
                                map.put(key, list);
                            }
                        }
                    } else {
                        NToast.show("修改失败！");
                    }
                    baseAdapter.notifyDataSetChanged();
                } else {
                    NToast.show("修改失败！");
                }
                getSelectCartPrice();
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }


    //组成rec_id传递到结算页
    private String getRec_id() {
        StringBuffer rec_id = new StringBuffer();
        for (List<MallCartBean.DataBean> bean : map.values()) {
            for (int i = 0; i < bean.size(); i++) {
                for (int j = 0; j < bean.get(i).getGoods().size(); j++) {
                    if (bean.get(i).getGoods().get(j).isChecked() == true) {
                        rec_id.append("_" + (bean.get(i).getGoods().get(j).getRec_id()));
                    }
                }
            }
        }
        if (rec_id.toString().startsWith("_")) {
            rec_id.deleteCharAt(0);
        }
        if (rec_id.toString().endsWith("_")) {
            rec_id.deleteCharAt(rec_id.length() - 1);
        }
        return rec_id.toString();
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.REFRESH_CART:
                    refreshLayout.autoRefresh();
                    break;
                case EventCode.LOGIN_SUCCESS:
                    refreshLayout.autoRefresh();
                    break;
            }
        } catch (Exception e) {
        }

    }

}
