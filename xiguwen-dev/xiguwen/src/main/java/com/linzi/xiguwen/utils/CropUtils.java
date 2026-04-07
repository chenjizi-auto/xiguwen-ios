package com.linzi.xiguwen.utils;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Environment;
import android.provider.MediaStore;

/**
 * Created by pc on 2018/6/21.
 */

public class CropUtils {
    /**
     * 调用系统照片的裁剪功能，修改编辑头像的选择模式(适配Android7.0)
     */
    public static void invokeSystemCrop(Activity context, Uri uri, int aspectX, int aspectY, int outputX, int outputY) {
        Intent intent = new Intent("com.android.camera.action.CROP");
       /*创建一个指向需要操作文件（filename）的文件流。（可解决无法“加载问题”）*/
        intent.setDataAndType(uri, "image/*");
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        intent.addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
        // 下面这个crop = true是设置在开启的Intent中设置显示的VIEW可裁剪
        intent.putExtra("crop", "true");
        // aspectX aspectY 是宽高的比例，这里设置的是正方形（长宽比为1:1）
        intent.putExtra("aspectX", aspectX);
        intent.putExtra("aspectY", aspectY);
        // outputX outputY 是裁剪图片宽高
        intent.putExtra("outputX", outputX);
        intent.putExtra("outputY", outputY);
//        //裁剪时是否保留图片的比例，这里的比例是1:1
//        intent.putExtra("scale", true);
        //是否是圆形裁剪区域，设置了也不一定有效
//        intent.putExtra("circleCrop", true);
//        //设置输出的格式
//        intent.putExtra("outputFormat", Bitmap.CompressFormat.JPEG.toString());
        /**
         * 此方法返回的图片只能是小图片（sumsang测试为高宽160px的图片）
         * 故将图片保存在Uri中，调用时将Uri转换为Bitmap，此方法还可解决miui系统不能return data的问题
         */
        //intent.putExtra("return-data", true);

        //uritempFile为Uri类变量，实例化uritempFile
        intent.putExtra(MediaStore.EXTRA_OUTPUT, Uri.parse("file://" + "/" + Environment.getExternalStorageDirectory().getPath() + "/" + "small.jpg"));
        intent.putExtra("outputFormat", Bitmap.CompressFormat.JPEG.toString());
        context.startActivityForResult(intent, 2001);
    }
}
