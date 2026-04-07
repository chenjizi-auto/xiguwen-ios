package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by PC on 2018-03-29.
 */

public class MineImageAdapter extends RecyclerView.Adapter<MineImageAdapter.VH>{
    CallBack.ImgClickListener imgListener;
    private Context mContext;
    private List<String> mPaths;

    public MineImageAdapter(Context context, CallBack.ImgClickListener imgClickListener) {
        this.mContext = context;
        this.imgListener = imgClickListener;
        this.mPaths = new ArrayList<>();
    }

    @Override
    public MineImageAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
        ImageView imageView=new ImageView(mContext);
        return new MineImageAdapter.VH(imageView);
    }

    public void setData(List<String> paths){
        mPaths.clear();
        if(paths != null){
            mPaths.addAll(paths);
        }
        notifyDataSetChanged();
    }


    @Override
    public void onBindViewHolder(MineImageAdapter.VH vh, final int position) {
        GlideLoad.GlideLoadRoundedImg(mPaths.get(position), vh.imageView, 8);
        if(imgListener!=null){
            vh.imageView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    imgListener.imgListener(position);
                }
            });
        }
    }

    @Override
    public int getItemCount() {
        return mPaths.size();
    }

    class VH extends RecyclerView.ViewHolder{
        ImageView imageView;
        public VH(View itemView) {
            super(itemView);
            imageView= (ImageView) itemView;
            LinearLayout.LayoutParams params=new LinearLayout.LayoutParams(dip2px(mContext,109),dip2px(mContext,109));
            params.topMargin=dip2px(mContext,8);
            imageView.setLayoutParams(params);
            imageView.setBackgroundResource(com.linzi.xiguwen.R.drawable.rounded_list_image_bg);
            imageView.setClipToOutline(true);
            imageView.setImageResource(com.linzi.xiguwen.R.mipmap.icon_placeholder);
        }
    }

    //将dp转换为px
    public  int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }
}
