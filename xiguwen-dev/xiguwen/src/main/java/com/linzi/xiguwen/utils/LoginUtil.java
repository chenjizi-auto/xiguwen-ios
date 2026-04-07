package com.linzi.xiguwen.utils;

import android.text.TextUtils;

import com.linzi.xiguwen.utils.yixin.LogoutHelper;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.netease.nimlib.sdk.NIMClient;
import com.netease.nimlib.sdk.auth.AuthService;

/**
 * Created by devin on 2018/4/12 16:25
 * Description
 */

public class LoginUtil {

    public static boolean isLogin() {
        if (!TextUtils.isEmpty(SPUtil.get("token", SPUtil.Type.STR).toString()) &&
                !TextUtils.isEmpty(SPUtil.get("userid", SPUtil.Type.INT).toString())) {
            return true;
        }
        return false;
    }

    public static void loginOut() {
        // 注销
        Preferences.saveUserToken("");
        Preferences.saveUserAccount("");
        // 清理缓存&注销监听
        LogoutHelper.logout();
        NIMClient.getService(AuthService.class).logout();
        SPUtil.clear();
    }


}
