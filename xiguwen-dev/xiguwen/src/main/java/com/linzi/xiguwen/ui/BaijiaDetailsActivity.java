package com.linzi.xiguwen.ui;

import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.os.Bundle;
import androidx.core.view.ViewCompat;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
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
import android.widget.RadioButton;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.BaojiaImgAdapter;
import com.linzi.xiguwen.adapter.MallIndexAdapter;
import com.linzi.xiguwen.bean.MyDateBean;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideImageLoader;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.view.CusScrollView;
import com.linzi.xiguwen.view.ScrollerDatePicker;
import com.youth.banner.Banner;
import com.youth.banner.BannerConfig;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class BaijiaDetailsActivity extends AppCompatActivity {

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
    @BindView(R.id.iv_to_top)
    ImageView ivToTop;
    @BindView(R.id.tv_cart_num)
    TextView tvCartNum;
    @BindView(R.id.iv_cart)
    RelativeLayout ivCart;
    @BindView(R.id.tv_context)
    TextView tvContext;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.recycle2)
    RecyclerView recycle2;
    @BindView(R.id.ll_add_in_cart)
    LinearLayout llAddInCart;
    @BindView(R.id.ll_buy)
    LinearLayout llBuy;
    @BindView(R.id.ll_parent)
    RelativeLayout llParent;

    Context mContext;
    List<String> mBannerData = new ArrayList<>();

    int year = 0, month = 0, day = 0;
    int tomonth = 0;
    int toyear = 0;
    int today = 0;

    String mTime=null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(BaijiaDetailsActivity.this, R.color.trans);
        }
        setContentView(R.layout.activity_baijia_details);
        ButterKnife.bind(this);
        mContext = this;
        initView();
    }

    private void initView() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(BaijiaDetailsActivity.this));
        llBar.setLayoutParams(params);

        ViewCompat.setAlpha(llTitle, 0);
        ViewCompat.setAlpha(llBar, 0);
        scrollView.setScrollViewListener(new CusScrollView.ScrollViewListener() {
            @Override
            public void onScrollChanged(CusScrollView scrollView, int x, int y, int oldx, int oldy) {
                float percent = Float.valueOf("" + y) / Float.valueOf("" + dip2px(mContext, 200));
                if ((1 - percent) < 0.1) {
                    percent = 1;
                }
                if (percent > 1) {
                    percent = 1;
                }
                ViewCompat.setAlpha(llBar, percent);
                ViewCompat.setAlpha(llTitle, percent);

                if (y > 0) {
                    ivToTop.setVisibility(View.VISIBLE);
                } else {
                    ivToTop.setVisibility(View.GONE);
                }
            }
        });

        ivToTop.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                scrollView.fullScroll(ScrollView.FOCUS_UP);
                scrollView.scrollTo(0, 0);
                scrollView.setFocusable(true);
            }
        });

        llBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

        setBanber();

        LinearLayoutManager manager1 = new LinearLayoutManager(mContext) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager1);
        BaojiaImgAdapter adapter1 = new BaojiaImgAdapter(mContext, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {

            }
        });
        recycle.setAdapter(adapter1);

        MallIndexAdapter.BaojiaAdapter adapter = new MallIndexAdapter(mContext).new BaojiaAdapter();
        GridLayoutManager manager = new GridLayoutManager(mContext, 2) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle2.setLayoutManager(manager);
        recycle2.setAdapter(adapter);

        initData();

        llAddInCart.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                addCart();
            }
        });


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
        View pop_view = LayoutInflater.from(mContext).inflate(R.layout.pop_add_cart_layout, null);
        final ViewHolder vh = new ViewHolder(pop_view);
        Glide.with(mContext).load("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511255379272&di=26a484f71a8991e7603f5dee6a20a083&imgtype=0&src=http%3A%2F%2Fi1.hdslb.com%2Fbfs%2Farchive%2Fe394736c4b866d06cfc3b4881f82e01e1323eb93.jpg").into(vh.ivImg);
        vh.tvName.setText("林子");
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
                    NToast.show("最少购买1项服务");
                } else {
                    num--;
                    vh.edNum.setText("" + num);
                }
            }
        });
        if(mTime!=null){
            vh.tvData.setText(mTime);
        }
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
                selectDate();
            }
        });
        vh.btSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                pop.dismiss();
            }
        });
    }

    private void selectDate() {
        ArrayList<MyDateBean> year_list = new ArrayList<>();
        ArrayList<MyDateBean> month_list = new ArrayList<>();
        final ArrayList<MyDateBean> day_list = new ArrayList<>();
        final ArrayList<MyDateBean> when_list = new ArrayList<>();
        MyDateBean mBean;
        int years = 0;
        int year_tag = 0;
        int month_tag = 0;
        int day_tag = 0;
        for (int x = 0; x < 50; x++) {
            years = 2000 + x;
            mBean = new MyDateBean();
            mBean.setId(x);
            mBean.setDate("" + years);
            year_list.add(mBean);
            if (years == year) {
                year_tag = x;
            }
        }
        for (int x = 0; x < 12; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            mBean.setDate("" + (x + 1));
            month_list.add(mBean);
            if ((x + 1) == month) {
                month_tag = x;
            }
        }

        int max_day_num = getDaysByYearMonth(year, month);
        for (int x = 0; x < max_day_num; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            mBean.setDate("" + (x + 1));
            day_list.add(mBean);
            if ((x + 1) == day) {
                day_tag = x;
            }
        }
        for (int x = 0; x < 4; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            switch (x) {
                case 0:
                    mBean.setDate("上午");
                    break;
                case 1:
                    mBean.setDate("中午");
                    break;
                case 2:
                    mBean.setDate("下午");
                    break;
                case 3:
                    mBean.setDate("晚上");
                    break;
            }
            when_list.add(mBean);
        }
        final PopupWindow pop = new PopupWindow(mContext);
        View view = LayoutInflater.from(mContext).inflate(R.layout.pop_richeng_select_date_layout, null);
        final VHTime vh = new VHTime(view);
        vh.tvClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                pop.dismiss();
                addCart();
            }
        });
        vh.tvSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                year = Integer.valueOf(vh.pickYear.getSelectedText());
                month = Integer.valueOf(vh.pickMonth.getSelectedText());
                day = Integer.valueOf(vh.pickDay.getSelectedText());
                String mm = "";
                String dd = "";
                if (month < 10) {
                    mm = "0" + month;
                } else {
                    mm = "" + month;
                }
                if (day < 10) {
                    dd = "0" + day;
                } else {
                    dd = "" + day;
                }

                int y = Integer.valueOf(vh.pickYear.getSelectedText());
                int m = Integer.valueOf(vh.pickMonth.getSelectedText());
                int d = Integer.valueOf(vh.pickDay.getSelectedText());
                if (y < toyear) {
                    NToast.show("不能选择过去的日期");
                    return;
                }
                if (m < (tomonth)) {
                    if (y <= toyear) {
                        NToast.show("不能选择过去的日期");
                        return;
                    }
                }
                if (d < today) {
                    if (m <= (tomonth)) {
                        if (y <= toyear) {
                            NToast.show("不能选择过去的日期");
                            return;
                        }
                    }
                }

                mTime=year + "-" + mm + "-" + dd + "  " + vh.pickWhen.getSelectedText();
                pop.dismiss();
                addCart();

            }
        });
        vh.pickYear.setData(year_list);
        vh.pickMonth.setData(month_list);
        vh.pickDay.setData(day_list);
        vh.pickWhen.setData(when_list);

        vh.pickYear.setDefault(year_tag);
        vh.pickMonth.setDefault(month_tag);
        vh.pickDay.setDefault(day_tag);

        vh.pickYear.setOnSelectListener(new ScrollerDatePicker.OnSelectListener() {
            @Override
            public void endSelect(int id, String text) {
                year = Integer.valueOf(text);
            }

            @Override
            public void selecting(int id, String text) {
            }
        });
        final int finalDay_tag = day_tag;
        vh.pickMonth.setOnSelectListener(new ScrollerDatePicker.OnSelectListener() {
            @Override
            public void endSelect(int id, String text) {
                month = Integer.valueOf(text);
                ArrayList<MyDateBean> list = setDay();
                vh.pickDay.setData(list);
                if (month == tomonth) {
                    vh.pickDay.setDefault(finalDay_tag);
                } else {
                    vh.pickDay.setDefault(0);
                }
            }

            @Override
            public void selecting(int id, String text) {
            }
        });

        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = this.getWindowManager().getDefaultDisplay().getWidth();
        int h = (this.getWindowManager().getDefaultDisplay().getHeight()/2);
        pop.setWidth(w);
        pop.setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0xffff0000);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview);
        pop.setContentView(view);
        pop.update();
        pop.showAtLocation(llParent, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        lightoff(true);
        pop.setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });
    }

    private ArrayList<MyDateBean> setDay() {
        ArrayList<MyDateBean> list = new ArrayList<>();
        int max_day_num = getDaysByYearMonth(year, month);
        MyDateBean mBean;
        for (int x = 0; x < max_day_num; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            mBean.setDate("" + (x + 1));
            list.add(mBean);
        }
        return list;
    }

    /**
     * 根据年 月 获取对应的月份 天数
     */
    public int getDaysByYearMonth(int year, int month) {

        Calendar a = Calendar.getInstance();
        a.set(Calendar.YEAR, year);
        a.set(Calendar.MONTH, month - 1);
        a.set(Calendar.DATE, 1);
        a.roll(Calendar.DATE, -1);
        int maxDate = a.get(Calendar.DATE);
        return maxDate;
    }

    private void initData() {
        Calendar calendar = Calendar.getInstance();
        year = calendar.get(Calendar.YEAR);
        month = (calendar.get(Calendar.MONTH) + 1);
        day = calendar.get(Calendar.DAY_OF_MONTH);
        tomonth = month;
        toyear = year;
        today = day;
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
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_baojia_price)
        TextView tvBaojiaPrice;
        @BindView(R.id.tv_data)
        TextView tvData;
        @BindView(R.id.ll_choose_data)
        LinearLayout llChooseData;
        @BindView(R.id.rb_pay_all)
        RadioButton rbPayAll;
        @BindView(R.id.rb_pay_some)
        RadioButton rbPaySome;
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

    class VHTime {
        @BindView(R.id.tv_close)
        TextView tvClose;
        @BindView(R.id.tv_submit)
        TextView tvSubmit;
        @BindView(R.id.pick_year)
        ScrollerDatePicker pickYear;
        @BindView(R.id.tv_nian)
        TextView tvNian;
        @BindView(R.id.pick_month)
        ScrollerDatePicker pickMonth;
        @BindView(R.id.tv_yue)
        TextView tvYue;
        @BindView(R.id.pick_day)
        ScrollerDatePicker pickDay;
        @BindView(R.id.tv_ri)
        TextView tvRi;
        @BindView(R.id.pick_when)
        ScrollerDatePicker pickWhen;

        VHTime(View view) {
            ButterKnife.bind(this, view);
        }
    }

}
