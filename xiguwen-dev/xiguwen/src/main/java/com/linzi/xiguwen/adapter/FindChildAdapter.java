package com.linzi.xiguwen.adapter;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.WeddingRingBean;
import com.linzi.xiguwen.ui.NewExampleDetailsActivity;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.FullScreenUtil;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.widget.FullCommonPopWindow;
import com.luck.picture.lib.utils.ToastUtils;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/21.
 */

public class FindChildAdapter extends RecyclerView.Adapter<FindChildAdapter.ViewHolder> {
    private List<WeddingRingBean> list;
    Context mContext;
    int tag = 0;
    com.jcodecraeer.xrecyclerview.OnItemClickListener listener;
    CallBack.ImgClickListener imgListener;
    private CallBack.CaseCareClikListener careClikListener;

    public FindChildAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public void removeList() {
        if (list != null && list.size() > 0) {
            list.clear();
            notifyDataSetChanged();
        }
    }

    public void setCareClikListener(CallBack.CaseCareClikListener careClikListener) {
        this.careClikListener = careClikListener;
    }

    public FindChildAdapter(Context mContext, int tag, com.jcodecraeer.xrecyclerview.OnItemClickListener listener, CallBack.ImgClickListener imgListener) {
        this.mContext = mContext;
        this.tag = tag;
        this.listener = listener;
        this.imgListener = imgListener;
    }

    public List<WeddingRingBean> getDatas() {
        return list;
    }

    public void addMore(List<WeddingRingBean> bens) {
        if (bens == null)
            return;
        if (list == null) {
            list = new ArrayList<>();
        }
        list.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<WeddingRingBean> bens) {
        if (list == null) {
            list = new ArrayList<>();
        }
        list.clear();
        list.addAll(bens);
        notifyDataSetChanged();
    }

    public FindChildAdapter(Context mContext, int tag) {
        this.mContext = mContext;
        this.tag = tag;
    }

    public FindChildAdapter(Context mContext, int tag, com.jcodecraeer.xrecyclerview.OnItemClickListener listener) {
        this.mContext = mContext;
        this.tag = tag;
        this.listener = listener;
    }

    public WeddingRingBean getItem(int position) {
        return list.get(position);
    }

    public void setData(List<WeddingRingBean> list) {
        if (this.list == null) {
            this.list = list;
            this.notifyDataSetChanged();
            return;
        }
        this.list.clear();
        addData(list);
    }

    private void addData(List<WeddingRingBean> list) {
        this.list.addAll(list);
        this.notifyDataSetChanged();
    }


    @Override
    public FindChildAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_club_activities_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(FindChildAdapter.ViewHolder vh, int position) {
        vh.btCare.setBackgroundResource(list.get(position).getFollow() == 0 ? R.mipmap.icon_add_care : R.mipmap.icon_close_care);
        if (list.get(position).getHead() != null) {
            GlideLoad.GlideLoadCircle(mContext, list.get(position).getHead(), vh.ivHeadImg);
        }

        vh.tvUserName.setText(list.get(position).getNickname() + "");
        vh.tvZhiwei.setText(list.get(position).getOccupation() + "");
        vh.tvTime.setText(list.get(position).getCreate_ti() + "");
        vh.tvTeamName.setText(list.get(position).getTheteam() + "");
        vh.tvContent.setText(list.get(position).getContent() + "");
        vh.tvSeeCount.setText(list.get(position).getPv() + "");
        vh.tvPingjiaCount.setText(list.get(position).getCommentnum() + "");
        vh.tvDianzanCount.setText(list.get(position).getZan() + "");
        GridLayoutManager manager = new GridLayoutManager(mContext, 3) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        vh.recycle.setLayoutManager(manager);
        ArrayList<String> url = new ArrayList<>();
        for (int i = 0; i < list.get(position).getPhotourl().size(); i++) {
            url.add(list.get(position).getPhotourl().get(i).getPhotourl());
        }
        vh.recycle.setAdapter(new DynamicImgAdapter(url, mContext));
    }

