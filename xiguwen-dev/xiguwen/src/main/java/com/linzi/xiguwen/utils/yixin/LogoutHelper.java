package com.linzi.xiguwen.utils.yixin;

import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.netease.nimlib.sdk.NIMClient;
import com.netease.nimlib.sdk.auth.AuthService;

/**
 * 注销帮助类
 * Created by huangjun on 2015/10/8.
 */
public class LogoutHelper {
    public static void logout() {
        Preferences.saveUserToken("");
        Preferences.saveString(Preferences.USER_PHONE,"");
        Preferences.saveString(Preferences.WACHAT_OPENID,"");
        NIMClient.getService(AuthService.class).logout();
        // 清理缓存&注销监听&清除状态
//        NimUIKit.logout();
        DemoCache.clear();
//        DropManager.getInstance().destroy();

    }
}
