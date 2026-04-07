package com.linzi.xiguwen.adapter.discover;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.Rect;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewOutlineProvider;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.jaeger.ninegridimageview.ItemImageClickListener;
import com.jaeger.ninegridimageview.NineGridImageView;
import com.jaeger.ninegridimageview.NineGridImageViewAdapter;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.WeddingRingBean;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
import com.linzi.xiguwen.ui.NewShopMallDetailsActivity;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideLoad;
import com.luck.picture.lib.utils.ToastUtils;
import com.previewlibrary.GPreviewBuilder;
import com.linzi.xiguwen.preview.PreviewUtil;
import com.wx.goodview.GoodView;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by devin on 2018/4/17 9:58
 * Description
 */

public class DisCoverAdapter extends RecyclerView.Adapter<DisCoverAdapter.ViewHolder> {
    private List<WeddingRingBean> list;
    Context mContext;
    int tag = 0;
    com.jcodecraeer.xrecyclerview.OnItemClickListener listener;
    CallBack.ImgClickListener imgListener;
    private CallBack.CaseCareClikListener careClikListener;

    public DisCoverAdapter(Context mContext) {
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

    public DisCoverAdapter(Context mContext, int tag, com.jcodecraeer.xrecyclerview.OnItemClickListener listener, CallBack.ImgClickListener imgListener) {
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

    public DisCoverAdapter(Context mContext, int tag) {
        this.mContext = mContext;
        this.tag = tag;
    }

    public DisCoverAdapter(Context mContext, int tag, com.jcodecraeer.xrecyclerview.OnItemClickListener listener) {
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
    public DisCoverAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_discover, parent, false);
        return new DisCoverAdapter.ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(DisCoverAdapter.ViewHolder vh, final int position) {
        vh.btCare.setBackgroundResource(list.get(position).getFollow() == 0 ? R.mipmap.icon_add_care : R.mipmap.icon_close_care);
        if (list.get(position).getHead() != null) {
            GlideLoad.GlideLoadCircle(mContext, list.get(position).getHead(), vh.ivHeadImg);
        }

        vh.tvUserName.setText(list.get(position).getNickname() + "");
        if (!AppUtil.isEmpty(list.get(position).getOccupation())) {
            vh.tvZhiwei.setText(list.get(position).getOccupation() + "");
        } else {
            vh.tvZhiwei.setText("");
        }
        vh.tvTime.setText(list.get(position).getCreate_ti() + "");
        vh.tvTeamName.setText(list.get(position).getTheteam() + "");
        vh.tvContent.setText(list.get(position).getContent() + "");
        vh.tvSeeCount.setText(list.get(position).getPv() + "");
        vh.tvPingjiaCount.setText(list.get(position).getCommentnum() + "");
        vh.tvDianzanCount.setText(list.get(position).getZan() + "");
        vh.grid_image.setImagesData(list.get(position).getPhotourl());


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
        @BindView(R.id.grid_image)
        NineGridImageView grid_image;
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
            ivHeadImg.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if (tag == 0) {
                        Intent intent = new Intent(mContext, NewMallDetailsActivity.class);
                        intent.putExtra("shop_id", list.get(getPosition()).getUserid());
                        mContext.startActivity(intent);
                    } else {
                        Intent intent = new Intent(mContext, NewShopMallDetailsActivity.class);
                        intent.putExtra("shop_id", list.get(getPosition()).getUserid());
                        mContext.startActivity(intent);
                    }
                }
            });
            grid_image.setAdapter(mAdapterDetail);
            grid_image.setItemImageClickListener(new ItemImageClickListener<WeddingRingBean.PhotourlBean>() {
                @Override
                public void onItemImageClick(Context context, ImageView imageView, int index, List<WeddingRingBean.PhotourlBean> list) {
//                ArrayList<String> urls = new ArrayList<>();
//                for (SynamicdetailsBean.PhotourlBean bean : list) {
//                    urls.add(bean.getPhotourl());
//                }
//                BrowserUtils.intentToBrowser(context, urls, index);

                    if (!PreviewUtil.canPreview(context, list, index)) {
                        return;
                    }
                    computeBoundsBackward(list);//组成数据
                    GPreviewBuilder.from((Activity) context)
                            .setUserFragment(com.linzi.xiguwen.preview.SafePreviewPhotoFragment.class)
                            .setData(list)
                            .setCurrentIndex(index)
                            .setType(GPreviewBuilder.IndicatorType.Dot)
                            .start();//启动
                }
            });
            tvDianzanCount.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (list.get(getPosition()).getShifouzan() == 1) {
                        goodsCancel(new GoodView(mContext), list.get(getPosition()).getId(), view, list.get(getPosition()));
                    } else {
                        goods(new GoodView(mContext), list.get(getPosition()).getId(), view, list.get(getPosition()));
                    }
                }
            });
        }

        /**
         * 查找信息
         *
         * @param list 图片集合
         */
        private void computeBoundsBackward(List<WeddingRingBean.PhotourlBean> list) {
            for (int i = 0; i < grid_image.getChildCount(); i++) {
                View itemView = grid_image.getChildAt(i);
                Rect bounds = new Rect();
                if (itemView != null) {
                    ImageView thumbView = (ImageView) itemView;
                    thumbView.getGlobalVisibleRect(bounds);
                }
                list.get(i).setBounds(bounds);
                list.get(i).setPhotourl(list.get(i).getPhotourl());
            }
        }


        private NineGridImageViewAdapter<WeddingRingBean.PhotourlBean> mAdapterDetail = new NineGridImageViewAdapter<WeddingRingBean.PhotourlBean>() {
            @Override
            protected void onDisplayImage(Context context, ImageView imageView, WeddingRingBean.PhotourlBean s) {
                GlideLoad.GlideLoadImg2(s.getPhotourl(), imageView);
            }

            @Override
            protected ImageView generateImageView(Context context) {
                ImageView imageView = super.generateImageView(context);
                imageView.setBackgroundResource(R.drawable.rounded_list_image_bg);
                imageView.setClipToOutline(true);
                imageView.setOutlineProvider(ViewOutlineProvider.BACKGROUND);
                imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
                return imageView;
            }

            @Override
            protected void onItemImageClick(Context context, ImageView imageView, int index, List<WeddingRingBean.PhotourlBean> list) {
                //  Toast.makeText(context, "image position is " + index, Toast.LENGTH_SHORT).show();
            }
        };
    }

    //点赞
    private void goods(final GoodView goodView, int id, final View view, final WeddingRingBean bean) {
        ApiManager.giveALike(id, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                goodView.setTextInfo("+1", Color.RED, 30);
                goodView.show(view);
                bean.setShifouzan(1);
                bean.setZan(bean.getZan() + 1);
                notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                ToastUtils.showToast(mContext, ex.getMessage());
            }
        });
    }

    //取消点赞
    private void goodsCancel(final GoodView goodView, int id, final View view, final WeddingRingBean bean) {
        ApiManager.disGiveALike(id, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                goodView.setTextInfo("-1", Color.RED, 30);
                goodView.show(view);
                bean.setShifouzan(0);
                if (bean.getZan() != 0)
                    bean.setZan(bean.getZan() - 1);
                notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                ToastUtils.showToast(mContext, ex.getMessage());
            }
        });
    }
}
