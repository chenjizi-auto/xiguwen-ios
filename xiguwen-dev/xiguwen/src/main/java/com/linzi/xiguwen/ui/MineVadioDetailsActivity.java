package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.graphics.Bitmap;
import android.media.MediaMetadataRetriever;
import android.media.ThumbnailUtils;
import android.os.Bundle;
import android.provider.MediaStore;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.VideoBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.MineDetailControlView;

import java.util.Hashtable;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MineVadioDetailsActivity extends BaseDetailActivity {

    @BindView(R.id.tv_name)
    TextView tvName;
    @BindView(R.id.tv_web_http)
    TextView tvWebHttp;
    @BindView(R.id.ed_weight)
    TextView edWeight;
    @BindView(R.id.iv_fengmian)
    ImageView ivFengmian;
    @BindView(R.id.ll_choose_fengmian)
    LinearLayout llChooseFengmian;
    @BindView(R.id.iv_vadio)
    ImageView ivVadio;

    @BindView(R.id.control_view)
    MineDetailControlView mControlView;

    private VideoBean mData;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_vadio_details);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("视频详情");
        setBack();

        mData = (VideoBean) getIntent().getSerializableExtra("data");

        if(mData != null){
            tvName.setText(mData.getTitle());
            edWeight.setText(mData.getWeigh() + "");
            tvWebHttp.setText(mData.getVideo_url());
            GlideLoad.GlideLoadImg(this, mData.getCover(), ivFengmian);
//            GlideLoad.GlideLoadImg(this, mData.getVideo_url(), ivVadio);
//            ivVadio.setImageBitmap(createVideoThumbnail(mData.getVideo_url(), MediaStore.Images.Thumbnails.MINI_KIND));
        }

        mControlView.setData(mData);
        mControlView.setOnControlListener(this);
    }

    private void requestNetData() {
        MsgLoadDialog.showDialog(this, "请稍候...");
        ApiManager.getVideoDetail(mData.getId(), new OnRequestFinish<BaseBean<VideoBean>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<VideoBean> data) {
                mData = data.getData();
                if(mData != null){
                    tvName.setText(mData.getTitle());
                    edWeight.setText(mData.getWeigh() + "");
                    tvWebHttp.setText(mData.getVideo_url());
                    GlideLoad.GlideLoadImg(MineVadioDetailsActivity.this, mData.getCover(), ivFengmian);
//                  GlideLoad.GlideLoadImg(this, mData.getVideo_url(), ivVadio);
//                    ivVadio.setImageBitmap(createVideoThumbnail(mData.getVideo_url(), MediaStore.Images.Thumbnails.MINI_KIND));
                }
                mControlView.setData(mData);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    // 加载视频预览界面
    public Bitmap createVideoThumbnail(String filePath, int kind){
        Bitmap mVideoBitmap = null;
        MediaMetadataRetriever retriever = new MediaMetadataRetriever();
        try {
            if (filePath.startsWith("http://")
                    || filePath.startsWith("https://")
                    || filePath.startsWith("widevine://")) {
                retriever.setDataSource(filePath,new Hashtable<String,String>());
            }else {
                retriever.setDataSource(filePath);
            }
            mVideoBitmap =retriever.getFrameAtTime(-1);
        } catch (IllegalArgumentException ex) {
            // Assume this is a corrupt video file
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
        } catch (RuntimeException ex) {
            // Assume this is a corrupt video file.
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
        } finally {
            try {
                retriever.release();
            } catch (Exception ex) {
                // Ignore failures while cleaning up.
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        }

        if (mVideoBitmap==null)return null;

        if (kind== MediaStore.Images.Thumbnails.MINI_KIND) {
            // Scale down the bitmap if it's too large.
            int width= mVideoBitmap.getWidth();
            int height= mVideoBitmap.getHeight();
            int max =Math.max(width, height);
            if(max >512) {
                float scale=512f / max;
                int w =Math.round(scale * width);
                int h =Math.round(scale * height);
                mVideoBitmap = Bitmap.createScaledBitmap(mVideoBitmap,w, h, true);
            }
        } else if (kind== MediaStore.Images.Thumbnails.MICRO_KIND) {
            mVideoBitmap = ThumbnailUtils.extractThumbnail(mVideoBitmap,
                    96,
                    96,
                    ThumbnailUtils.OPTIONS_RECYCLE_INPUT);
        }
        return mVideoBitmap;
    }



    @Override
    protected int getPageType() {
        return MineListActivity.TYPE_SHIPING;
    }

    @Override
    protected int getDataId() {
        return mData == null ? 0 : mData.getId();
    }

    @Override
    protected void refreshData() {
        setResult(RESULT_OK);
        requestNetData();
    }


    @Override
    public void onEdit() {
        Intent intent = new Intent(this, AddVideoActivity.class);
        intent.putExtra("data", mData);
        startActivityForResult(intent, 100);
    }
}
