package com.linzi.xiguwen.ui;

import android.Manifest;
import android.app.DownloadManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.database.Cursor;
import android.os.Build;
import android.os.Bundle;
import androidx.fragment.app.Fragment;
import androidx.appcompat.app.AppCompatActivity;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.alibaba.fastjson.JSON;
import com.linzi.xiguwen.MainIndexFragment;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.PagerAdapter;
import com.linzi.xiguwen.bean.ClassificationBean;
import com.linzi.xiguwen.bean.MessageEntity;
import com.linzi.xiguwen.bean.UpdateBean;
import com.linzi.xiguwen.fragment.ChatListFragment;
import com.linzi.xiguwen.fragment.FindFragment;
import com.linzi.xiguwen.fragment.MineFragment;
import com.linzi.xiguwen.fragment.cart.NewCartFragment;
import com.linzi.xiguwen.fragment.discover.DiscoverDetailActivity;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.update.ApkDownLoad;
import com.linzi.xiguwen.update.PreferencesUtils;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.yixin.helper.SystemMessageUnreadManager;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.utils.yixin.reminder.ReminderItem;
import com.linzi.xiguwen.utils.yixin.reminder.ReminderManager;
import com.linzi.xiguwen.view.DownLoadDialog;
import com.linzi.xiguwen.view.MyViewPager;
import com.linzi.xiguwen.view.UpdateDialog;
import com.netease.nimlib.sdk.NIMClient;
import com.netease.nimlib.sdk.NimIntent;
import com.netease.nimlib.sdk.msg.MsgService;
import com.netease.nimlib.sdk.msg.model.IMMessage;
import com.yanzhenjie.permission.AndPermission;
import com.yanzhenjie.permission.PermissionListener;

