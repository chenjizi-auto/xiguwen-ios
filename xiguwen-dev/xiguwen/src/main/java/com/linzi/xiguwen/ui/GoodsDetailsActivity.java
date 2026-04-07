package com.linzi.xiguwen.ui;

import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.os.Bundle;
import androidx.core.view.ViewCompat;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.GoodsTypeAdapter;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideImageLoader;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.view.CusScrollView;
import com.youth.banner.Banner;
import com.youth.banner.BannerConfig;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class GoodsDetailsActivity extends AppCompatActivity {

    @BindView(R.id.banner)
    Banner banner;
    @BindView(R.id.tv_title_name)
    TextView tvTitleName;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.tv_sale_num)
    TextView tvSaleNum;
    @BindView(R.id.tv_youhui)
    TextView tvYouhui;
    @BindView(R.id.tv_location)
    TextView tvLocation;
    @BindView(R.id.iv_head)
    ImageView ivHead;
    @BindView(R.id.tv_user_name)
    TextView tvUserName;
    @BindView(R.id.tv_zhiwu)
    TextView tvZhiwu;
    @BindView(R.id.iv_rz_cx)
    ImageView ivRzCx;
    @BindView(R.id.iv_rz_pt)
    ImageView ivRzPt;
    @BindView(R.id.iv_rz_xy)
    ImageView ivRzXy;
    @BindView(R.id.tv_haopinlv)
    TextView tvHaopinlv;
    @BindView(R.id.tv_pinglun_count)
    TextView tvPinglunCount;
    @BindView(R.id.tv_fans)
    TextView tvFans;
    @BindView(R.id.bt_enter_mall)
    Button btEnterMall;
    @BindView(R.id.scrollView)
    CusScrollView scrollView;
    @BindView(R.id.iv_chat)
    ImageView ivChat;
    @BindView(R.id.iv_call_phone)
    ImageView ivCallPhone;
    @BindView(R.id.iv_care)
    ImageView ivCare;
    @BindView(R.id.ll_add_in_cart)
    LinearLayout llAddInCart;
    @BindView(R.id.ll_buy)
    LinearLayout llBuy;
    @BindView(R.id.ll_yuyue)
    LinearLayout llYuyue;
    @BindView(R.id.ll_bottom)
    LinearLayout llBottom;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.ll_title)
    RelativeLayout llTitle;
    @BindView(R.id.ll_back)
    LinearLayout llBack;
    @BindView(R.id.ll_right)
    LinearLayout llRight;
    @BindView(R.id.ll_parent)
    RelativeLayout llParent;

    Context mContext;
    List<String> mBannerData = new ArrayList<>();
    List<String>mChima=new ArrayList<>();
    List<String>mColor=new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(GoodsDetailsActivity.this, R.color.trans);
        }
        setContentView(R.layout.activity_goods_details);
        ButterKnife.bind(this);
        mContext = this;
        initViews();
    }

    private void initViews() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(GoodsDetailsActivity.this));
        llBar.setLayoutParams(params);

        ViewCompat.setAlpha(llTitle, 0);
        ViewCompat.setAlpha(llBar, 0);

        setBanber();
        setType();

        llAddInCart.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                addCart();
            }
        });
    }

    private void setType(){
        mChima.add("XL");
        mChima.add("XL");
        mChima.add("XL");
        mChima.add("XL");
        mChima.add("XL");

        mColor.add("白色-缩短");
        mColor.add("白色-缩短");
        mColor.add("白色-缩短");
    }

    private void setBanber() {
        mBannerData.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511255170196&di=7e4fba7a2af565b2f839978a3c8d8a67&imgtype=0&src=http%3A%2F%2Fjoymepic.joyme.com%2Farticle%2Fuploads%2F20177%2F11501557343644187.jpeg");
        mBannerData.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511255206399&di=e709c7d1f05d577997ca8e0a24da6b3b&imgtype=0&src=http%3A%2F%2Fi2.hdslb.com%2Fbfs%2Farchive%2F26580541a36aba1e49e70c98da4fbc94950232bb.jpg");
        mBannerData.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511255379272&di=26a484f71a8991e7603f5dee6a20a083&imgtype=0&src=http%3A%2F%2Fi1.hdslb.com%2Fbfs%2Farchive%2Fe394736c4b866d06cfc3b4881f82e01e1323eb93.jpg");
        banner.setImages(mBannerData)
                .setImageLoader(new GlideImageLoader())
                .setIndicatorGravity(BannerConfig.CENTER)
                .setDelayTime(2000)
                .start();
    }

    private void addCart() {
        View pop_view = LayoutInflater.from(mContext).inflate(R.layout.pop_add_cart_goods_layout, null);
        final ViewHolder vh = new ViewHolder(pop_view);
        Glide.with(mContext).load("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511255379272&di=26a484f71a8991e7603f5dee6a20a083&imgtype=0&src=http%3A%2F%2Fi1.hdslb.com%2Fbfs%2Farchive%2Fe394736c4b866d06cfc3b4881f82e01e1323eb93.jpg").into(vh.ivImg);
        vh.tvName.setText("库存  " + 32);
        vh.tvBaojiaPrice.setText(Constans.RMB + "1000");
        vh.edNum.setText("1");
        vh.btAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int num = Integer.valueOf(vh.edNum.getText().toString());
                num++;
                vh.edNum.setText("" + num);
            }
        });
        vh.btJian.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int num = Integer.valueOf(vh.edNum.getText().toString());
                if (num == 1) {
                    NToast.show("最少购买1件商品");
                } else {
                    num--;
                    vh.edNum.setText("" + num);
                }
            }
        });

        GridLayoutManager manager=new GridLayoutManager(mContext,4){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        GridLayoutManager manager2=new GridLayoutManager(mContext,5){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        vh.colorRecycle.setLayoutManager(manager);
        vh.sizeRecycle.setLayoutManager(manager2);
        GoodsTypeAdapter adapter=new GoodsTypeAdapter(mColor, mContext, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
            }
        });
        GoodsTypeAdapter adapter2=new GoodsTypeAdapter(mChima, mContext, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {

            }
        });
        vh.colorRecycle.setAdapter(adapter);
        vh.sizeRecycle.setAdapter(adapter2);

        final PopupWindow pop = new PopupWindow(mContext);
        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int width = this.getWindowManager().getDefaultDisplay().getWidth();
        int height = this.getWindowManager().getDefaultDisplay().getHeight();
        pop.setWidth(width);
