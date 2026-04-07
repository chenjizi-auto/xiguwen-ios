package com.linzi.xiguwen.view.dialog;

import android.app.Activity;
import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import androidx.recyclerview.widget.RecyclerView;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.NewGoodsDetailsBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.NumberUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import butterknife.BindView;

/**
 * Created by pc on 2018/4/13.
 */

public class AddMallCartDialog extends PopupWindow implements View.OnClickListener {

    ImageView ivImg;
    TextView tvBaojiaPrice;
    TextView tvName;
    RecyclerView recycleview;
    Button btAdd;
    EditText edNum;
    Button btJian;
    Button btSubmit;

    private int type = -1;//type 0添加 1立即购买
    private Context context;
    private NewGoodsDetailsBean bean;
    private View view;

    private RefreshNum refreshNum;

    private BaseAdapter baseAdapter;

    public void setType(int type) {
        this.type = type;
    }

    public void setRefreshNum(RefreshNum refreshNum) {
        this.refreshNum = refreshNum;
    }

    public interface RefreshNum {
        abstract void onRefresh(int type, int skuid, String number);
    }

    public AddMallCartDialog(Context context, NewGoodsDetailsBean bean) {
        super(context);
        this.context = context;
        this.bean = bean;
        view = LayoutInflater.from(context).inflate(R.layout.goods_addcart_layout, null);
        initPop();
        initView();
        dealBean(bean);
    }

