package com.linzi.xiguwen.utils;

import android.app.Activity;
import android.graphics.drawable.ColorDrawable;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.BillDataBean;

import java.util.Calendar;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/3.
 */

public class PopJiZhangKeyBordeUtils implements View.OnClickListener {
    private Activity mActivity;
    private PopupWindow pop;
    private StringBuffer values_key;
    private KeyClickListener mKeyListener;
    private SubmitListener mSubmitListener;
    private TodayListener todayListener;

    private ViewHolder mVh;

    private int year = 0000, month = 00, day = 00;
    private int toyear = 0000, tomonth = 00, today = 00, hour = 00, m = 00;


    private int mType = 1;  // 2收入， 1支出
    private View llParent;

    @Override
    public void onClick(View view) {
        switch (view.getId()){
            case R.id.ll_hide:
                todayListener.todayListener(view);
                break;
            case R.id.ll_submit:
                mSubmitListener.submitListener(this, view);
                break;
        }
    }

    public interface KeyClickListener {
        public void keyListener(StringBuffer values_key);
    }

    public interface SubmitListener {
        public void submitListener(PopJiZhangKeyBordeUtils popWindos, View view);
    }

    public interface TodayListener {
        public void todayListener(View view);
    }

    public PopJiZhangKeyBordeUtils(Activity mActivity) {
        this.mActivity = mActivity;
        pop = new PopupWindow(mActivity);
        Calendar calendar = Calendar.getInstance();
        toyear = calendar.get(Calendar.YEAR);
        tomonth = calendar.get(Calendar.MONTH);
        today = calendar.get(Calendar.DAY_OF_MONTH);
        year = toyear;
        month = tomonth;
        day = today;
        values_key = new StringBuffer();
    }

    public int getType(){
        return mType;
    }

    public String getPrice(){
        return mVh.tvPrice.getText().toString().trim();
    }

    public String getRemark(){
        return mVh.edBeizhu.getText().toString().trim();
    }

    public PopJiZhangKeyBordeUtils setKeyListenner(KeyClickListener mKeyListener) {
        this.mKeyListener = mKeyListener;
        return this;
    }

    public PopJiZhangKeyBordeUtils setTodayListener(TodayListener todayListener) {
        this.todayListener = todayListener;
        return this;
    }

    public PopJiZhangKeyBordeUtils setSubmitListenner(SubmitListener mSubmitListener) {
        this.mSubmitListener = mSubmitListener;
        return this;
    }

    public PopJiZhangKeyBordeUtils setDefValues(String values) {
        values_key = new StringBuffer(values);
        return this;
    }

    public PopJiZhangKeyBordeUtils show(View llParent) {
        View view = LayoutInflater.from(mActivity).inflate(R.layout.pop_jizhangzhushou_add_layout, null);
        final ViewHolder vh = new ViewHolder(view);
        mVh = vh;
        vh.llHide.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                pop.dismiss();
            }
        });

        if (mKeyListener != null) {
            vh.btOne.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("1");
                    vh.tvPrice.setText(values_key.toString());
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btTwo.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("2");
                    vh.tvPrice.setText(values_key.toString());
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btThree.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("3");
                    vh.tvPrice.setText(values_key.toString());
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btFour.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("4");
                    vh.tvPrice.setText(values_key.toString());
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btFive.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("5");
                    vh.tvPrice.setText(values_key.toString());
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btSix.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("6");
                    vh.tvPrice.setText(values_key.toString());
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btSeven.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("7");
                    vh.tvPrice.setText(values_key.toString());
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btEight.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("8");
                    vh.tvPrice.setText(values_key.toString());
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btNine.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("9");
                    vh.tvPrice.setText(values_key.toString());
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btPoint.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if(values_key.charAt('.') != -1){
                        return;
                    }
                    values_key.append(".");
                    vh.tvPrice.setText(values_key.toString());
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btZero.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("0");
                    vh.tvPrice.setText(values_key.toString());
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.llDel.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (values_key.length() > 0) {
                        values_key.delete(values_key.length() - 1, values_key.length());
                    }
                    vh.tvPrice.setText(values_key.toString());
                    mKeyListener.keyListener(values_key);
                }
            });

            vh.llDel.setOnLongClickListener(new View.OnLongClickListener() {
                @Override
                public boolean onLongClick(View view) {
                    values_key.delete(0, values_key.length());
                    vh.tvPrice.setText(values_key.toString());
                    mKeyListener.keyListener(values_key);
                    return false;
                }
            });
            vh.ivZhichu.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    mType = BillDataBean.TYPE_ZHICHU;
                    updateType();
                }
            });
            vh.ivShouru.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    mType = BillDataBean.TYPE_SHOURU;
                    updateType();
                }
            });
        }


        if(todayListener != null){
            vh.llHide.setOnClickListener(this);
        }
        if(mSubmitListener != null){
            vh.llSubmit.setOnClickListener(this);
        }
        vh.ivClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                pop.dismiss();
            }
        });

        updateType();

        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = mActivity.getWindowManager().getDefaultDisplay().getWidth();
        int h = mActivity.getWindowManager().getDefaultDisplay().getHeight();
