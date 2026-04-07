package com.linzi.xiguwen.app;

import android.app.Application;
import android.content.Context;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.text.TextUtils;

import com.baidu.mapapi.SDKInitializer;
import com.linzi.xiguwen.dele.TestImageLoader;
import com.linzi.xiguwen.net.MapUtils;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.location.LocationHelper;
import com.linzi.xiguwen.utils.yixin.DemoCache;
import com.linzi.xiguwen.utils.yixin.NIMInitManager;
import com.linzi.xiguwen.utils.yixin.NimSDKOptionConfig;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.utils.yixin.preference.UserPreferences;
import com.lljjcoder.style.citylist.utils.CityListLoader;
import com.netease.nimlib.sdk.NIMClient;
import com.netease.nimlib.sdk.auth.LoginInfo;
import com.netease.nimlib.sdk.util.NIMUtil;
import com.previewlibrary.ZoomMediaLoader;
import com.umeng.commonsdk.UMConfigure;
import com.umeng.socialize.PlatformConfig;
import com.linzi.xiguwen.BuildConfig;
import com.linzi.xiguwen.utils.CrashHandler;
import com.linzi.xiguwen.utils.LogcatCapture;
import com.linzi.xiguwen.utils.LogFileManager;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;
import org.xutils.x;

import cn.jpush.android.api.JPushInterface;

/**
 * Created by linzi on 2017/8/7.
 */

public class XiGuWenApplication extends Application {
    private static XiGuWenApplication mInstance;
    private String TAG = "Application";

    @Override
    public void onCreate() {
        super.onCreate();
//        if (LeakCanary.isInAnalyzerProcess(this)) {
//            // This process is dedicated to LeakCanary for heap analysis.
//            // You should not init your app in this process.
//            return;
//        }
//        LeakCanary.install(this);
        EventBusUtil.register(this);
        mInstance = this;
        DemoCache.setContext(this);
        x.Ext.init(this);
//        x.Ext.setDebug(false); //输出debug日志，开启会影响性能
        NToast.init(this);
        //初始化sputils
        SPUtil.init(this, "boyi.app.data", MODE_PRIVATE);

        LogFileManager.init(this);
        LogFileManager.ensureLogDir(this);
        LogFileManager.deleteLogsOlderThan(this, 7);
        CrashHandler.install(this);
        if (BuildConfig.DEBUG) {
            LogcatCapture.start(this);
        }

        if ((boolean) SPUtil.get("isNeedZC", SPUtil.Type.BOOL)) {
            com.linzi.xiguwen.utils.LogUtil.e(TAG,"初始化三方SDK!");
            init();
        }


    }

    public void init(){
        // 4.6.0 开始，第三方推送配置入口改为 SDKOption#mixPushConfig，旧版配置方式依旧支持。
        NIMClient.init(this, getLoginInfo(), NimSDKOptionConfig.getSDKOptions(this));
        //初始化helper
        LocationHelper.initHelper(this);
        // 以下逻辑只在主进程初始化时执行
        if (NIMUtil.isMainProcess(this)) {
            // init pinyin
//            PinYin.init(this);
//            PinYin.validate();
            // 初始化UIKit模块
            initUIKit();
            // 初始化消息提醒
            NIMClient.toggleNotification(UserPreferences.getNotificationToggle());
            // 云信sdk相关业务初始化
            NIMInitManager.getInstance().init(true);
        }

        CityListLoader.getInstance().loadProData(this);
        refreshSDK();
    }