    private void createAdapter() {
        baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 3;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.add_goods_cart_title_item;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new TitleHolder(itemView);
                    }
                }.cleanAfterAddData(titleList.get(0)))
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 1;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.add_mall_cart_fater_item;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new ItemHolder(itemView);
                    }
                }.cleanAfterAddAllData(sku1TitleList))
        ;
        baseAdapter.setLayoutManager(recycleview);
        recycleview.setAdapter(baseAdapter);
        getBindView(true);
    }


    private void initPop() {
        // 设置弹出窗体可点击
        setFocusable(true);
        int w = ((Activity) context).getWindowManager().getDefaultDisplay().getWidth();
        int h = (((Activity) context).getWindowManager().getDefaultDisplay().getHeight() / 2) + 500;
        setWidth(w);
        setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0xffff0000);
        // 设置弹出窗体的背景
        setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        setAnimationStyle(R.style.AnimationPreview);
        setContentView(view);
        update();
        setOnDismissListener(new OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });

        recycleview = view.findViewById(R.id.recycleview);
        ivImg = view.findViewById(R.id.iv_img);
        tvName = view.findViewById(R.id.tv_name);
        tvBaojiaPrice = view.findViewById(R.id.tv_baojia_price);
        edNum = view.findViewById(R.id.ed_num);
        btAdd = view.findViewById(R.id.bt_add);
        btSubmit = view.findViewById(R.id.bt_submit);
        btJian = view.findViewById(R.id.bt_jian);

        btAdd.setOnClickListener(this);
        btSubmit.setOnClickListener(this);
        btJian.setOnClickListener(this);
    }


    private void initView() {
        GlideLoad.GlideLoadImg2(bean.getShangpin().getShopimg().get(0), ivImg);
    }

    //显示消失动画
    public void lightoff(boolean isoff) {
        WindowManager.LayoutParams lp = ((Activity) context).getWindow().getAttributes();
        if (isoff) {
            lp.alpha = 0.3f;
        } else {
            lp.alpha = 1f;
        }
        ((Activity) context).getWindow().setAttributes(lp);
    }

    public void setShowWithView(View view) {
        showAtLocation(view, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        lightoff(true);
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.bt_jian:
                int Num = Integer.valueOf(edNum.getText().toString());
                Num--;
                if (Num <= 0) {
                    Num = 1;
                }
                edNum.setText("" + Num);
                break;
            case R.id.bt_add:
                int Num2 = Integer.valueOf(edNum.getText().toString());
                Num2++;
                edNum.setText("" + Num2);
                break;
            case R.id.bt_submit:
                btSubmit.setClickable(false);
                isTrueSubmit();
                break;
        }
    }

    private void addGoods() {
        LoadDialog.showDialog(context);
        ApiManager.addMallCartGoods(skuid + "", edNum.getText().toString(), new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show("添加成功！");
                btSubmit.setClickable(true);
                dismiss();
                refreshNum.onRefresh(type, skuid, edNum.getText().toString());
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                btSubmit.setClickable(true);
            }
        });
    }

    List<String> titleList;
    private List<String> sku1TitleList;
    private Map<String, List<NewGoodsDetailsBean.GuigeBean>> map;

    //-------------------------------------------------------------  处理数据源  ----------------------------------------------------------------------
    private void dealBean(NewGoodsDetailsBean bean) {
        titleList = new ArrayList<>();
        List<NewGoodsDetailsBean.GuigeBean> guigeBean = bean.getGuige();
        if (guigeBean != null && guigeBean.size() > 0) {
            titleList = new ArrayList<>();
            if (bean.getGuige().get(0).getSku1() != null && !bean.getGuige().get(0).getSku1().equals("")) {
                titleList.add(bean.getGuige().get(0).getSku1());
                sku1TitleList = new ArrayList<>();
                List<String> newsku1TitleList = new ArrayList<>();
                for (int i = 0; i < guigeBean.size(); i++) {
                    newsku1TitleList.add(guigeBean.get(i).getSku1name());
                }
                Set set = new HashSet();
                for (Iterator iter = newsku1TitleList.iterator(); iter.hasNext(); ) {
                    Object element = iter.next();
                    if (set.add(element))
                        sku1TitleList.add((String) element);
                }
            }
            if (bean.getGuige().get(0).getSku2() != null && !bean.getGuige().get(0).getSku2().equals(""))
                titleList.add(bean.getGuige().get(0).getSku2());

            map = new HashMap<>();
            List<NewGoodsDetailsBean.GuigeBean> list;
            for (int i = 0; i < bean.getGuige().size(); i++) {
                list = new ArrayList<>();
                if (!map.containsKey(bean.getGuige().get(i).getSku1name())) {
                    list.add(bean.getGuige().get(i));
                    map.put(bean.getGuige().get(i).getSku1name(), list);
                } else {
                    map.get(bean.getGuige().get(i).getSku1name()).add(bean.getGuige().get(i));
                }
            }
        }
        createAdapter();
    }

    class TitleHolder extends BaseViewHolder<String> {
        @BindView(R.id.tv_title)
        TextView tvTitle;

        public TitleHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(String s) {
            tvTitle.setText(s);
        }
    }

    private int indextag = 0;
    private int indextag2 = 0;

    class ItemHolder extends BaseViewHolder<String> {
        @BindView(R.id.radio)
        TextView radio;

        public ItemHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    indextag = getPosition() - 1;
                    indextag2 = 0;
                    baseAdapter.notifyDataSetChanged();
                    getBindView(false);
                }
            });
        }

        @Override
        protected void bindView(String s) {
            if (indextag == 0 && getPosition() - 1 == 0) {
                radio.setBackgroundResource(R.drawable.addcart_selected);
                radio.setTextColor(Color.parseColor("#ffffff"));
            } else {
                if (indextag == getPosition() - 1) {
                    radio.setBackgroundResource(R.drawable.addcart_selected);
                    radio.setTextColor(Color.parseColor("#ffffff"));
                } else {
                    radio.setBackgroundResource(R.drawable.addcart_unselected);
                    radio.setTextColor(Color.parseColor("#262626"));
                }
            }

            radio.setText(s);
        }
    }

    CreateHolderDelegate<String> chlidDel = new CreateHolderDelegate<String>() {
        @Override
        protected int onSpanSize() {
            return 1;
        }

        @Override
        protected int getLayoutRes() {
            return R.layout.add_mall_cart_fater_item;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new ItemHolder2(itemView);
        }
    };

    class ItemHolder2 extends BaseViewHolder<String> {
        @BindView(R.id.radio)
        TextView radio;


        public ItemHolder2(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    indextag2 = getPosition() - (sku1TitleList.size() + 2);
                    baseAdapter.notifyDataSetChanged();
                    refreshView();
                }
            });
        }

        @Override
        protected void bindView(String s) {
            if (indextag2 == 0 && getPosition() - (sku1TitleList.size() + 2) == 0) {
                radio.setBackgroundResource(R.drawable.addcart_selected);
                radio.setTextColor(Color.parseColor("#ffffff"));
            } else {
                if (indextag2 == getPosition() - (sku1TitleList.size() + 2)) {
                    radio.setBackgroundResource(R.drawable.addcart_selected);
                    radio.setTextColor(Color.parseColor("#ffffff"));
                } else {
                    radio.setBackgroundResource(R.drawable.addcart_unselected);
                    radio.setTextColor(Color.parseColor("#262626"));
                }
            }

            radio.setText(s);
        }
    }

    private List<String> newsku1TitleList;

    //处理属性绑定关系
    private void getBindView(boolean isfrist) {
        List<String> sku2TitleList = new ArrayList<>();
        for (List<NewGoodsDetailsBean.GuigeBean> bean : map.values()) {
            for (int i = 0; i < bean.size(); i++) {
                if (bean.get(i).getSku1name().equals(sku1TitleList.get(indextag))) {
                    if (bean.get(i).getSku2name() != null && !bean.get(i).getSku2name().equals(""))
                        sku2TitleList.add(bean.get(i).getSku2name());
                }
            }
        }

        newsku1TitleList = new ArrayList<>();
        newsku1TitleList.clear();
        Set set = new HashSet();
        for (Iterator iter = sku2TitleList.iterator(); iter.hasNext(); ) {
            Object element = iter.next();
            if (set.add(element))
                newsku1TitleList.add((String) element);
        }
        if (newsku1TitleList != null && newsku1TitleList.size() > 0) {
            if (isfrist) {
                baseAdapter.injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 3;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.add_goods_cart_title_item;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new TitleHolder(itemView);
                    }
                }.cleanAfterAddData(titleList.get(1)))
                        .injectHolderDelegate(chlidDel.cleanAfterAddAllData(newsku1TitleList));
            } else {
                chlidDel.clearAll();
                chlidDel.cleanAfterAddAllData(newsku1TitleList);
            }
            baseAdapter.notifyDataSetChanged();
        } else {

        }
        refreshView();
    }

    private int quantity;//库存
    private int skuid;//唯一标识

    //获取价钱库存
    private void refreshView() {
        String sku1 = "";
        String sku2 = "";
        if (sku1TitleList != null && sku1TitleList.size() > 0) {
            sku1 = sku1TitleList.get(indextag);
        }
        if (newsku1TitleList != null && newsku1TitleList.size() > 0) {
            sku2 = newsku1TitleList.get(indextag2);
        }
        if (sku1 != null && !sku1.equals("")) {
            if (sku2 != null && !sku2.equals("")) {
                //从sku2取库存价格
                for (int i = 0; i < bean.getGuige().size(); i++) {
                    if (sku1.equals(bean.getGuige().get(i).getSku1name()) && sku2.equals(bean.getGuige().get(i).getSku2name())) {
                        tvBaojiaPrice.setText("￥" + bean.getGuige().get(i).getPrice());
                        tvName.setText("库存" + bean.getGuige().get(i).getNumber() + "件");
                        skuid = bean.getGuige().get(i).getId();
                        quantity = bean.getGuige().get(i).getNumber();
                    }
                }
            } else {
                //从sku1取库存价格
                for (int i = 0; i < bean.getGuige().size(); i++) {
                    if (sku1.equals(bean.getGuige().get(i).getSku1name())) {
                        tvBaojiaPrice.setText("￥" + bean.getGuige().get(i).getPrice());
                        tvName.setText("库存" + bean.getGuige().get(i).getNumber() + "件");
                        skuid = bean.getGuige().get(i).getId();
                        quantity = bean.getGuige().get(i).getNumber();
                    }
                }
            }
        } else {
            tvBaojiaPrice.setText("￥" + bean.getShangpin().getPrice());
            tvName.setText("");
        }
    }

    //校验库存是否足够
    private void isTrueSubmit() {
        if (NumberUtil.A_compare_B(edNum.getText().toString(), quantity + "") <= 0) {
            if (type == 0) {
                addGoods();
            } else {
                btSubmit.setClickable(true);
                dismiss();
                refreshNum.onRefresh(type, skuid, edNum.getText().toString());
            }
        } else {
            NToast.show("糟糕!~库存不足！");
            btSubmit.setClickable(true);
        }
    }
}
