package com.linzi.xiguwen.utils;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.widget.ImageView;
import com.bumptech.glide.Glide;
import com.bumptech.glide.load.MultiTransformation;
import com.bumptech.glide.load.engine.DiskCacheStrategy;
import com.bumptech.glide.load.resource.bitmap.CenterCrop;
import com.bumptech.glide.load.resource.bitmap.RoundedCorners;
import com.bumptech.glide.request.RequestOptions;
import com.bumptech.glide.request.target.SimpleTarget;
import com.bumptech.glide.request.transition.Transition;
import com.linzi.xiguwen.R;
import java.io.ByteArrayOutputStream;
import java.net.URL;

/**
 * Created by jiang on 2016/11/24.
 */

public class GlideLoad {
    /**
     * 普通图片加载
     */
    public static void GlideLoadImg(Context context, String Url, ImageView view) {
        RequestOptions requestOptions = new RequestOptions()
                .placeholder(R.mipmap.load_img)
                .error(R.mipmap.load_img_erro)
                .skipMemoryCache(false)
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .centerCrop();
        Glide.with(context)
                .load(Url)
                .apply(requestOptions)
                .thumbnail(0.2f)//先加载原图20%的缩略图
//                .placeholder(R.mipmap.icon_placeholder) //设置占位图
//                .error(R.mipmap.icon_del_img) //设置错误图片
//                .skipMemoryCache(false)//不允许内存缓存
//                .diskCacheStrategy(DiskCacheStrategy.ALL)//全部缓存到本地
//                .centerCrop()
                .into(view);

    }


    public static void GlideLoadImgVideoFirstFrame(Context context, Uri uri, ImageView view) {
        RequestOptions requestOptions = new RequestOptions()
                .placeholder(R.mipmap.load_img)
                .error(R.mipmap.load_img_erro)
                .skipMemoryCache(false)
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .centerCrop();
        Glide.with(context)
                .asBitmap() // 指定加载的结果为Bitmap，因为视频首帧是图片
                .apply(requestOptions)
                .load(uri)
                .into(view); // 将结果放入ImageView中显示

    }

    /**
     * 普通图片加载
     */
    public static void GlideLoadImg(Context context, int resId, ImageView view) {
        RequestOptions requestOptions = new RequestOptions()
                .placeholder(R.mipmap.load_img)
                .error(R.mipmap.load_img_erro)
                .skipMemoryCache(false)
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .centerCrop();
        Glide.with(context)
                .load(resId)
                .apply(requestOptions)
                .thumbnail(0.2f)//先加载原图20%的缩略图
//            .placeholder(R.mipmap.icon_placeholder) //设置占位图
//            .error(R.drawable.icon_placeholder) //设置错误图片
//                .skipMemoryCache(false)//不允许内存缓存
//                .diskCacheStrategy(DiskCacheStrategy.ALL)//全部缓存到本地
//                .centerCrop()
                .into(view);
    }

    /**
     * 普通图片加载
     */
    public static void GlideLoadImg(String Url, ImageView view) {
        RequestOptions requestOptions = new RequestOptions()
                .placeholder(R.mipmap.load_img)
                .error(R.mipmap.load_img_erro)
                .skipMemoryCache(false)
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .centerCrop();
        Glide.with(view.getContext())
                .load(Url)
                .apply(requestOptions)
                .thumbnail(0.2f)//先加载原图20%的缩略图
//                .placeholder(R.mipmap.icon_placeholder) //设置占位图
//                .error(R.mipmap.erro_load) //设置错误图片
//                .skipMemoryCache(false)//不允许内存缓存
//                .diskCacheStrategy(DiskCacheStrategy.ALL)//全部缓存到本地
//                .centerCrop()
                .into(view);
    }

    /**
     * 普通图片加载
     */
    public static void GlideLoadImg2(String Url, ImageView view) {
        RequestOptions requestOptions = new RequestOptions()
                .placeholder(R.mipmap.load_img)
                .error(R.mipmap.load_img_erro)
                .skipMemoryCache(false)
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .centerCrop();
        Glide.with(view.getContext())
                .load(Url)
                .apply(requestOptions)
                .thumbnail(0.2f)//先加载原图20%的缩略图
//                .placeholder(R.mipmap.icon_placeholder) //设置占位图
//                .error(R.mipmap.load_img_erro) //设置错误图片
//                .skipMemoryCache(false)//不允许内存缓存
//                .diskCacheStrategy(DiskCacheStrategy.ALL)//全部缓存到本地
//                .centerCrop()
                .into(view);
    }

