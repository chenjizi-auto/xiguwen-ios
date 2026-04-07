package com.linzi.xiguwen.view;

import android.content.Context;
import android.content.DialogInterface;
import androidx.appcompat.app.*;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.MsgLoadDialog;

/**
 * Created by pc on 2018/5/7.
 */

public class DownLoadDialog extends androidx.appcompat.app.AlertDialog {
    static Context mContext;
    static MsgLoadDialog dialog;
    static int mSize = 100;
    int backGround_color = android.R.color.transparent;
    String mMsg = "加载中";
    View mView;
    TextView mTextView;
    LinearLayout linearLayout;

    private boolean mIsCancleable = true;

    //    public static void init(Context context){
//        mContext=context;
//    }
//    public static void init(Context context, int size, int backGroundcolor, View view){
//        mSize=size;
//        mContext=context;
//        backGround_color=backGroundcolor;
//        mView=view;
//    }
    public DownLoadDialog(Context context, String msg) {
        super(context);

        if (msg != null) {
            mMsg = msg;
        }
        linearLayout = new LinearLayout(context);
        linearLayout.setGravity(Gravity.CENTER);
        linearLayout.setOrientation(LinearLayout.VERTICAL);
        linearLayout.setBackgroundColor(context.getResources().getColor(android.R.color.transparent));
        linearLayout.setPadding(dip2px(context, mSize / 8), dip2px(context, mSize / 8), dip2px(context, mSize / 8), dip2px(context, mSize / 8));
        ViewGroup.LayoutParams params0 = new ViewGroup.LayoutParams(dip2px(context, mSize + 30), dip2px(context, mSize + 50));
        linearLayout.setLayoutParams(params0);

        ViewGroup.LayoutParams params1 = new ViewGroup.LayoutParams(dip2px(context, 60), dip2px(context, 60));
        if (mView == null) {
            ProgressBar progressBar = new ProgressBar(context);
            progressBar.setLayoutParams(params1);
            progressBar.setPadding(dip2px(context, 10), dip2px(context, 10), dip2px(context, 10), dip2px(context, 10));
            progressBar.setIndeterminateDrawable(context.getResources().getDrawable(R.drawable.progressbar));
            linearLayout.addView(progressBar);
        } else {
            mView.setLayoutParams(params1);
            linearLayout.addView(mView);
        }
        if (!mMsg.equals("")) {
            mTextView = new TextView(context);
            ViewGroup.LayoutParams params = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            mTextView.setLayoutParams(params);
            mTextView.setText(mMsg);
            mTextView.setGravity(Gravity.CENTER);
            linearLayout.addView(mTextView);
        }

        this.onBackPressed();
//        this.setContentView(linearLayout);
        this.setView(linearLayout);
        this.setCanceledOnTouchOutside(false);
        this.setOnKeyListener(new OnKeyListener() {
            @Override
            public boolean onKey(DialogInterface d, int keyCode, KeyEvent event) {
                if (!mIsCancleable) {
                    return true;
                }
                if ((keyCode == KeyEvent.KEYCODE_HOME || keyCode == KeyEvent.KEYCODE_BACK) && event.getRepeatCount() == 0) {
                    dialog.dismiss();
                    dialog = null;
                    mContext = null;
                    return true;
                } else {
                    return false;
                }
            }
        });
    }

    public void setMessage(String msg) {
        if (msg != null) {
            mMsg = msg;
            if (mTextView != null) {
                mTextView.setText(msg);
            }
        }
    }

    public void setCancleable(boolean isCancleable) {
        this.mIsCancleable = isCancleable;
    }

    public static void showDialog(Context context, String msg, boolean cancelable, OnCancelListener listener) {
        mContext = context;
        if (mContext != null) {
            if (dialog == null) {
                dialog = new MsgLoadDialog(mContext, msg);
                dialog.setCancelable(false);
                dialog.setOnCancelListener(listener);
                dialog.setCancleable(cancelable);
                dialog.show();
                dialog.getWindow().setLayout(dip2px(context, mSize + 30), dip2px(context, mSize + 50));
            } else {
                dialog.setOnCancelListener(listener);
                dialog.getWindow().setLayout(dip2px(context, mSize + 30), dip2px(context, mSize + 50));
                dialog.setCancleable(cancelable);
                dialog.show();
            }
        }
    }

    public static void showDialog(Context context, String msg, OnCancelListener listener) {
        showDialog(context, msg, true, listener);
    }

    public static void showDialog(Context context, String msg) {
        showDialog(context, msg, true);
    }

    public static void showDialog(Context context, String msg, boolean cancelable) {
        showDialog(context, msg, cancelable, null);
    }

    public static void updateMsg(String msg) {
        if (dialog != null) {
            if (dialog.isShowing()) {
                dialog.setMessage(msg);
            }
        }
    }

    public static void showDialog(Context context) {
        showDialog(context, null);
    }

    public static void CancelDialog() {
        if (dialog != null) {
            if (dialog.isShowing()) {
                dialog.dismiss();
                dialog = null;
                mContext = null;
            }
        }
    }

    //将dp转换为px
    public static int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }
}
