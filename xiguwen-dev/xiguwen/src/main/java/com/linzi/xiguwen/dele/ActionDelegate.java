package com.linzi.xiguwen.dele;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.Rect;
import android.view.View;
import android.view.ViewOutlineProvider;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.jaeger.ninegridimageview.ItemImageClickListener;
import com.jaeger.ninegridimageview.NineGridImageView;
import com.jaeger.ninegridimageview.NineGridImageViewAdapter;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.ShetuanIndexBean;
import com.linzi.xiguwen.bean.SynamicdetailsBean;
import com.linzi.xiguwen.fragment.discover.DiscoverDetailActivity;
import com.linzi.xiguwen.ui.NewClubDetailsPersonActivity;
import com.linzi.xiguwen.utils.BrowserUtils;
import com.linzi.xiguwen.utils.GlideLoad;
import com.wx.goodview.GoodView;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.OnClick;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/27  14:14
 *
 * @author luyongjiang
 * @version 1.0
 */
public class ActionDelegate {

    public static CreateHolderDelegate<ShetuanIndexBean.DynamiclistBean> create() {
        return new CreateHolderDelegate<ShetuanIndexBean.DynamiclistBean>() {
            @Override
            public int getLayoutRes() {
                return R.layout.item_news_club_activities_layout;
            }

            @Override
            public BaseViewHolder onCreateHolder(View itemView) {
                return new ActionHolder(itemView);
            }
        };
    }


    public static class ActionHolder extends BaseViewHolder<ShetuanIndexBean.DynamiclistBean> {
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
        @BindView(R.id.tv_see_count)
        TextView tvSeeCount;
        @BindView(R.id.tv_pingjia_count)
        TextView tvPingjiaCount;
        @BindView(R.id.tv_dianzan_count)
        TextView tvDianzanCount;
        @BindView(R.id.grid_image)
        NineGridImageView grid_image;

        GoodView goodView = new GoodView(itemView.getContext());

        @OnClick({R.id.bt_care, R.id.tv_dianzan_count})
        public void onClick(View view) {
            switch (view.getId()) {
                case R.id.bt_care:
                    goodView.setTextInfo("关注成功", 0xffF0951C, 15);
                    break;
                case R.id.tv_dianzan_count:
                    goodView.setTextInfo("+1", Color.RED, 15);
                    break;

            }
            goodView.show(view);
        }

        public ActionHolder(View itemView) {
            super(itemView);

        }


        /**
         * 这个方法不是给item使用的
         *
         * @param bean
         */
        public void bindValue(SynamicdetailsBean bean) {
            GlideLoad.GlideLoadCircle(bean.getHead(), ivHeadImg);
            tvUserName.setText(bean.getNickname());
            tvZhiwei.setText(bean.getOccupation());
            tvTime.setText(bean.getCreate_ti());
            tvTeamName.setText(bean.getTheteam());
            tvContent.setText(bean.getContent());
//            tvSeeCount.setText(bean.getPv() + "");
//            tvPingjiaCount.setText(bean.getPls() + "");
//            tvDianzanCount.setText(bean.getZan() + "");
            grid_image.setAdapter(mAdapterDetail);
            grid_image.setImagesData(bean.getPhotourl());
            grid_image.setItemImageClickListener(new ItemImageClickListener<SynamicdetailsBean.PhotourlBean>() {
                @Override
                public void onItemImageClick(Context context, ImageView imageView, int index, List<SynamicdetailsBean.PhotourlBean> list) {
                    ArrayList<String> urls = new ArrayList<>();
                    for (SynamicdetailsBean.PhotourlBean bean : list) {
                        urls.add(bean.getPhotourl());
                    }
                    BrowserUtils.intentToBrowser(context, urls, index);
                }
            });
        }