    public void refreshSDK() {


        JPushInterface.setDebugMode(true);    // 设置开启日志,发布时请关闭日志

        JPushInterface.init(this);            // 初始化 JPush

        initUM();

        // crash handler

        // 注册自定义推送消息处理，这个是可选项
//        NIMPushClient.registerMixPushMessageHandler(new DemoMixPushMessageHandler());

        MapUtils.init(this);

        ZoomMediaLoader.getInstance().init(new TestImageLoader());
        //兼容Uri
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
//            StrictMode.VmPolicy.Builder builder = new StrictMode.VmPolicy.Builder();
//            StrictMode.setVmPolicy(builder.build());
//        }

        //在使用SDK各组件之前初始化context信息，传入ApplicationContext
        //注意该方法要再setContentView方法之前实现

        SDKInitializer.initialize(getApplicationContext());

//        NIMClient.init(this, loginInfo(), options());
////         ... your codes
//        if (inMainProcess(this)) {
//            // 注意：以下操作必须在主进程中进行
//            // 1、UI相关初始化操作
//            // 2、相关Service调用
//            NIMClient.getService(AuthServiceObserver.class).observeOnlineStatus(
//                    new Observer<StatusCode>() {
//                        public void onEvent(StatusCode status) {
//                            com.linzi.xiguwen.utils.LogUtil.i("tag", "User status changed to: " + status);
//                            if (status.wontAutoLogin()) {
//                                // 被踢出、账号被禁用、密码错误等情况，自动登录失败，需要返回到登录界面进行重新登录操作
//                            }
//                        }
//                    }, true);
//
//            NIMClient.getService(AuthServiceObserver.class).observeLoginSyncDataStatus(new Observer<LoginSyncStatus>() {
//                @Override
//                public void onEvent(LoginSyncStatus status) {
//                    if (status == LoginSyncStatus.BEGIN_SYNC) {
//                        com.linzi.xiguwen.utils.LogUtil.d(TAG, "login sync data begin");
//                    } else if (status == LoginSyncStatus.SYNC_COMPLETED) {
//                        com.linzi.xiguwen.utils.LogUtil.d(TAG, "login sync data completed");
//                    }
//                }
//            },true);
////            initUiKit();
//            NimUIKit.init(this);
//        }
    }

//    private void initUiKit() {
//
//        // 初始化
//        NimUIKit.init(this);
//    }

    // 如果返回值为 null，则全部使用默认参数。
//    private SDKOptions options() {
//        SDKOptions options = new SDKOptions();
//
//        // 如果将新消息通知提醒托管给 SDK 完成，需要添加以下配置。否则无需设置。
//        StatusBarNotificationConfig config = new StatusBarNotificationConfig();
//        config.notificationEntrance = WelcomeActivity.class; // 点击通知栏跳转到该Activity
//        config.notificationSmallIconId = R.mipmap.app_icon;
//        // 呼吸灯配置
//        config.ledARGB = Color.GREEN;
//        config.ledOnMs = 1000;
//        config.ledOffMs = 1500;
//        // 通知铃声的uri字符串
//        config.notificationSound = "android.resource://com.netease.nim.demo/raw/msg";
//        options.statusBarNotificationConfig = config;
//
//        // 配置保存图片，文件，log 等数据的目录
//        // 如果 options 中没有设置这个值，SDK 会使用下面代码示例中的位置作为 SDK 的数据目录。
//        // 该目录目前包含 log, file, image, audio, video, thumb 这6个目录。
//        // 如果第三方 APP 需要缓存清理功能， 清理这个目录下面个子目录的内容即可。
//        String sdkPath = Environment.getExternalStorageDirectory() + "/" + getPackageName() + "/nim";
//        options.sdkStorageRootPath = sdkPath;
//
//        // 配置是否需要预下载附件缩略图，默认为 true
//        options.preloadAttach = true;
//
//        // 配置附件缩略图的尺寸大小。表示向服务器请求缩略图文件的大小
//        // 该值一般应根据屏幕尺寸来确定， 默认值为 Screen.width / 2
////        options.thumbnailSize = ${Screen.width} / 2;
//
//        // 用户资料提供者, 目前主要用于提供用户资料，用于新消息通知栏中显示消息来源的头像和昵称
//        options.userInfoProvider = new UserInfoProvider() {
//            @Override
//            public UserInfo getUserInfo(String account) {
//                return null;
//            }
//
//            @Override
//            public String getDisplayNameForMessageNotifier(String s, String s1, SessionTypeEnum sessionTypeEnum) {
//                return null;
//            }
//
//            @Override
//            public Bitmap getAvatarForMessageNotifier(SessionTypeEnum sessionType, String sessionId) {
//                return null;
//            }
//
//        };
//        return options;
//    }
//
//    // 如果已经存在用户登录信息，返回LoginInfo，否则返回null即可
//    private LoginInfo loginInfo() {
//        // 从本地读取上次登录成功时保存的用户登录信息
//        String account = SPUtil.get("account", SPUtil.Type.STR).toString();
//        String token = SPUtil.get("im", SPUtil.Type.STR).toString();
//
//        if (!TextUtils.isEmpty(account) && !TextUtils.isEmpty(token)) {
////            DemoCache.setAccount(account.toLowerCase());
//            return new LoginInfo(account, token);
//        } else {
//            return null;
//        }
//    }

