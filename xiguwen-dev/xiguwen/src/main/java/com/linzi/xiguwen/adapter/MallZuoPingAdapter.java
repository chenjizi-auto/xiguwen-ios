package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.content.Intent;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.ZuoPingBean;
import com.linzi.xiguwen.ui.ExampleDetailsActivity;
import com.linzi.xiguwen.utils.FullScreenUtil;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import fm.jiecao.jcvideoplayer_lib.JCFullScreenActivity;
import fm.jiecao.jcvideoplayer_lib.JCVideoPlayerStandard;

/**
 * Created by pc on 2018/3/26.
 */

public class MallZuoPingAdapter extends RecyclerView.Adapter<MallZuoPingAdapter.VH> {
    private ZuoPingBean bean;
    private Context mContext;
    private int videonum = 0;
    private int casenum = 0;
    private int atlasnum = 0;

    public void setzuopingBeanList(ZuoPingBean bean) {
        this.bean = bean;
        this.notifyDataSetChanged();
    }

    public MallZuoPingAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public MallZuoPingAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_club_someone_layout, parent, false);
        return new VH(view);
    }

    @Override
    public void onBindViewHolder(MallZuoPingAdapter.VH holder, int position) {
        GridLayoutManager manager = new GridLayoutManager(mContext, 2) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        videonum = bean.getSp() == null ? 0 : bean.getSp().size();
        casenum = bean.getAl() == null ? 0 : bean.getAl().size();
        atlasnum = bean.getTc() == null ? 0 : bean.getTc().size();
        switch (position) {
            case 0:
                holder.llMore.setVisibility(View.GONE);
                holder.tvZhiwei.setText("视屏（" + videonum + "）");
                holder.tvMore.setVisibility(View.GONE);
                VideoListAdapter adapter = new VideoListAdapter();
                holder.recycle.setLayoutManager(manager);
                holder.recycle.setAdapter(adapter);
                adapter.setData(bean.getSp());
                break;
            case 1:
                holder.llMore.setVisibility(View.GONE);
                holder.tvZhiwei.setText("案例（" + casenum + "）");
                holder.tvMore.setVisibility(View.GONE);
                CaseAdapter adapter2 = new CaseAdapter();
                holder.recycle.setLayoutManager(manager);
                holder.recycle.setAdapter(adapter2);
                adapter2.setData(bean.getAl());
                break;
            case 2:
                holder.llMore.setVisibility(View.GONE);
                holder.tvZhiwei.setText("图册（" + atlasnum + "）");
                holder.tvMore.setVisibility(View.GONE);
                holder.recycle.setLayoutManager(manager);
                AtlasAdapter adapter3 = new AtlasAdapter();
                holder.recycle.setAdapter(adapter3);
                adapter3.setData(bean.getTc());
                break;
        }
    }

    @Override
    public int getItemCount() {
        return 3;
    }

    class VH extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_zhiwei)
        TextView tvZhiwei;
        @BindView(R.id.tv_more)
        TextView tvMore;
        @BindView(R.id.recycle)
        RecyclerView recycle;
        @BindView(R.id.ll_more)
        LinearLayout llMore;
        @BindView(R.id.tv_more_some)
        TextView tvMoreSome;

        VH(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

    //视屏列表适配器
    public class VideoListAdapter extends RecyclerView.Adapter<VideoListAdapter.VideoViewHolder> {
        private com.jcodecraeer.xrecyclerview.OnItemClickListener mListener;
        private List<ZuoPingBean.SpBean> list;

        public void setData(List<ZuoPingBean.SpBean> list) {
            if (this.list == null) {
                this.list = list;
                VideoListAdapter.this.notifyDataSetChanged();
                return;
            }
            this.list.clear();
            addData(list);
        }

        private void addData(List<ZuoPingBean.SpBean> list) {
            this.list.addAll(list);
            VideoListAdapter.this.notifyDataSetChanged();
        }

        public ZuoPingBean.SpBean getItem(int position) {
            return list.get(position);
        }

        @Override
        public VideoListAdapter.VideoViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_mall_index_works_layout, parent, false);
            return new VideoListAdapter.VideoViewHolder(view);
        }

        @Override
        public void onBindViewHolder(VideoListAdapter.VideoViewHolder holder, int position) {
            holder.parsingData(list.get(position));
        }

        @Override
        public int getItemCount() {
            return list == null ? 0 : list.size();
        }

        class VideoViewHolder extends RecyclerView.ViewHolder {

            @BindView(R.id.iv_img)
            ImageView ivImg;
            @BindView(R.id.tv_title)
            TextView tvTitle;
            @BindView(R.id.tv_context)
            TextView tvContext;
            @BindView(R.id.tv_price)
            TextView tvPrice;
            @BindView(R.id.tv_sale_count)
            TextView tvSaleCount;
            @BindView(R.id.tv_see_count)
            TextView tvSeeCount;
            @BindView(R.id.iv_video)
            JCVideoPlayerStandard ivVideo;

            VideoViewHolder(View view) {
                super(view);
                ButterKnife.bind(this, view);

                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        JCFullScreenActivity.startActivity(mContext,
                                list.get(getPosition()).getVideo_url(),
                                JCVideoPlayerStandard.class,
                                list.get(getPosition()).getTitle());
                    }
                });
            }

            void parsingData(ZuoPingBean.SpBean videobean) {
                ivImg.setVisibility(View.GONE);
                tvSaleCount.setVisibility(View.GONE);
                ivVideo.setVisibility(View.VISIBLE);
                tvSeeCount.setVisibility(View.VISIBLE);
                tvPrice.setVisibility(View.GONE);
                ivVideo.setUp(videobean.getVideo_url(), videobean.getTitle());
                GlideLoad.GlideLoadImg(mContext, videobean.getCover(), ivVideo.thumbImageView);
                tvTitle.setText(videobean.getTitle() + "");
                tvSeeCount.setText(videobean.getClicked() + "");
            }
        }
    }

    //图册列表适配器
    public class AtlasAdapter extends RecyclerView.Adapter<AtlasAdapter.ViewHolder> {

        private com.jcodecraeer.xrecyclerview.OnItemClickListener mListener;
        private List<ZuoPingBean.TcBean> list;

        public void setData(List<ZuoPingBean.TcBean> list) {
            if (this.list == null) {
                this.list = list;
                this.notifyDataSetChanged();
                return;
            }
            this.list.clear();
            addData(list);
        }

        private void addData(List<ZuoPingBean.TcBean> list) {
            this.list.addAll(list);
            this.notifyDataSetChanged();
        }

        public ZuoPingBean.TcBean getItem(int position) {
            return list.get(position);
        }

        @Override
        public AtlasAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_mall_index_works_layout, parent, false);
            return new AtlasAdapter.ViewHolder(view);
        }

        @Override
        public void onBindViewHolder(AtlasAdapter.ViewHolder holder, int position) {
            holder.parsingData(list.get(position));
        }

        @Override
        public int getItemCount() {
            return list == null ? 0 : list.size();
        }

        class ViewHolder extends RecyclerView.ViewHolder {

            @BindView(R.id.iv_img)
            ImageView ivImg;
            @BindView(R.id.tv_title)
            TextView tvTitle;
            @BindView(R.id.tv_context)
            TextView tvContext;
            @BindView(R.id.tv_price)
            TextView tvPrice;
            @BindView(R.id.tv_sale_count)
            TextView tvSaleCount;
            @BindView(R.id.tv_see_count)
            TextView tvSeeCount;
            @BindView(R.id.iv_video)
            JCVideoPlayerStandard ivVideo;

            ViewHolder(View view) {
                super(view);
                ButterKnife.bind(this, view);

                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        if (list.get(getPosition()).getPhotou().size() > 0 && list.get(getPosition()).getPhotou() != null) {
                            ArrayList<String> url = new ArrayList<>();
                            for (int i = 0; i < list.get(getPosition()).getPhotou().size(); i++) {
                                url.add(list.get(getPosition()).getPhotou().get(i).getPhoto());
                            }
                            FullScreenUtil.showFullScreenDialog(mContext,0,url,false);
                        }
                    }
                });
            }

            void parsingData(ZuoPingBean.TcBean bean) {
                tvSaleCount.setVisibility(View.GONE);
                tvPrice.setVisibility(View.GONE);
                tvContext.setVisibility(View.VISIBLE);
                tvSeeCount.setVisibility(View.VISIBLE);
                tvSeeCount.setText(bean.getClicked() + "");
                tvTitle.setText(bean.getName() + "");
                tvContext.setText(bean.getSynopsis() + "");
                GlideLoad.GlideLoadImg(mContext, bean.getCover(), ivImg);
            }
        }
    }

    //案例列表适配器
    public class CaseAdapter extends RecyclerView.Adapter<CaseAdapter.ViewHolder> {

        private com.jcodecraeer.xrecyclerview.OnItemClickListener mListener;
        private List<ZuoPingBean.AlBean> list;

        public void setData(List<ZuoPingBean.AlBean> list) {
            if (this.list == null) {
                this.list = list;
                this.notifyDataSetChanged();
                return;
            }
            this.list.clear();
            addData(list);
        }

        private void addData(List<ZuoPingBean.AlBean> list) {
            this.list.addAll(list);
            this.notifyDataSetChanged();
        }

        public ZuoPingBean.AlBean getItem(int position) {
            return list.get(position);
        }

        @Override
        public CaseAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_mall_index_works_layout, parent, false);
            return new CaseAdapter.ViewHolder(view);
        }

        @Override
        public void onBindViewHolder(CaseAdapter.ViewHolder holder, int position) {
            holder.parsingData(list.get(position));
        }

        @Override
        public int getItemCount() {
            return list == null ? 0 : list.size();
        }

        class ViewHolder extends RecyclerView.ViewHolder {

            @BindView(R.id.iv_img)
            ImageView ivImg;
            @BindView(R.id.tv_title)
            TextView tvTitle;
            @BindView(R.id.tv_context)
            TextView tvContext;
            @BindView(R.id.tv_price)
            TextView tvPrice;
            @BindView(R.id.tv_sale_count)
            TextView tvSaleCount;
            @BindView(R.id.tv_see_count)
            TextView tvSeeCount;
            @BindView(R.id.iv_video)
            JCVideoPlayerStandard ivVideo;

            ViewHolder(View view) {
                super(view);
                ButterKnife.bind(this, view);
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        Intent intent = new Intent(mContext, ExampleDetailsActivity.class);
                        intent.putExtra("caseid", bean.getAl().get(getPosition()).getId());
                        mContext.startActivity(intent);
                    }
                });
            }

            void parsingData(ZuoPingBean.AlBean bean) {
                tvSaleCount.setVisibility(View.GONE);
                tvSeeCount.setVisibility(View.VISIBLE);
                tvContext.setVisibility(View.VISIBLE);
                tvSeeCount.setText(bean.getClicked() + "");
                tvTitle.setText(bean.getTitle() + "");
                tvContext.setText(bean.getWeddingdescribe() + "");
                tvPrice.setText("￥" + bean.getWeddingexpenses() + "");
                GlideLoad.GlideLoadImg(mContext, bean.getWeddingcover(), ivImg);
            }
        }
    }
}


