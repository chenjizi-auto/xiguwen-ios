package com.linzi.xiguwen.utils;

import android.Manifest;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;

import androidx.annotation.Nullable;
import androidx.core.content.ContextCompat;

import com.luck.picture.lib.utils.ToastUtils;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * @param
 */
public  class ImageSaveUtil {

    /**
     * 保存图片到公共目录
     * 29 以下，需要提前申请文件读写权限
     * 29及29以上的，不需要权限
     * 保存的文件在 DCIM 目录下
     *
     * @param context 上下文
     * @param bitmap  需要保存的bitmap
     * @param format  图片格式
     * @param quality 压缩的图片质量
     * @param recycle 完成以后，是否回收Bitmap，建议为true
     * @return 文件的 uri
     */
    @Nullable
    public static Uri saveAlbum(Context context, Bitmap bitmap, Bitmap.CompressFormat format, int quality, boolean recycle) {
        String suffix;
        if (Bitmap.CompressFormat.JPEG == format)
            suffix = "JPG";
        else
            suffix = format.name();
        String fileName = System.currentTimeMillis() + "_" + quality + "." + suffix;

            if (!isGranted(context)) {
                com.linzi.xiguwen.utils.LogUtil.e("ImageUtils", "save to album need storage permission");
                return null;
            }
            File picDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM);
            File destFile = new File(picDir, fileName);
            if (!save(bitmap, destFile, format, quality, recycle))
                return null;
            Uri uri = null;
            if (destFile.exists()) {
                uri = Uri.parse("file://" + destFile.getAbsolutePath());
                Intent intent = new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE);
                intent.setData(uri);
                ToastUtils.showToast(context,"保存成功");
                context.sendBroadcast(intent);
            }
            return uri;

    }

    private static boolean save(Bitmap bitmap, File file, Bitmap.CompressFormat format, int quality, boolean recycle) {
        if (isEmptyBitmap(bitmap)) {
            com.linzi.xiguwen.utils.LogUtil.e("ImageUtils", "bitmap is empty.");
            return false;
        }
        if (bitmap.isRecycled()) {
            com.linzi.xiguwen.utils.LogUtil.e("ImageUtils", "bitmap is recycled.");
            return false;
        }
        if (!createFile(file, true)) {
            com.linzi.xiguwen.utils.LogUtil.e("ImageUtils", "create or delete file <$file> failed.");
            return false;
        }
        OutputStream os = null;
        boolean ret = false;
        try {
            os = new BufferedOutputStream(new FileOutputStream(file));
            ret = bitmap.compress(format, quality, os);
            if (recycle && !bitmap.isRecycled()) bitmap.recycle();
        } catch (IOException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        } finally {
            try {
                if (os != null)
                    os.close();
            } catch (IOException e) {
                // ignore
            }
        }
        return ret;
    }

    private static boolean isEmptyBitmap(Bitmap bitmap) {
        return bitmap == null || bitmap.isRecycled() || bitmap.getWidth() == 0 || bitmap.getHeight() == 0;
    }

    private static boolean createFile(File file, boolean isDeleteOldFile) {
        if (file == null) return false;
        if (file.exists()) {
            if (isDeleteOldFile) {
                if (!file.delete()) return false;
            } else
                return file.isFile();
        }
        if (!createDir(file.getParentFile())) return false;
        try {
            return file.createNewFile();
        } catch (IOException e) {
            return false;
        }
    }

    private static boolean createDir(File file) {
        if (file == null) return false;
        if (file.exists())
            return file.isDirectory();
        else
            return file.mkdirs();
    }

    private static boolean isGranted(Context context) {
        return (Build.VERSION.SDK_INT < Build.VERSION_CODES.M || PackageManager.PERMISSION_GRANTED == ContextCompat.checkSelfPermission(context, Manifest.permission.MANAGE_EXTERNAL_STORAGE));
    }


}
