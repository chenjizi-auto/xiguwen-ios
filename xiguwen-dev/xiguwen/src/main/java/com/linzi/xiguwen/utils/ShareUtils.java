package com.linzi.xiguwen.utils;

import android.app.Activity;

import com.linzi.xiguwen.R;
import com.umeng.socialize.ShareAction;
import com.umeng.socialize.UMShareListener;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.media.UMImage;
import com.umeng.socialize.media.UMWeb;

import java.io.File;

import top.zibin.luban.Luban;
import top.zibin.luban.OnCompressListener;

/**
 * Created by devin on 2018/4/19 11:33
 * Description
 */

public class ShareUtils {

    /**
     * @param context
     * @param url         分享链接
     * @param title       分享标题
     * @param imag        分享图片 网络链接图片
     * @param description 简介
     */
    public static void showShare(Activity context, String url, String title, String imag, String description) {
        UMWeb web = new UMWeb(url);
        web.setTitle(title);//标题
        UMImage thumb;
        if (imag == null) {
            thumb = new UMImage(context, R.mipmap.app_icon);
        } else {
            thumb = new UMImage(context, imag);
        }
        //thumb.compressStyle = UMImage.CompressStyle.SCALE;
        web.setThumb(thumb);  //缩略图
        web.setDescription(description);//描述
        new ShareAction(context)
                .withMedia(web).
                setDisplayList(SHARE_MEDIA.QQ, SHARE_MEDIA.QZONE, SHARE_MEDIA.WEIXIN, SHARE_MEDIA.WEIXIN_CIRCLE)
        //setDisplayList(SHARE_MEDIA.QQ, SHARE_MEDIA.QZONE, SHARE_MEDIA.WEIXIN, SHARE_MEDIA.WEIXIN_CIRCLE, SHARE_MEDIA.SINA)
                .open();
    }

    public static void showShare(Activity context, String url, String title, String imag, String description, SHARE_MEDIA share_media) {
        UMWeb web = new UMWeb(url);
        web.setTitle(title);//标题
        UMImage thumb;
        if (imag == null) {
            thumb = new UMImage(context, R.mipmap.app_icon);
        } else {
            thumb = new UMImage(context, imag);
        }
        web.setThumb(thumb);  //缩略图
        web.setDescription(description);//描述
        new ShareAction(context)
                .withMedia(web).
                setPlatform(share_media)
                .share();
    }

    public static void showShare(final Activity context, File file) {
        final UMImage image = new UMImage(context, file);
        image.compressStyle= UMImage.CompressStyle.QUALITY;
        image.isLoadImgByCompress = true;
//        image.setTitle("分享了一张档期卡图片");
//        image.setDescription("分享了一张档期卡图片");
        image.setThumb( image);
//        com.linzi.xiguwen.utils.LogUtil.e("showShare"," len "+    image.asFileImage().length());
//        image.setThumb(R.mipmap.app_icon);
//        UMImage thumb =  new UMImage(context,file);
//        image.setThumb(thumb);

        new ShareAction(context).withMedia(image)
                .setDisplayList(SHARE_MEDIA.QQ, SHARE_MEDIA.QZONE, SHARE_MEDIA.WEIXIN, SHARE_MEDIA.WEIXIN_CIRCLE, SHARE_MEDIA.SINA).
                open();

    }
}