//        pop.setHeight(height - (height / 6));
        ColorDrawable dw = new ColorDrawable(0xffffffff);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview);
        pop.setContentView(pop_view);
        pop.showAtLocation(llParent, Gravity.BOTTOM, 0, 0);
        lightoff(true);
        pop.setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });
        vh.llChooseData.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                pop.dismiss();
            }
        });
        vh.btSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                pop.dismiss();
            }
        });
    }

    public void lightoff(boolean isoff) {
        WindowManager.LayoutParams lp = getWindow().getAttributes();
        if (isoff) {
            lp.alpha = 0.3f;
        } else {
            lp.alpha = 1f;
        }
        getWindow().setAttributes(lp);
    }

    //将dp转换为px
    public int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }
    class ViewHolder {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_baojia_price)
        TextView tvBaojiaPrice;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.color_recycle)
        RecyclerView colorRecycle;
        @BindView(R.id.ll_choose_data)
        LinearLayout llChooseData;
        @BindView(R.id.size_recycle)
        RecyclerView sizeRecycle;
        @BindView(R.id.bt_add)
        Button btAdd;
        @BindView(R.id.ed_num)
        EditText edNum;
        @BindView(R.id.bt_jian)
        Button btJian;
        @BindView(R.id.bt_submit)
        Button btSubmit;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
