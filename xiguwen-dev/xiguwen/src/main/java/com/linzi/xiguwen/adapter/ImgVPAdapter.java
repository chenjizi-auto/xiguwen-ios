package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import androidx.annotation.NonNull;
import androidx.viewpager.widget.PagerAdapter;


import com.bumptech.glide.Glide;
import com.bumptech.glide.request.RequestOptions;
import com.linzi.xiguwen.R;

import java.util.List;


public class ImgVPAdapter extends PagerAdapter {
    private final Context context;
    private final List<String> paths;

    public ImgVPAdapter(Context context, List<String> paths) {
        this.context = context;
        this.paths = paths;
    }

    @Override
    public int getCount() {
        return paths.size();
    }

    @Override
    public boolean isViewFromObject(@NonNull View view, @NonNull Object object) {
        return view == object;
    }

    @Override
    public Object instantiateItem(ViewGroup container, final int position) {
        ImageView iv_img = (ImageView) LayoutInflater.from(context).inflate(R.layout.item_img_pv, null);
      //  iv_img.setScaleType(ImageView.ScaleType.CENTER);

        RequestOptions options = new RequestOptions()
                .placeholder(R.drawable.ps_image_placeholder)
                .error(R.drawable.shibai)
                .centerCrop();
        Glide.with(context).load(paths.get(position))
                .apply(options)
                .into(iv_img);
        iv_img.setScaleType(ImageView.ScaleType.CENTER);
        iv_img.setOnClickListener(v -> {
            if (allClickListener != null) {
                allClickListener.allclick(position);
            }
        });
        iv_img.setOnLongClickListener(v -> {
            if (allClickListener != null) {
                allClickListener.alllongclick(position,v);
            }
            return false;
        });
        container.addView(iv_img);
        return iv_img;
    }


    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {
        container.removeView((View) object);
    }

    public interface AllClickListener {
        void allclick(int pos);
        void alllongclick(int pos,View v);
    }

    private AllClickListener allClickListener;

    public void setAllClickListener(AllClickListener allClickListener) {
        this.allClickListener = allClickListener;
    }
}