//        int h = (mActivity.getWindowManager().getDefaultDisplay().getHeight() / 5) * 2;
        pop.setWidth(w);
        pop.setHeight(ViewGroup.LayoutParams.MATCH_PARENT);
//        pop.setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0x00000000);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview);
        pop.setContentView(view);
        pop.update();
        pop.showAtLocation(llParent, Gravity.CENTER_HORIZONTAL, 0, 0);
        lightoff(true);
        pop.setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });

        this.llParent = llParent;
        return this;
    }

    private void updateType(){
        if(mType == BillDataBean.TYPE_SHOURU){
            mVh.ivShouru.setImageResource(R.mipmap.icon_shouru_m_choose);
            mVh.ivZhichu.setImageResource(R.mipmap.icon_zhichu_m_normal);
        }else{
            mVh.ivShouru.setImageResource(R.mipmap.icon_shouru_m_normal);
            mVh.ivZhichu.setImageResource(R.mipmap.icon_zhichu_m_choose);
        }
    }

    public void dismiss() {
        if (pop != null) {
            pop.dismiss();
        }
    }

    public void setTodayText(String str){
        if(mVh != null){
            mVh.tvDate.setTextSize(TypedValue.COMPLEX_UNIT_SP, 16);
            mVh.tvDate.setText(str);
        }
    }


    public void show(){
        if(pop != null){
            pop.showAtLocation(llParent, Gravity.CENTER_HORIZONTAL, 0, 0);
        }
    }

    private void lightoff(boolean isoff) {
        WindowManager.LayoutParams lp = mActivity.getWindow().getAttributes();
        if (isoff) {
            lp.alpha = 0.3f;
        } else {
            lp.alpha = 1f;
        }
        mActivity.getWindow().setAttributes(lp);
    }

    class ViewHolder {
        @BindView(R.id.iv_zhichu)
        ImageView ivZhichu;
        @BindView(R.id.iv_shouru)
        ImageView ivShouru;
        @BindView(R.id.iv_close)
        ImageView ivClose;
        @BindView(R.id.ed_beizhu)
        EditText edBeizhu;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.bt_one)
        TextView btOne;
        @BindView(R.id.bt_four)
        TextView btFour;
        @BindView(R.id.bt_seven)
        TextView btSeven;
        @BindView(R.id.bt_point)
        TextView btPoint;
        @BindView(R.id.bt_two)
        TextView btTwo;
        @BindView(R.id.bt_five)
        TextView btFive;
        @BindView(R.id.bt_eight)
        TextView btEight;
        @BindView(R.id.bt_zero)
        TextView btZero;
        @BindView(R.id.bt_three)
        TextView btThree;
        @BindView(R.id.bt_six)
        TextView btSix;
        @BindView(R.id.bt_nine)
        TextView btNine;
        @BindView(R.id.ll_hide)
        LinearLayout llHide;
        @BindView(R.id.ll_del)
        LinearLayout llDel;
        @BindView(R.id.ll_submit)
        LinearLayout llSubmit;

        @BindView(R.id.tv_date)
        TextView tvDate;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
