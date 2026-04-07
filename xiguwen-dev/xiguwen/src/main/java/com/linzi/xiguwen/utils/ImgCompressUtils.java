package com.linzi.xiguwen.utils;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.util.Base64;

import org.xutils.common.util.LogUtil;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * Created by PC on 2018-04-13.
 * 图片压缩工具
 */

public class ImgCompressUtils {
    public static String getBase64Str(String path){
        ByteArrayOutputStream outputStream = sizeCompress(path);
        return new String(Base64.encode(outputStream.toByteArray(),Base64.NO_WRAP));
    }

    public static String getMimeTypeHead(String file){
        String cache = file.toLowerCase();
        if(cache.endsWith("jpg") || cache.endsWith("jpeg")){
            return "data:image/jpg;base64,";
        }else if(cache.endsWith("png")){
            return "data:image/png;base64,";
        }else if(cache.endsWith("gif")){
            return "data:image/gif;base64,";
        }else if(cache.endsWith("bmp")){
            return "data:image/bmp;base64,";
        }
        return "data:image/jpg;base64,";
    }

    public static String getBase64StrWithHead(String path){
        return getMimeTypeHead(path) + getBase64Str(path);
    }

    /**
     * 4.尺寸压缩（通过缩放图片像素来减少图片占用内存大小）
     *
     * @param bmp
     * @param file
     */

    public static ByteArrayOutputStream sizeCompress(String path) {
        com.linzi.xiguwen.utils.LogUtil.e("sizeCompress","sizeCompress path is  "+path );
        if(path == null){
            return null;
        }
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        Bitmap bmp = BitmapFactory.decodeFile(path, options); // 此时返回的bitmap为null

        // 尺寸压缩倍数,值越大，图片尺寸越小
        // 设置宽高最大为1024像素
        int sample = 1400;
        int outHeight = options.outHeight;
        int outWidth = options.outWidth;
        int wSimple = outWidth / sample;
        int hSimple = outHeight / sample;
        options.inJustDecodeBounds = false;
        int cache = Math.max(wSimple, hSimple);
        if(cache > 1){
            options.inSampleSize = cache;
        }
        bmp = BitmapFactory.decodeFile(path, options);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        bmp.compress(Bitmap.CompressFormat.JPEG, 100, baos);
        return baos;
    }
}