import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class MainActivity extends AppCompatActivity implements ReminderManager.UnreadNumChangedCallback {

    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.pager)
    MyViewPager pager;
    @BindView(R.id.rb_index)
    RadioButton rbIndex;
    @BindView(R.id.rb_find)
    RadioButton rbFind;
    @BindView(R.id.rb_msg)
    RadioButton rbMsg;
    @BindView(R.id.rl_msg_container)
    RelativeLayout rlMsgContainer;
    @BindView(R.id.rb_cart)
    RadioButton rbCart;
    @BindView(R.id.rb_mine)
    RadioButton rbMine;

    @BindView(R.id.main_message_count)
    TextView txCount;

    private List<Fragment> mFragmentList;

    Context mContext;

    public static String JPUSH_MESSAGE = "jpush_message";
    public static String WY_MY_MESSAGE = "wy_my_message";

    private String downloadUrl = null;
    private Timer myTimer;

    private int selectIndex;

    public static void start(Context context, Intent extras) {
        Intent intent = new Intent();
        intent.setClass(context, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);
        if (extras != null) {
            intent.putExtras(extras);
        }
        context.startActivity(intent);
    }

    private void onParseIntent() {
        Intent intent = getIntent();
        if (intent.hasExtra(NimIntent.EXTRA_NOTIFY_CONTENT)) {
            ArrayList<IMMessage> messages = (ArrayList<IMMessage>) intent.getSerializableExtra(NimIntent.EXTRA_NOTIFY_CONTENT);
            IMMessage message = messages.get(0);
            switch (message.getSessionType()) {
                case P2P:
//                    NimUIKit.startP2PSession(this, message.getSessionId());
                    break;
                case Team:
//                    SessionHelper.startTeamSession(this, message.getSessionId());
                    break;
                default:
                    break;
            }
        } else if (intent.hasExtra(JPUSH_MESSAGE)) {//极光推送消息点击通知栏处理
            try {
                String data = intent.getStringExtra(JPUSH_MESSAGE);
                MessageEntity entity = JSON.parseObject(data, MessageEntity.class);
                if (entity.getType() != 3) {
                    Intent intent1 = new Intent(MainActivity.this, NewOrderDetailsActivity.class);
                    if (entity.getType() == 1) {
                        //婚庆
                        if (entity.getStyle() == 1) {
                            //婚庆用户
                            intent1.putExtra("intentType", 0);
                            intent1.putExtra("order_id", Integer.parseInt(entity.getId()));
                        } else if (entity.getStyle() == 2) {
                            //婚庆接单
                            intent1.putExtra("intentType", 2);
                            intent1.putExtra("order_id", Integer.parseInt(entity.getId()));
                        } else {
                            //商城接单
                            intent1.putExtra("intentType", 3);
                            intent1.putExtra("order_id", Integer.parseInt(entity.getId()));
                        }
                    } else {
                        //商城
                        if (entity.getStyle() == 1) {
                            //商城用户
                            intent1.putExtra("intentType", 1);
                            intent1.putExtra("order_id", Integer.parseInt(entity.getId()));
                        } else if (entity.getStyle() == 2) {
                            //婚庆接单
                            intent1.putExtra("intentType", 2);
                            intent1.putExtra("order_id", Integer.parseInt(entity.getId()));
                        } else {
                            //商城接单
                            intent1.putExtra("intentType", 3);
                            intent1.putExtra("order_id", Integer.parseInt(entity.getId()));
                        }
                    }
                    startActivity(intent1);
                } else {
                    WenzhangDetailsActivity.startAction(this, entity.getUrl(), entity.getTitle() + "", true);
                }
            } catch (Exception e) {

            }

        } else if (intent.hasExtra(WY_MY_MESSAGE)) {//网易自定义消息点击通知栏处理  注意跳转之后通过id判断移除缓存中的未读条目数
            try {
                String data = intent.getStringExtra(WY_MY_MESSAGE);
                MessageEntity entity = JSON.parseObject(data, MessageEntity.class);
//                WenzhangDetailsActivity.startAction(this, entity.getUrl(), entity.getTitle() + "", true);

                if (entity.getType() == 1) {//跳转到交易详情
                    Intent intent1 = new Intent(this, NewOrderDetailsActivity.class);
                    intent1.putExtra("order_id", Integer.parseInt(entity.getSid() + ""));
                    intent1.putExtra("intentType", entity.getShifoujiedan());
                    if (entity.getStatus() == 100) {
                        intent.putExtra("status", entity.getStatus());
                    }
                    intent1.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
                    startActivity(intent1);
                } else if (entity.getType() == 2) {//跳转到通知详情
                    DiscoverDetailActivity.startAction(this, Integer.parseInt(entity.getSid()), 0);
                }
            } catch (Exception e) {

            }

        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(MainActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(MainActivity.this, R.color.white);
        }

        setContentView(R.layout.activity_main2);
        ButterKnife.bind(this);
        mContext = this;
        initViews();
//        getPermission();

        initMainData();
        onParseIntent();
        checkVersion();


    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        onParseIntent();
    }


    private void initMainData() {
        String data = Preferences.getString(Preferences.PROFESSIONAL);
        if (AppUtil.isEmpty(data)) {
            getClassification();
        }
    }

    /**
     * 初始化视图控件
     */
    private void initViews() {
//        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(MainActivity.this));
//        llBar.setLayoutParams(params);
        if (!Constans.SHOW_MESSAGE_ENTRY) {
            rlMsgContainer.setVisibility(View.GONE);
            txCount.setVisibility(View.GONE);
        }
        pager.setScanScroll(false);
        pager.setAdapter(new PagerAdapter(this.getSupportFragmentManager(), getFragment()));
        pager.setCurrentItem(0, false);
//        getPermission();
        registerMsgUnreadInfoObserver(true);
       // if (LoginUtil.isLogin()) {
            requestSystemMessageUnreadCount();
     //   }

//        registerSystemMessageObservers(true);
    }

    /**
     * 获取系统权限
     */
    private void getPermission() {
        AndPermission.with(this)
                .requestCode(102)
                .permission(
                        Manifest.permission.ACCESS_COARSE_LOCATION
// 定位相关权限
                        , Manifest.permission.ACCESS_FINE_LOCATION
                       , Manifest.permission.READ_PHONE_STATE//定位相关权限
                       ,Manifest.permission.ACCESS_WIFI_STATE//定位相关权限
                       , Manifest.permission.ACCESS_NETWORK_STATE//定位相关权限
                         ,Manifest.permission.MANAGE_EXTERNAL_STORAGE//定位相关权限
//                        , Manifest.permission.CAMERA//相机权限
//                        , Manifest.permission.READ_CONTACTS
//                        , Manifest.permission.WRITE_CONTACTS
//                        , Manifest.permission.WRITE_CALENDAR
//                        , Manifest.permission.READ_CALENDAR
//                        , Manifest.permission.RECORD_AUDIO
                )
                .callback(permissionlistener)
                .start();
    }

    /**
     * 权限申请回调的监听
     */
    private PermissionListener permissionlistener = new PermissionListener() {
        @Override
        public void onSucceed(int requestCode, List<String> grantedPermissions) {
            // 权限申请成功回调。
            if (requestCode == 102) {
                // TODO 相应代码。
            } else if (requestCode == 101) {
                // TODO 相应代码。
            }
        }

        @Override
        public void onFailed(int requestCode, List<String> deniedPermissions) {
            // 权限申请失败回调。

            // 用户否勾选了不再提示并且拒绝了权限，那么提示用户到设置中授权。
            if (AndPermission.hasAlwaysDeniedPermission(mContext, deniedPermissions)) {
                // 第一种：用默认的提示语。
//                AndPermission.defaultSettingDialog(this, REQUEST_CODE_SETTING).show();

                //第二种：用自定义的提示语。
                AndPermission.defaultSettingDialog(MainActivity.this, 102)
                        .setTitle("权限申请失败")
                        .setMessage("我们需要的一些权限被您拒绝或者系统发生错误申请失败，请您到设置页面手动授权，否则功能无法正常使用！")
                        .setPositiveButton("好，去设置")
                        .show();
            }
        }
    };

    /**
     * 初始化侧滑控件
     *
     * @return
     */
    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }
        mFragmentList.add(new MainIndexFragment());
        mFragmentList.add(new FindFragment());
        if (Constans.SHOW_MESSAGE_ENTRY) {
            mFragmentList.add(new ChatListFragment());
        }
        mFragmentList.add(new NewCartFragment());
        mFragmentList.add(new MineFragment());
        return mFragmentList;
    }

    /**
     * 继承自butterknife的点击事件
     *
     * @param view
     */
    @OnClick({R.id.rb_index, R.id.rb_find, R.id.rb_msg, R.id.rb_cart, R.id.rb_mine})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.rb_index:
                pager.setCurrentItem(0, false);//首页事件
                selectIndex = 0;
                if (mFragmentList != null) {
                    ((MainIndexFragment) mFragmentList.get(0)).isOnLine();
                }
                break;
            case R.id.rb_find:
                pager.setCurrentItem(1, false);//发现
                selectIndex = 1;
                break;
            case R.id.rb_msg:
                if (!Constans.SHOW_MESSAGE_ENTRY) {
                    return;
                }
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(mContext);
                    return;
                }
                pager.setCurrentItem(2, false);//消息
                selectIndex = 2;
                break;
            case R.id.rb_cart:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(mContext);
                    return;
                }
                pager.setCurrentItem(getCartPageIndex(), false);//购物车
                selectIndex = getCartPageIndex();
                break;
            case R.id.rb_mine:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(mContext);
                    return;
                }
                pager.setCurrentItem(getMinePageIndex(), false);//我的
                selectIndex = getMinePageIndex();
                break;
        }
    }

    /**
     * 注册未读消息数量观察者
     */
    private void registerMsgUnreadInfoObserver(boolean register) {
        if (register) {
            ReminderManager.getInstance().registerUnreadNumChangedCallback(this);
        } else {
            ReminderManager.getInstance().unregisterUnreadNumChangedCallback(this);
        }
    }

    @Override
    public void onUnreadNumChanged(ReminderItem item) {
        if (!Constans.SHOW_MESSAGE_ENTRY) {
            txCount.setVisibility(View.GONE);
            return;
        }
        int count = item.getUnread();
        com.linzi.xiguwen.utils.LogUtil.e("====1==main===", "======onUnreadNumChanged==========" + count);
        if (count > 0) {
            txCount.setVisibility(View.VISIBLE);
            txCount.setText(count + "");
        } else {
            txCount.setVisibility(View.GONE);
        }
    }

