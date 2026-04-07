package com.linzi.xiguwen.update;

import android.app.DownloadManager;
import android.app.DownloadManager.Request;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import androidx.core.content.FileProvider;
import android.webkit.MimeTypeMap;

import com.linzi.xiguwen.utils.NToast;

import java.io.File;


public class ApkDownLoad {

    public static final String DOWNLOAD_FOLDER_NAME = "Download";
    public static final String DOWNLOAD_FILE_NAME = "xiguwen.apk";
    public static final String APK_DOWNLOAD_ID = "XiGoDownloadId";

    private Context context;
    private String url;
    private String notificationTitle;
    private String notificationDescription;

    private DownloadManager downloadManager;
    private CompleteReceiver completeReceiver;
    public static File folder;

    /**
     * @param context
     * @param url                     下载apk的url
     * @param notificationTitle       通知栏标题
     * @param notificationDescription 通知栏描述
     */
    @SuppressWarnings("static-access")
    public ApkDownLoad(Context context, String url, String notificationTitle,
                       String notificationDescription) {
        super();
        this.context = context;
        this.url = url;
        this.notificationTitle = notificationTitle;
        this.notificationDescription = notificationDescription;

        downloadManager = (DownloadManager) context.getSystemService(context.DOWNLOAD_SERVICE);
        completeReceiver = new CompleteReceiver();

        /** register download success broadcast **/
        registerDownloadReceiver();
    }

    private void registerDownloadReceiver() {
        IntentFilter filter = new IntentFilter(DownloadManager.ACTION_DOWNLOAD_COMPLETE);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            context.registerReceiver(completeReceiver, filter, Context.RECEIVER_EXPORTED);
        } else {
            context.registerReceiver(completeReceiver, filter);
        }
    }

    private boolean deleteFile(String filePath) {
        File file = new File(filePath);
        if (file.isFile() && file.exists()) {
            return file.delete();
        }
        return false;
    }

    public boolean deleteDirectory(String filePath) {
        boolean flag = false;
        //如果filePath不以文件分隔符结尾，自动添加文件分隔符
        if (!filePath.endsWith(File.separator)) {
            filePath = filePath + File.separator;
        }
        File dirFile = new File(filePath);
        if (!dirFile.exists() || !dirFile.isDirectory()) {
            return false;
        }
        flag = true;
        File[] files = dirFile.listFiles();
        //遍历删除文件夹下的所有文件(包括子目录)
        for (int i = 0; i < files.length; i++) {
            if (files[i].isFile()) {
                //删除子文件
                flag = deleteFile(files[i].getAbsolutePath());
                if (!flag) break;
            } else {
                //删除子目录
                flag = deleteDirectory(files[i].getAbsolutePath());
                if (!flag) break;
            }
        }
        if (!flag) return false;
        //删除当前空目录
        return dirFile.delete();
    }

    public void execute() {
        boolean a = deleteDirectory(new StringBuilder(Environment.getExternalStorageDirectory().getAbsolutePath())
                .append(File.separator).append(DOWNLOAD_FOLDER_NAME).append(File.separator).toString());
        //清除已下载的内容重新下载
        long downloadId = PreferencesUtils.getLong(context, APK_DOWNLOAD_ID);
        if (downloadId != -1) {
            downloadManager.remove(downloadId);
            PreferencesUtils.removeSharedPreferenceByKey(context, APK_DOWNLOAD_ID);
        }

        Request request = new Request(Uri.parse(url));
        //设置Notification中显示的文字
        request.setTitle(notificationTitle);
        request.setDescription(notificationDescription);
        //设置可用的网络类型
        //request.setAllowedNetworkTypes(Request.NETWORK_MOBILE | Request.NETWORK_WIFI);
        //设置状态栏中显示Notification
        request.setNotificationVisibility(Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
        //不显示下载界面
        request.setVisibleInDownloadsUi(false);
        //设置下载后文件存放的位置
        folder = Environment.getExternalStoragePublicDirectory(DOWNLOAD_FOLDER_NAME);
        if (!folder.exists() || !folder.isDirectory()) {
            folder.mkdirs();
        }

        request.setDestinationInExternalPublicDir(DOWNLOAD_FOLDER_NAME, DOWNLOAD_FILE_NAME);
        //设置文件类型
        MimeTypeMap mimeTypeMap = MimeTypeMap.getSingleton();
        String mimeString = mimeTypeMap.getMimeTypeFromExtension(MimeTypeMap.getFileExtensionFromUrl(url));
        request.setMimeType(mimeString);
        //保存返回唯一的downloadId
        PreferencesUtils.putLong(context, APK_DOWNLOAD_ID, downloadManager.enqueue(request));
    }


    class CompleteReceiver extends BroadcastReceiver {

        @Override
        public void onReceive(Context context, Intent intent) {
            /**
             * get the id of download which have download success, if the id is my id and it's status is successful,
             * then install it
             **/
            long completeDownloadId = intent.getLongExtra(DownloadManager.EXTRA_DOWNLOAD_ID, 0);
            long downloadId = PreferencesUtils.getLong(context, APK_DOWNLOAD_ID);

            if (completeDownloadId == downloadId) {

                // if download successful
                if (queryDownloadStatus(downloadManager, downloadId) == DownloadManager.STATUS_SUCCESSFUL) {

                    //clear downloadId
                    PreferencesUtils.removeSharedPreferenceByKey(context, APK_DOWNLOAD_ID);

                    //unregisterReceiver
                    context.unregisterReceiver(completeReceiver);

                    //install apk

                    String apkFilePath = new StringBuilder(Environment.getExternalStorageDirectory().getAbsolutePath())
                            .append(File.separator).append(DOWNLOAD_FOLDER_NAME).append(File.separator)
                            .append(DOWNLOAD_FILE_NAME).toString();
                    install(context, apkFilePath);
                }
            }
        }
    }

    ;

    /**
     * 查询下载状态
     */
    public static int queryDownloadStatus(DownloadManager downloadManager, long downloadId) {
        int result = -1;
        DownloadManager.Query query = new DownloadManager.Query().setFilterById(downloadId);
        Cursor c = null;
        try {
            c = downloadManager.query(query);
            if (c != null && c.moveToFirst()) {
                result = c.getInt(c.getColumnIndex(DownloadManager.COLUMN_STATUS));
            }
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return result;
    }

    /**
     * install app
     *
     * @param context
     * @param filePath
     * @return whether apk exist
     */
    public static boolean install(Context context, String filePath) {

        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.N) {
            Intent i = new Intent(Intent.ACTION_VIEW);
            NToast.log("APPTAG", Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS) + "");
            File file = new File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
                    , DOWNLOAD_FILE_NAME);
            if (file != null && file.length() > 0 && file.exists() && file.isFile()) {
                Uri apkUri = FileProvider.getUriForFile(context, "com.linzi.xiguwen.fileProvider", file);
                i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                i.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                NToast.log("APPTAG", apkUri + "");
                i.setDataAndType(apkUri, "application/vnd.android.package-archive");
                context.startActivity(i);
                return true;
            }
        } else {
            Intent i = new Intent(Intent.ACTION_VIEW);
            File file = new File(filePath);
            if (file != null && file.length() > 0 && file.exists() && file.isFile()) {
                i.setDataAndType(Uri.parse("file://" + filePath), "application/vnd.android.package-archive");
                i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                context.startActivity(i);
                return true;
            }
        }

        return false;
    }

}
