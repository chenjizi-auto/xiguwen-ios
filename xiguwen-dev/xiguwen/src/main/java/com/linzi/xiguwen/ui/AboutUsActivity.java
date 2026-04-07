package com.linzi.xiguwen.ui;

import android.app.DownloadManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.UpdateBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.update.ApkDownLoad;
import com.linzi.xiguwen.update.PreferencesUtils;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.DownLoadDialog;
import com.linzi.xiguwen.view.UpdateDialog;

import java.util.Timer;
import java.util.TimerTask;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

import static com.linzi.xiguwen.ui.MainActivity.getVersionCode;

public class AboutUsActivity extends BaseActivity {

    @BindView(R.id.tv_version)
    TextView tvVersion;
    @BindView(R.id.ll_user_arhument)
    LinearLayout llUserArhument;
    @BindView(R.id.ll_yinsi)
    LinearLayout llYinsi;
    @BindView(R.id.ll_phone)
    LinearLayout llPhone;
    @BindView(R.id.tv_phone)
    TextView tvPhone;
    @BindView(R.id.ll_checkVersion)
    LinearLayout llCheckVersion;

    private Timer myTimer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_about_us);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("关于我们");
        setBack();
        tvPhone.setText("13880700685");

        tvVersion.setText("V " + getVersionName(this));


    }

    @OnClick({R.id.ll_user_arhument, R.id.ll_yinsi, R.id.ll_phone, R.id.ll_checkVersion})
    public void onClick(View view) {
        Intent intent;
        switch (view.getId()) {
            case R.id.ll_user_arhument:
//                intent = new Intent(this, UserArgumentActivity.class);
//                startActivity(intent);
                WenzhangDetailsActivity.startAction(mContext, "http://www.xiguwen520.com/wap/news/userprotocol.html", "用户协议", false);
                break;
            case R.id.ll_yinsi:
                WenzhangDetailsActivity.startAction(mContext, "http://www.xiguwen520.com/wap/news/privacy.html", "隐私协议", false);
                break;
            case R.id.ll_phone:
                callUser(tvPhone.getText().toString());
                break;
            case R.id.ll_checkVersion:
                checkVersion();
                break;
        }
    }

    public String getVersionName(Context context) {
        PackageManager packageManager = context.getPackageManager();
        PackageInfo packageInfo;
        String versionName = "";
        try {
            packageInfo = packageManager.getPackageInfo(context.getPackageName(), 0);
            versionName = packageInfo.versionName;
        } catch (PackageManager.NameNotFoundException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
        return versionName;
    }

    //联系
    private void callUser(String phoneNum) {
        if (phoneNum != null) {
            Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + phoneNum));
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
        } else {
            NToast.show("抱歉，暂时没有该商家的联系方式！");
        }
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
                    dialog = new UpdateDialog(mContext, AboutUsActivity.this);
                    dialog.setTitle(data.getData().getVersionname() + " 更新内容：");
                    dialog.setMessage(data.getData().getMessage());
                    dialog.setSignButton("更新", new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            if (downloadurl != null) {
                                llCheckVersion.setClickable(false);
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
                    dialog = new UpdateDialog(mContext, AboutUsActivity.this);
                    dialog.setTitle(data.getData().getVersionname() + " 更新内容：");
                    dialog.setMessage(data.getData().getMessage());
                    dialog.setSubmitListener("更新", new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            if (downloadurl != null) {
                                llCheckVersion.setClickable(false);
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
                NToast.show(ex.getMessage());
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
                    AboutUsActivity.this.runOnUiThread(new Runnable() {
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
                    AboutUsActivity.this.runOnUiThread(new Runnable() {
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

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (null != myTimer) {
            myTimer.cancel();
            myTimer = null;
        }
    }
}