//    /**
//     * 注册/注销系统消息未读数变化
//     *
//     * @param register
//     */
//    private void registerSystemMessageObservers(boolean register) {
//        NIMClient.getService(SystemMessageObserver.class).observeUnreadCountChange(sysMsgUnreadCountChangedObserver,
//                register);
//    }
//
//    private Observer<Integer> sysMsgUnreadCountChangedObserver = new Observer<Integer>() {
//        @Override
//        public void onEvent(Integer unreadCount) {
//            com.linzi.xiguwen.utils.LogUtil.e("====2=====", "======onEvent==========");
//            SystemMessageUnreadManager.getInstance().setSysMsgUnreadCount(unreadCount);
//            ReminderManager.getInstance().updateContactUnreadNum(unreadCount);
//        }
//    };

    /**
     * 查询系统消息未读数
     */
    private void requestSystemMessageUnreadCount() {
//        int unread = NIMClient.getService(SystemMessageService.class).querySystemMessageUnreadCountBlock();
//        int unread = NIMClient.getService(MsgService.class).getTotalUnreadCount();
//        SystemMessageUnreadManager.getInstance().setSysMsgUnreadCount(unread);
//        ReminderManager.getInstance().updateContactUnreadNum(unread);
    }

    private int getCartPageIndex() {
        return Constans.SHOW_MESSAGE_ENTRY ? 3 : 2;
    }

    private int getMinePageIndex() {
        return Constans.SHOW_MESSAGE_ENTRY ? 4 : 3;
    }

    @Override
    public void onPointerCaptureChanged(boolean hasCapture) {

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        registerMsgUnreadInfoObserver(false);
//        registerSystemMessageObservers(false);
        if (null != myTimer) {
            myTimer.cancel();
            myTimer = null;
        }
    }


    //初始化职业列表
    private void getClassification() {
        ApiManager.getClassification(new OnRequestSubscribe<BaseBean<ArrayList<ClassificationBean>>>() {
            @Override
            public void onSuccess(BaseBean<ArrayList<ClassificationBean>> data) {

                List<ClassificationBean> beans = data.getData();
                ClassificationBean allBean = new ClassificationBean();
                allBean.setOccupationid(0);
                allBean.setProname("全部");
                beans.add(0, allBean);
                Preferences.saveString(Preferences.PROFESSIONAL, JSON.toJSONString(beans));

            }

            @Override
            public void onError(Exception ex) {
            }
        });
    }


    /**
     * 更新进度条
     *
     * @param
     */
    private void updateViews(final long downlaodId) {
        myTimer = new Timer();
        myTimer.schedule(new TimerTask() {
            @Override
            public void run() {
                DownloadManager.Query q = new DownloadManager.Query();
                q.setFilterById(downlaodId);
                Cursor cursor = ((DownloadManager) mContext.getSystemService(Context.DOWNLOAD_SERVICE)).query(q);
                cursor.moveToFirst();
                int bytes_downloaded = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_BYTES_DOWNLOADED_SO_FAR));
                int bytes_total = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_TOTAL_SIZE_BYTES));
                cursor.close();
                final int dl_progress = (bytes_downloaded * 100 / bytes_total);
                if (dl_progress == 100) {
                    myTimer.cancel();
                    MainActivity.this.runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
//                            if (null != progressBar && null != versionname) {
//                                progressBar.setProgress(dl_progress);
//                                versionname.setText("下载完成");
//                            }
                            DownLoadDialog.CancelDialog();
                            dialog.dismiss();
                        }
                    });
                } else {
                    MainActivity.this.runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
//                            if (null != progressBar && null != versionname) {
//                                progressBar.setProgress(dl_progress);
//                                versionname.setText(dl_progress + "%");
//                            }
                        }
                    });
                }
            }
        }, 0, 10);
    }

    /**
     * 获取app VersionCode
     *
     * @param context
     * @return
     */
    public static int getVersionCode(Context context) {
        try {
            PackageInfo pi = context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
            return pi.versionCode;
        } catch (Exception e) {
            NToast.log("APPTAG", "获取versionCode异常:" + e.toString());
            return 0;
        }
    }

    private String downloadurl;
    private UpdateDialog dialog;

    //检测更新
    private void checkVersion() {
        ApiManager.checkVersion(getVersionCode(mContext), new OnRequestFinish<BaseBean<UpdateBean>>() {
            @Override
            public void onFinished() {

            }

            @Override
            public void onSuccess(BaseBean<UpdateBean> data) {
                downloadurl = data.getData().getAurl();
                if (data.getData().getForcedupdate() == 1) {//强制更新
                    dialog = new UpdateDialog(mContext, MainActivity.this);
                    dialog.setTitle(data.getData().getVersionname() + " 更新内容：");
                    dialog.setMessage(data.getData().getMessage());
                    dialog.setSignButton("更新", new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            if (downloadurl != null) {
                                ApkDownLoad apkDownLoad = new ApkDownLoad(mContext, downloadurl, "喜顾问", "新版本正在飞速向你靠近~");
                                DownLoadDialog.showDialog(mContext, "全速下载中...");
                                NToast.show("新版本正在下载中...");
                                apkDownLoad.execute();
                                updateViews(PreferencesUtils.getLong(mContext, ApkDownLoad.APK_DOWNLOAD_ID));
                            }
                        }
                    });
                    dialog.show();
                } else {
                    dialog = new UpdateDialog(mContext, MainActivity.this);
                    dialog.setTitle(data.getData().getVersionname() + " 更新内容：");
                    dialog.setMessage(data.getData().getMessage());
                    dialog.setSubmitListener("更新", new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            if (downloadurl != null) {
                                ApkDownLoad apkDownLoad = new ApkDownLoad(mContext, downloadurl, "喜顾问", "新版本正在飞速向你靠近~");
                                apkDownLoad.execute();
                            }
                            NToast.show("新版本正在下载中...");
                            dialog.dismiss();
                        }
                    });
                    dialog.setCancleListener("取消", new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            dialog.dismiss();
                        }
                    });
                    dialog.show();
                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

}
