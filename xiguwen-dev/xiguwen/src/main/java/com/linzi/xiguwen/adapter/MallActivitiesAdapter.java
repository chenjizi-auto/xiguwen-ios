package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.GlideLoad;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/21.
 */

public class MallActivitiesAdapter extends RecyclerView.Adapter<MallActivitiesAdapter.ViewHolder> {
    Context mContext;

    public MallActivitiesAdapter(Context context) {
        mContext = context;
    }

    @Override
    public MallActivitiesAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_club_activities_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MallActivitiesAdapter.ViewHolder vh, int position) {
        vh.btCare.setVisibility(View.GONE);
        GlideLoad.GlideLoadCircle(mContext,"http://img0.imgtn.bdimg.com/it/u=1950620400,3641542324&fm=27&gp=0.jpg",vh.ivHeadImg);
        vh.tvUserName.setText("林子");
        vh.tvZhiwei.setText("策划师");
        vh.tvTime.setText("2017-12-22");
        vh.tvTeamName.setText("**策划师团队");
        vh.tvContent.setText("青春是一首永不言败的歌，青春是一条永不停息的河流，青春是一本读不厌的书，青春是一杯品不尽的茶，青春是一起牵手在天空之桥留下我们幸福的足迹。");
        vh.tvSeeCount.setText("200");
        vh.tvPingjiaCount.setText("200");
        vh.tvDianzanCount.setText("200");
        GridLayoutManager manager=new GridLayoutManager(mContext,3){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        vh.recycle.setLayoutManager(manager);
        vh.recycle.setAdapter(new ImgAdapter());
    }

    @Override
    public int getItemCount() {
        return 5;
    }

     class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.iv_head_img)
        ImageView ivHeadImg;
        @BindView(R.id.tv_user_name)
        TextView tvUserName;
         @BindView(R.id.tv_zhiwei)
        TextView tvZhiwei;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_team_name)
        TextView tvTeamName;
        @BindView(R.id.bt_care)
        Button btCare;
        @BindView(R.id.tv_content)
        TextView tvContent;
        @BindView(R.id.recycle)
        RecyclerView recycle;
        @BindView(R.id.tv_see_count)
        TextView tvSeeCount;
        @BindView(R.id.tv_pingjia_count)
        TextView tvPingjiaCount;
        @BindView(R.id.tv_dianzan_count)
        TextView tvDianzanCount;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

    class ImgAdapter extends RecyclerView.Adapter<ImgAdapter.VH>{
        @Override
        public ImgAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
            ImageView imageView=new ImageView(mContext);
            return new VH(imageView);
        }

        @Override
        public void onBindViewHolder(ImgAdapter.VH vh, int position) {
            GlideLoad.GlideLoadImg(mContext,"http://img3.imgtn.bdimg.com/it/u=1456724845,1165243952&fm=27&gp=0.jpg",vh.imageView);
        }

        @Override
        public int getItemCount() {
            return 8;
        }

        class VH extends RecyclerView.ViewHolder{
            ImageView imageView;
            public VH(View itemView) {
                super(itemView);
                imageView= (ImageView) itemView;
                LinearLayout.LayoutParams params=new LinearLayout.LayoutParams(dip2px(mContext,109),dip2px(mContext,109));
                params.topMargin=dip2px(mContext,8);
                imageView.setLayoutParams(params);
            }
        }
    }

    //将dp转换为px
    public  int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }
}