    private void initUIKit() {
        // 初始化
//        NimUIKit.init(this, buildUIKitOptions());

        // 设置地理位置提供者。如果需要发送地理位置消息，该参数必须提供。如果不需要，可以忽略。
//        NimUIKit.setLocationProvider(new NimDemoLocationProvider());

        // IM 会话窗口的定制初始化。
//        SessionHelper.init();

        // 聊天室聊天窗口的定制初始化。
//        ChatRoomSessionHelper.init();

        // 通讯录列表定制初始化
//        ContactHelper.init();

        // 添加自定义推送文案以及选项，请开发者在各端（Android、IOS、PC、Web）消息发送时保持一致，以免出现通知不一致的情况
//        NimUIKit.setCustomPushContentProvider(new DemoPushContentProvider());

//        NimUIKit.setOnlineStateContentProvider(new DemoOnlineStateContentProvider());
    }

//    private UIKitOptions buildUIKitOptions() {
//        UIKitOptions options = new UIKitOptions();
//        // 设置app图片/音频/日志等缓存目录
//        options.appCacheDir = NimSDKOptionConfig.getAppCacheDir(this) + "/app";
//        return options;
//    }


    private LoginInfo getLoginInfo() {
        String account = Preferences.getUserAccount();
        String token = Preferences.getUserToken();

        if (!TextUtils.isEmpty(account) && !TextUtils.isEmpty(token)) {
            DemoCache.setAccount(account.toLowerCase());
            return new LoginInfo(account, token);
        } else {
            return null;
        }
    }

    public static Context getContext() {
        return mInstance;
    }






    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
//        MultiDex.install(this);
    }
    private void initUM() {
        UMConfigure.setLogEnabled(false); // 设置开启日志,发布时请关闭日志
        UMConfigure.setProcessEvent(false);
        UMConfigure.setEncryptEnabled(false);
        UMConfigure.init(this, "60af4281dd01c71b57c785be", "umeng", UMConfigure.DEVICE_TYPE_PHONE, "");
        UMConfigure.preInit(this,"60af4281dd01c71b57c785be","umeng");
        PlatformConfig.setWeixin("wx9d4329a0f1007c7c", "853bac444f0c382040482cc69a4d12ef");
        PlatformConfig.setWXFileProvider("com.linzi.xiguwen.fileProvider");
        PlatformConfig.setQQZone("1111805433", "n9iTkhI8XNaexvKD");
        PlatformConfig.setSinaWeibo("4179100698", "944e969daa65c9047c07a6c76e5f4e96", "http://www.xiguwen520.com/");
    }

    //------------------------------------------------------------------------- 强制字体

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        if (newConfig.fontScale != 1)//非默认值
            getResources();
        super.onConfigurationChanged(newConfig);
    }

    @Override
    public Resources getResources() {
        Resources res = super.getResources();
        if (res.getConfiguration().fontScale != 1) {//非默认值
            Configuration newConfig = new Configuration();
            newConfig.setToDefaults();//设置默认
            res.updateConfiguration(newConfig, res.getDisplayMetrics());
        }
        return res;
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        int code = entity.getCode();
        if (code == EventCode.AGREE){
            init();
        }

    }

}
