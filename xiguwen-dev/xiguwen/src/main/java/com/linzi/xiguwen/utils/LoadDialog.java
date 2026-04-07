package com.linzi.xiguwen.utils;
import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Build;
import android.view.Window;
import androidx.appcompat.app.AlertDialog;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.linzi.xiguwen.R;


/**
 * Created by linzi on 2017/4/26.
 */

public class LoadDialog extends AlertDialog {
    static Context mContext;
    static LoadDialog dialog;
    static int mSize=100;
    static int backGround_color=android.R.color.white;
    static String mMsg="加载中";
    static View mView;
    static LinearLayout linearLayout;
//    public static void init(Context context){
//        mContext=context;
//    }
//    public static void init(Context context, int size, int backGroundcolor, View view){
//        mSize=size;
//        mContext=context;
//        backGround_color=backGroundcolor;
//        mView=view;
//    }
    public LoadDialog(Context context) {
        super(context);

        linearLayout = new LinearLayout(context);
        linearLayout.setGravity(Gravity.CENTER);
        linearLayout.setOrientation(LinearLayout.VERTICAL);
        linearLayout.setBackgroundColor(context.getResources().getColor(backGround_color));
        linearLayout.setPadding(dip2px(context, mSize / 8), dip2px(context, mSize / 8), dip2px(context, mSize / 8), dip2px(context, mSize / 8));
        ViewGroup.LayoutParams params0 = new ViewGroup.LayoutParams(dip2px(context, mSize+30), dip2px(context, mSize+50));
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
            TextView textView = new TextView(context);
            ViewGroup.LayoutParams params = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            textView.setLayoutParams(params);
            textView.setText(mMsg);
            textView.setGravity(Gravity.CENTER);
            linearLayout.addView(textView);
        }

        this.onBackPressed();
//        this.setContentView(linearLayout);
        this.setView(linearLayout);
        this.setCanceledOnTouchOutside(false);
        this.setOnKeyListener(new OnKeyListener() {
            @Override
            public boolean onKey(DialogInterface d, int keyCode, KeyEvent event) {
                if ((keyCode == KeyEvent.KEYCODE_HOME || keyCode == KeyEvent.KEYCODE_BACK) && event.getRepeatCount() == 0) {
                    dialog.dismiss();
                    dialog=null;
                    mContext=null;
                    return true;
                } else {
                    return false;
                }
            }
        });
    }
    public static void showDialog(Context context){
        if (context == null) {
            return;
        }
        if (context instanceof Activity) {
            Activity activity = (Activity) context;
            if (activity.isFinishing()) {
                return;
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1 && activity.isDestroyed()) {
                return;
            }
        }
        if (dialog != null && mContext != context) {
            try {
                dialog.dismiss();
            } catch (Exception ignored) {
            }
            dialog = null;
        }
        mContext = context;
        try {
            if (dialog == null) {
                dialog = new LoadDialog(mContext);
                dialog.setCancelable(false);
            }
            if (!dialog.isShowing()) {
                dialog.show();
            }
            Window window = dialog.getWindow();
            if (window != null) {
                window.setLayout(dip2px(context, mSize + 30), dip2px(context, mSize + 50));
            }
        } catch (Exception e) {
            try {
                if (dialog != null) {
                    dialog.dismiss();
                }
            } catch (Exception ignored) {
            }
            dialog = null;
            mContext = null;
        }
    }
    public static void CancelDialog(){
        if(dialog!=null){
            if(dialog.isShowing()){
                try {
                    dialog.dismiss();
                } catch (Exception ignored) {
                } finally {
                    dialog=null;
                    mContext=null;
                }
            }
        }
    }
    //将dp转换为px
    public static int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }
}
