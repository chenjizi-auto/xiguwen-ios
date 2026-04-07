package com.linzi.xiguwen.utils;

import android.content.Context;
import android.content.Intent;

import com.linzi.xiguwen.ui.LoginActivity;

/**
 * Created by devin on 2018/4/12 16:38
 * Description
 */

public abstract class LoginHepler {

    /**
     * @param context
     * @param code     根据code事件判断来源
     * @param login    是否必须登录
     * @param listener 直接执行业务方法回调
     */
    public static void LoginHepler(Context context, int code, boolean login, LoginHeplerListener listener) {

        if (LoginUtil.isLogin()) {
            listener.loginOpinion(code);
        } else {
            if (login) {//必须登录
                context.startActivity(new Intent(context, LoginActivity.class));
            } else {//非必须登录
                listener.loginOpinion(code);
            }
        }

    }

}