        @Override
        protected void bindView(final ShetuanIndexBean.DynamiclistBean bean) {
            setValue(bean);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
//                    Intent intent = new Intent(itemView.getContext(), NewClubDetailsPersonActivity.class);
//                    intent.putExtra(NewClubDetailsPersonActivity.ID_KEY, bean.getId());
//
//                    itemView.getContext().startActivity(intent);

                    DiscoverDetailActivity.startAction(itemView.getContext(), 0, bean.getId(), -1);
                }
            });
        }

        private void setValue(ShetuanIndexBean.DynamiclistBean bean) {
            GlideLoad.GlideLoadCircle(bean.getHead(), ivHeadImg);
            tvUserName.setText(bean.getNickname());
            tvZhiwei.setText(bean.getOccupationid());
            tvTime.setText(bean.getCreate_ti());
            tvTeamName.setText(bean.getAssociation());
            tvContent.setText(bean.getContent());
            tvSeeCount.setText(bean.getPv() + "");
            tvPingjiaCount.setText(bean.getPls() + "");
            tvDianzanCount.setText(bean.getZan() + "");
            grid_image.setAdapter(mAdapter);
            grid_image.setImagesData(bean.getPics());
            grid_image.setItemImageClickListener(new ItemImageClickListener<ShetuanIndexBean.DynamiclistBean.PicsBean>() {

                @Override
                public void onItemImageClick(Context context, ImageView imageView, int index, List<ShetuanIndexBean.DynamiclistBean.PicsBean> list) {
//                    computeBoundsBackward(list);//组成数据
                    ArrayList<String> urls = new ArrayList<>();
                    for (ShetuanIndexBean.DynamiclistBean.PicsBean bean : list) {
                        urls.add(bean.getPhotourl());
                    }
                    BrowserUtils.intentToBrowser(context, urls, index);
//                    GPreviewBuilder.from((Activity) context)
//                            .setData(list)
//                            .setCurrentIndex(index)
//                            .setType(GPreviewBuilder.IndicatorType.Dot)
//                            .start();//启动
                }
            });
        }

        /**
         * 查找信息
         *
         * @param list 图片集合
         */
        private void computeBoundsBackward(List<ShetuanIndexBean.DynamiclistBean.PicsBean> list) {
            for (int i = 0; i < grid_image.getChildCount(); i++) {
                View itemView = grid_image.getChildAt(i);
                Rect bounds = new Rect();
                if (itemView != null) {
                    ImageView thumbView = (ImageView) itemView;
                    thumbView.getGlobalVisibleRect(bounds);
                }
                list.get(i).setBounds(bounds);
                list.get(i).setUrl(list.get(i).getUrl());
            }

        }

        /**
         * 查找信息
         *
         * @param list 图片集合
         */
        private void computeBoundsToActionDetail(List<SynamicdetailsBean.PhotourlBean> list) {
            for (int i = 0; i < grid_image.getChildCount(); i++) {
                View itemView = grid_image.getChildAt(i);
                Rect bounds = new Rect();
                if (itemView != null) {
                    ImageView thumbView = (ImageView) itemView;
                    thumbView.getGlobalVisibleRect(bounds);
                }
                list.get(i).setBounds(bounds);
                list.get(i).setUrl(list.get(i).getUrl());
            }

        }

        private NineGridImageViewAdapter<ShetuanIndexBean.DynamiclistBean.PicsBean> mAdapter = new NineGridImageViewAdapter<ShetuanIndexBean.DynamiclistBean.PicsBean>() {
            @Override
            protected void onDisplayImage(Context context, ImageView imageView, ShetuanIndexBean.DynamiclistBean.PicsBean s) {
                GlideLoad.GlideLoadImg2(s.getUrl(), imageView);
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
            protected void onItemImageClick(Context context, ImageView imageView, int index, List<ShetuanIndexBean.DynamiclistBean.PicsBean> list) {
                //  Toast.makeText(context, "image position is " + index, Toast.LENGTH_SHORT).show();
            }
        };

        //---------------------------这个是用来动态详情使用的---------------------------------
        private NineGridImageViewAdapter<SynamicdetailsBean.PhotourlBean> mAdapterDetail = new NineGridImageViewAdapter<SynamicdetailsBean.PhotourlBean>() {
            @Override
            protected void onDisplayImage(Context context, ImageView imageView, SynamicdetailsBean.PhotourlBean s) {
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
            protected void onItemImageClick(Context context, ImageView imageView, int index, List<SynamicdetailsBean.PhotourlBean> list) {
                //  Toast.makeText(context, "image position is " + index, Toast.LENGTH_SHORT).show();
            }
        };


    }

}