    /**
     * 长方形图片加载
     */
    public static void GlideLoadImgRectangleNoCenterCrop(String Url, final ImageView view) {
        RequestOptions requestOptions = new RequestOptions()
                .placeholder(R.mipmap.load_img)
                .error(R.mipmap.load_img_erro)
                .skipMemoryCache(false)//不允许内存缓存
                .override(1024,1024)
                .diskCacheStrategy(DiskCacheStrategy.ALL);//全部缓存到本地
        Glide.with(view.getContext())
                .load(Url)
                .apply(requestOptions)
                .thumbnail(0)
//                .listener(new RequestListener<Drawable>() {
//                    @Override
//                    public boolean onLoadFailed(@Nullable GlideException e, Object model, Target<Drawable> target, boolean isFirstResource) {
//                        return false;
//                    }
//
//                    @Override
//                    public boolean onResourceReady(Drawable resource, Object model, Target<Drawable> target, DataSource dataSource, boolean isFirstResource) {
//                        if (view == null) {
//                            return false;
//                        }
//                        if (view.getScaleType() != ImageView.ScaleType.FIT_XY) {
//                            view.setScaleType(ImageView.ScaleType.FIT_XY);
//                        }
//                        ViewGroup.LayoutParams params = view.getLayoutParams();
//                        int vw = view.getWidth() - view.getPaddingLeft() - view.getPaddingRight();
//                        float scale = (float) vw / (float) resource.getIntrinsicWidth();
//                        int vh = Math.round(resource.getIntrinsicHeight() * scale);
//                        params.height = vh + view.getPaddingTop() + view.getPaddingBottom();
//                        view.setLayoutParams(params);
//                        return false;
//                    }
//                })
                .into(new SimpleTarget<Drawable>() {
                    @Override
                    public void onResourceReady(Drawable resource, Transition<? super Drawable> transition) {
                        view.setImageDrawable(resource);
                    }
                });

    }

    /**
     * 普通图片加载
     */
    public static void GlideLoadImgNoCenter(String Url, ImageView view) {
        RequestOptions requestOptions = new RequestOptions()
                .placeholder(R.mipmap.load_img)
                .error(R.mipmap.load_img_erro)
                .skipMemoryCache(false)
                .diskCacheStrategy(DiskCacheStrategy.ALL);
        Glide.with(view.getContext())
                .load(Url)
                .apply(requestOptions)
//                .placeholder(R.mipmap.icon_placeholder) //设置占位图
//                .error(R.mipmap.load_img_erro) //设置错误图片
//                .skipMemoryCache(false)//不允许内存缓存
//                .diskCacheStrategy(DiskCacheStrategy.ALL)//全部缓存到本地
//                .centerCrop()
                .into(view);
    }

    /**
     * 普通图片加载
     */
    public static void GlideLoadImg2(Context context,String Url, ImageView view) {
        RequestOptions requestOptions = new RequestOptions()
                .placeholder(R.mipmap.load_img)
                .error(R.mipmap.load_img_erro)
                .skipMemoryCache(false)
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .centerCrop();
        Glide.with(context)
                .load(Url)
                .apply(requestOptions)
                .thumbnail(0.2f)//先加载原图20%的缩略图
//                .placeholder(R.mipmap.icon_placeholder) //设置占位图
//                .error(R.mipmap.load_img_erro) //设置错误图片
//                .skipMemoryCache(false)//不允许内存缓存
//                .diskCacheStrategy(DiskCacheStrategy.ALL)//全部缓存到本地
//                .centerCrop()
                .into(view);
    }