    @Override
    public int getItemCount() {
        return list == null ? 0 : list.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
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
            if (listener != null) {
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        listener.onItemClick(view, getPosition());
                    }
                });
            }
            if (careClikListener != null) {
                btCare.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        careClikListener.CaseCareClik(getPosition());
                    }
                });
            }
        }
    }

    public class DynamicImgAdapter extends RecyclerView.Adapter<DynamicImgAdapter.ImgVh> {


        private ArrayList<String> pingjiaurl;
        private Context mContext;


        public DynamicImgAdapter(ArrayList<String> pingjiaurl, Context mContext) {
            this.pingjiaurl = pingjiaurl;
            this.mContext = mContext;
        }

        @Override
        public ImgVh onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.pingjia_img_item, parent, false);
            return new ImgVh(view);
        }

        @Override
        public void onBindViewHolder(ImgVh holder, int position) {
            GlideLoad.GlideLoadImg(mContext, pingjiaurl.get(position), holder.imgimage);
        }

        @Override
        public int getItemCount() {
            if (pingjiaurl == null) {
                return 0;
            } else {
                return pingjiaurl.size();
            }
        }

        class ImgVh extends RecyclerView.ViewHolder {
            private ImageView imgimage;

            ImgVh(View view) {
                super(view);
                imgimage = (ImageView) view.findViewById(R.id.imgimage);

                view.setOnClickListener(v -> XXPermissions.with(view.getContext())
                        .permission(Permission.CAMERA)
                        .request(new OnPermissionCallback() {
                            @Override
                            public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                                if (!allGranted){
                                    FullCommonPopWindow commonPopWindow = new FullCommonPopWindow((Activity) mContext);
                                    commonPopWindow.showAtLocation(imgimage, Gravity.CENTER, 0, 0);
                                    commonPopWindow.getTitText().setText(view.getContext().getResources().getString(R.string.per_photo));
                                    commonPopWindow.getCancel().setOnClickListener(view -> {
                                        commonPopWindow.dismiss();
                                        FullScreenUtil.showFullScreenDialog(imgimage.getContext(), getPosition(),pingjiaurl);
                                    });
                                    commonPopWindow.getSure().setOnClickListener(view -> {
                                        commonPopWindow.dismiss();
                                    });

                                }else {

                                }
                            }

                            @Override
                            public void onDenied(@NonNull List<String> permissions, boolean doNotAskAgain) {
                                if (doNotAskAgain) {
                                    ToastUtils.showToast(mContext,"被永久拒绝授权，请手动存储权限");
                                    // 如果是被永久拒绝就跳转到应用权限系统设置页面
                                    XXPermissions.startPermissionActivity(mContext, permissions);
                                } else {
                                    ToastUtils.showToast(mContext,"获取存储权限失败");
                                }
                            }
                        }));
            }
        }
    }

    public class ImgAdapter extends RecyclerView.Adapter<ImgAdapter.VH> {
        CallBack.ImgClickListener imgClickListener;

        public ImgAdapter(CallBack.ImgClickListener imgClickListener) {
            this.imgClickListener = imgClickListener;
        }

        @Override
        public ImgAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
            ImageView imageView = new ImageView(mContext);
            return new VH(imageView);
        }

        @Override
        public void onBindViewHolder(ImgAdapter.VH vh, final int position) {
            GlideLoad.GlideLoadImg(mContext, "http://img3.imgtn.bdimg.com/it/u=1456724845,1165243952&fm=27&gp=0.jpg", vh.imageView);
            if (imgListener != null) {
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
            return 8;
        }

        class VH extends RecyclerView.ViewHolder {
            ImageView imageView;

            public VH(View itemView) {
                super(itemView);
                imageView = (ImageView) itemView;
                LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(dip2px(mContext, 109), dip2px(mContext, 109));
                params.topMargin = dip2px(mContext, 8);
                imageView.setLayoutParams(params);
            }
        }
    }

    //将dp转换为px
    public int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }
}
