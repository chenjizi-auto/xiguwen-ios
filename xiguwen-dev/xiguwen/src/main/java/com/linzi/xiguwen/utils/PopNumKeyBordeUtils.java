package com.linzi.xiguwen.utils;

import android.app.Activity;
import android.graphics.drawable.ColorDrawable;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.linzi.xiguwen.R;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/3.
 */

public class PopNumKeyBordeUtils {
    private Activity mActivity;
    private PopupWindow pop;
    private StringBuffer values_key;
    private KeyClickListener mKeyListener;
    private SubmitListener mSubmitListener;

    public interface KeyClickListener {
        public void keyListener(StringBuffer values_key);
    }

    public interface SubmitListener {
        public void submitListener(View view);
    }

    public PopNumKeyBordeUtils(Activity mActivity) {
        this.mActivity = mActivity;
        pop = new PopupWindow(mActivity);
        values_key = new StringBuffer();
    }

    public PopNumKeyBordeUtils setKeyListenner(KeyClickListener mKeyListener) {
        this.mKeyListener = mKeyListener;
        return this;
    }

    public PopNumKeyBordeUtils setSubmitListenner(SubmitListener mSubmitListener) {
        this.mSubmitListener = mSubmitListener;
        return this;
    }

    public PopNumKeyBordeUtils setDefValues(String values) {
        values_key = new StringBuffer(values);
        return this;
    }

    public PopNumKeyBordeUtils show(View llParent) {
        View view = LayoutInflater.from(mActivity).inflate(R.layout.pop_layout_num_keybord, null);
        ViewHolder vh = new ViewHolder(view);
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
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btTwo.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("2");
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btThree.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("3");
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btFour.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("4");
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btFive.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("5");
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btSix.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("6");
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btSeven.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("7");
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btEight.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("8");
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btNine.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("9");
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btPoint.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append(".");
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.btZero.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    values_key.append("0");
                    mKeyListener.keyListener(values_key);
                }
            });
            vh.llDel.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (values_key.length() > 0) {
                        values_key.delete(values_key.length() - 1, values_key.length());
                    }
                    mKeyListener.keyListener(values_key);
                }
            });

            vh.llDel.setOnLongClickListener(new View.OnLongClickListener() {
                @Override
                public boolean onLongClick(View view) {
                    values_key.delete(0, values_key.length());
                    mKeyListener.keyListener(values_key);
                    return false;
                }
            });
        }
        if (mSubmitListener != null) {
            vh.llSubmit.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    mSubmitListener.submitListener(view);
                    pop.dismiss();
                }
            });
        }

        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = mActivity.getWindowManager().getDefaultDisplay().getWidth();
        int h = (mActivity.getWindowManager().getDefaultDisplay().getHeight() / 5) * 2;
        pop.setWidth(w);
        pop.setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0x00000000);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview);
        pop.setContentView(view);
        pop.update();
        pop.showAtLocation(llParent, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
//        lightoff(true);
//        pop.setOnDismissListener(new PopupWindow.OnDismissListener() {
//            @Override
//            public void onDismiss() {
//                lightoff(false);
//            }
//        });

        return this;
    }

    public void dismiss() {
        if (pop != null) {
            pop.dismiss();
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

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