    /**
     * 圆角矩形图片加载
     */
    public static void GlideLoadRoundedImg(String url, ImageView view, int radiusDp) {
        int radiusPx = AppUtil.dip2px(view.getContext(), radiusDp);
        RequestOptions requestOptions = new RequestOptions()
                .placeholder(R.mipmap.icon_placeholder)
                .error(R.mipmap.icon_placeholder)
                .fallback(R.mipmap.icon_placeholder)
                .skipMemoryCache(false)
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .transform(new MultiTransformation<>(new CenterCrop(), new RoundedCorners(radiusPx)));
        Glide.with(view.getContext())
                .load(url)
                .apply(requestOptions)
                .thumbnail(0.2f)
                .into(view);
    }

    /**
     * 圆形图片加载
     */
    public static void GlideLoadCircle(final Context context, String url, ImageView view) {
        RequestOptions requestOptions = new RequestOptions()
                .placeholder(R.drawable.circle_placeholder_bg)
                .error(R.drawable.circle_placeholder_bg)
                .skipMemoryCache(false)
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .circleCrop();
        Glide.with(context).load(url).apply(requestOptions).into(view);
//        Glide.with(context).load(url)
//                .asBitmap()
//                .centerCrop()
//                .placeholder(R.mipmap.icon_placeholder) //设置占位图
//                .error(R.mipmap.icon_del_img) //设置错误图片
//                .into(new BitmapImageViewTarget(view) {
//                    @Override
//                    protected void setResource(Bitmap resource) {
//                        RoundedBitmapDrawable circularBitmapDrawable =
//                                RoundedBitmapDrawableFactory.create(context.getResources(), resource);
//                        circularBitmapDrawable.setCircular(true);
//                        view.setImageDrawable(circularBitmapDrawable);
//                    }
//                });
    }

    /**
     * 圆形图片加载
     */
    public static void GlideLoadCircle(String url, ImageView view) {
        GlideLoad.GlideLoadCircle(view.getContext(), url, view);
    }

    /**
     * 圆形图片加载
     */
    public static void GlideLoadCircle(final Context context, int uri, ImageView view) {
        RequestOptions requestOptions = new RequestOptions()
                .placeholder(R.drawable.circle_placeholder_bg)
                .error(R.drawable.circle_placeholder_bg)
                .skipMemoryCache(false)
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .circleCrop();
        Glide.with(context).load(uri).apply(requestOptions).into(view);
//        Glide.with(context).load(uri)
//                .asBitmap()
//                .centerCrop()
//                .placeholder(R.mipmap.icon_placeholder) //设置占位图
//                .error(R.mipmap.icon_del_img) //设置错误图片
//                .into(new BitmapImageViewTarget(view) {
//                    @Override
//                    protected void setResource(Bitmap resource) {
//                        RoundedBitmapDrawable circularBitmapDrawable =
//                                RoundedBitmapDrawableFactory.create(context.getResources(), resource);
//                        circularBitmapDrawable.setCircular(true);
//                        view.setImageDrawable(circularBitmapDrawable);
//                    }
//                });
    }

    /**
     * 圆形图片加载 bitmap
     */
    public static void GlideLoadCircleByBitmap(final Context context, Bitmap bitmap, ImageView view) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.PNG,100,byteArrayOutputStream);
        byte[] bytes = byteArrayOutputStream.toByteArray();
        RequestOptions requestOptions = new RequestOptions()
                .placeholder(R.drawable.circle_placeholder_bg)
                .error(R.drawable.circle_placeholder_bg)
                .skipMemoryCache(false)
                .diskCacheStrategy(DiskCacheStrategy.ALL)
                .circleCrop();
        Glide.with(context).load(bytes).apply(requestOptions).into(view);
//        Glide.with(context).load(uri)
//                .asBitmap()
//                .centerCrop()
//                .placeholder(R.mipmap.icon_placeholder) //设置占位图
//                .error(R.mipmap.icon_del_img) //设置错误图片
//                .into(new BitmapImageViewTarget(view) {
//                    @Override
//                    protected void setResource(Bitmap resource) {
//                        RoundedBitmapDrawable circularBitmapDrawable =
//                                RoundedBitmapDrawableFactory.create(context.getResources(), resource);
//                        circularBitmapDrawable.setCircular(true);
//                        view.setImageDrawable(circularBitmapDrawable);
//                    }
//                });
    }


}
