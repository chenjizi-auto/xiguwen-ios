package com.linzi.xiguwen.adapter;

import android.app.Activity;
import android.graphics.Rect;
import android.content.Context;
import android.os.Parcel;
import androidx.recyclerview.widget.RecyclerView;
import androidx.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.preview.PreviewUtil;
import com.linzi.xiguwen.ui.ToRenZhengActivity;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.NToast;
import com.previewlibrary.GPreviewBuilder;
import com.previewlibrary.enitity.IThumbViewInfo;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/29.
 */

public class AddAdapter extends RecyclerView.Adapter<AddAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;
    CallBack.ImgClickListener imgClickListener;
    ArrayList<String> img;
    int type = 0;

    public AddAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener, CallBack.ImgClickListener imgClickListener, ArrayList<String> img) {
        this.mContext = mContext;
        this.itemClickListener = itemClickListener;
        this.imgClickListener = imgClickListener;
        this.img = img;
    }

    public AddAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener, CallBack.ImgClickListener imgClickListener, ArrayList<String> img, int type) {
        this.mContext = mContext;
        this.itemClickListener = itemClickListener;
        this.imgClickListener = imgClickListener;
        this.img = img;
        this.type = type;
    }

    @Override
    public AddAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_add_img_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final AddAdapter.ViewHolder vh, final int position) {
        ensureSquareItem(vh);
        NToast.log("positon====", "" + position  +" type == "+type);
        if (type == ToRenZhengActivity.TYPE_WATCH){
            vh.ivDel.setVisibility(View.GONE);
            if (position <= img.size()-1){
                GlideLoad.GlideLoadImg(mContext, img.get(position), vh.ivImg);
            }
        }else {
            if (!img.isEmpty()) {
                if (position >= img.size()) {
                    GlideLoad.GlideLoadImg(mContext, R.mipmap.icon_continu_add_img, vh.ivImg);
                    vh.ivImg.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            itemClickListener.onItemClick(vh.ivImg, position);
                        }
                    });
                    vh.ivDel.setVisibility(View.GONE);
                } else {
                    vh.ivDel.setVisibility(View.VISIBLE);
                    GlideLoad.GlideLoadRoundedImg(img.get(position), vh.ivImg, 8);
                    vh.ivImg.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            previewImages(vh.ivImg, position);
                        }
                    });
                    vh.ivDel.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            imgClickListener.imgListener(position);
                        }
                    });
                }
            } else {
                GlideLoad.GlideLoadImg(mContext, R.mipmap.icon_continu_add_img, vh.ivImg);
                vh.ivImg.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        itemClickListener.onItemClick(vh.ivImg, position);
                    }
                });
                vh.ivDel.setVisibility(View.GONE);
            }
        }
    }

    @Override
    public int getItemCount() {
        int size = 0;
        com.linzi.xiguwen.utils.LogUtil.e("TAdapter","----------img.size()-----------"+img.size());
        if (img.isEmpty()) {
            if (type != 5){
                size = 1;
            }else {
                size =0;
            }
        } else {
            if (type != 5){
                size = img.size() + 1;
            }else {
                size = img.size();
            }
        }
//        com.linzi.xiguwen.utils.LogUtil.e("TAdapter","----------sizeX-----------"+size);
        return size;
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.iv_del)
        ImageView ivDel;
        @BindView(R.id.ll_add)
        RelativeLayout llAdd;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

    public ArrayList<String> getList() {
        return img;
    }

    private void ensureSquareItem(final ViewHolder vh) {
        vh.llAdd.post(new Runnable() {
            @Override
            public void run() {
                ViewGroup.LayoutParams params = vh.llAdd.getLayoutParams();
                int width = vh.llAdd.getWidth();
                if (width > 0 && params.height != width) {
                    params.height = width;
                    vh.llAdd.setLayoutParams(params);
                }
            }
        });
    }

    private void previewImages(ImageView imageView, int currentIndex) {
        if (!(mContext instanceof Activity)) {
            return;
        }
        List<PreviewItem> pics = new ArrayList<>();
        for (String url : img) {
            PreviewItem bean = new PreviewItem();
            bean.setUrl(url);
            pics.add(bean);
        }
        if (!PreviewUtil.canPreview(mContext, pics, currentIndex)) {
            return;
        }
        Rect bounds = new Rect();
        imageView.getGlobalVisibleRect(bounds);
        pics.get(currentIndex).setBounds(bounds);
        GPreviewBuilder.from((Activity) mContext)
                .setUserFragment(com.linzi.xiguwen.preview.SafePreviewPhotoFragment.class)
                .setData(pics)
                .setCurrentIndex(currentIndex)
                .setType(GPreviewBuilder.IndicatorType.Dot)
                .start();
    }

    private static class PreviewItem implements IThumbViewInfo {
        private String url;
        private Rect bounds;

        void setUrl(String url) {
            this.url = url;
        }

        void setBounds(Rect bounds) {
            this.bounds = bounds;
        }

        @Override
        public String getUrl() {
            return url;
        }

        @Override
        public Rect getBounds() {
            return bounds;
        }

        @Nullable
        @Override
        public String getVideoUrl() {
            return null;
        }

        @Override
        public int describeContents() {
            return 0;
        }

        @Override
        public void writeToParcel(Parcel dest, int flags) {
            dest.writeString(this.url);
            dest.writeParcelable(this.bounds, flags);
        }

        protected PreviewItem(Parcel in) {
            this.url = in.readString();
            this.bounds = in.readParcelable(Rect.class.getClassLoader());
        }

        PreviewItem() {
        }

        public static final Creator<PreviewItem> CREATOR = new Creator<PreviewItem>() {
            @Override
            public PreviewItem createFromParcel(Parcel source) {
                return new PreviewItem(source);
            }

            @Override
            public PreviewItem[] newArray(int size) {
                return new PreviewItem[size];
            }
        };
    }
}
