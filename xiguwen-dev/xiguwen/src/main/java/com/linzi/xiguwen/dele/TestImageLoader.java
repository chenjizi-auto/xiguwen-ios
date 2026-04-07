package com.linzi.xiguwen.dele;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.drawable.Drawable;
import android.widget.ImageView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.content.ContextCompat;
import androidx.fragment.app.Fragment;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.DataSource;
import com.bumptech.glide.load.engine.DiskCacheStrategy;
import com.bumptech.glide.load.engine.GlideException;
import com.bumptech.glide.load.resource.gif.GifDrawable;
import com.bumptech.glide.request.RequestOptions;
import com.bumptech.glide.request.RequestListener;
import com.bumptech.glide.request.target.SimpleTarget;
import com.bumptech.glide.request.target.Target;
import com.bumptech.glide.request.transition.Transition;
import com.linzi.xiguwen.R;
import com.previewlibrary.loader.IZoomMediaLoader;
import com.previewlibrary.loader.MySimpleTarget;

/**
 * Created by yangc on 2017/9/4.
 * E-Mail:yangchaojiang@outlook.com
 * Deprecated:
 */

public class TestImageLoader implements IZoomMediaLoader {

    @Override
    public void displayImage(@NonNull Fragment context, @NonNull String path, final @NonNull MySimpleTarget<Bitmap> simpleTarget) {
        RequestOptions options = new RequestOptions()
                .centerCrop()
                .diskCacheStrategy(DiskCacheStrategy.RESOURCE)
                .placeholder(R.mipmap.icon_placeholder)
                .error(R.mipmap.icon_placeholder)
                .fallback(R.mipmap.icon_placeholder);
        Glide.with(context).asBitmap().apply(options).load(path).into(new SimpleTarget<Bitmap>() {
            @Override
            public void onResourceReady(Bitmap resource, Transition<? super Bitmap> transition) {
                simpleTarget.onResourceReady(resource);
            }

            @Override
            public void onLoadStarted(@Nullable Drawable placeholder) {
                super.onLoadStarted(placeholder);
//                simpleTarget.onLoadStarted();
            }

            @Override
            public void onLoadFailed(@Nullable Drawable errorDrawable) {
                super.onLoadFailed(errorDrawable);
                Context appContext = context.getContext();
                Drawable fallback = errorDrawable != null ? errorDrawable
                        : (appContext != null ? ContextCompat.getDrawable(appContext, R.mipmap.icon_placeholder) : null);
                simpleTarget.onLoadFailed(fallback);
            }
        });
    }

    @Override
    public void displayGifImage(@NonNull Fragment context, @NonNull String path, ImageView imageView, @NonNull MySimpleTarget simpleTarget) {
        RequestOptions options = new RequestOptions()
                .diskCacheStrategy(DiskCacheStrategy.RESOURCE)
                .placeholder(R.mipmap.icon_placeholder)
                .error(R.mipmap.icon_placeholder)
                .fallback(R.mipmap.icon_placeholder);
        Glide.with(context)
                .asGif()
                .load(path)
                .apply(options)
                .listener(new RequestListener<GifDrawable>() {
                    @Override
                    public boolean onLoadFailed(@Nullable GlideException e, Object model, Target<GifDrawable> target, boolean isFirstResource) {
                        Context appContext = context.getContext();
                        Drawable fallback = appContext != null ? ContextCompat.getDrawable(appContext, R.mipmap.icon_placeholder) : null;
                        if (fallback != null) {
                            imageView.setImageDrawable(fallback);
                        }
                        simpleTarget.onLoadFailed(fallback);
                        return true;
                    }

                    @Override
                    public boolean onResourceReady(GifDrawable resource, Object model, Target<GifDrawable> target, DataSource dataSource, boolean isFirstResource) {
                        simpleTarget.onResourceReady();
                        return false;
                    }
                })
                .into(imageView);
    }

    @Override
    public void onStop(@NonNull Fragment context) {
        Glide.with(context).onStop();

    }

    @Override
    public void clearMemory(@NonNull Context c) {
        Glide.get(c).clearMemory();
    }
}
