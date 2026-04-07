package com.linzi.xiguwen.utils;

import android.content.Context;
import android.os.CountDownTimer;
import android.widget.Button;

import com.linzi.xiguwen.R;

/**
 * Created by jiang on 2016/11/28.
 * 计时类
 */
public class TimeReader extends CountDownTimer {
        Button mBt;
        Context mContext;
        public static TimeReader instence;
        public int mFlag=0;
        public String TAG;
        public TimeReader(long millisInFuture, long countDownInterval, Button bt, Context context) {
            super(millisInFuture, countDownInterval);
            instence=this;
            mBt=bt;
            mContext=context;
        }
        @Override
        public void onTick(long millisUntilFinished) {// 计时过程
            mFlag=1;
            TAG="in";
            mBt.setText(millisUntilFinished / 1000 + "s");
            mBt.setBackgroundResource(R.drawable.btn_gray);
//            mBt.setBackgroundColor(mContext.getResources().getColor(R.color.textcolor));
        }
        @Override
        public void onFinish() {// 计时完毕
            mFlag=0;
            mBt.setText("获取验证码");
            mBt.setBackgroundResource(R.drawable.login_bt_selector);
//            mBt.setBackgroundColor(mContext.getResources().getColor(R.color.branktitle));
        }


}
