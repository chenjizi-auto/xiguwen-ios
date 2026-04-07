package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.content.Intent;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.hedgehog.ratingbar.RatingBar;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.ShopUserDetailsBean;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.BaijiaDetailsActivity;
import com.linzi.xiguwen.ui.ExampleDetailsActivity;
import com.linzi.xiguwen.ui.MallDetailsActivity;
import com.linzi.xiguwen.utils.FullScreenUtil;
import com.linzi.xiguwen.utils.GlideLoad;


import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/4.
 */

public class MallIndexAdapter extends RecyclerView.Adapter<MallIndexAdapter.ViewHolder> {
    Context mContext;
    private int baojianum = 0;//报价总数
    private int pinglunshu = 0;//评论总数
    private int morecasenum = 0;//更多案例总数
    private ShopUserDetailsBean bean;

    public void setData(ShopUserDetailsBean bean) {
        this.bean = bean;
        notifyDataSetChanged();
    }

    public MallIndexAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public MallIndexAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_club_someone_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MallIndexAdapter.ViewHolder vh, int position) {
        if (bean.getZuoping() != null)
            morecasenum = bean.getZuoping().getZongshu();
        if (bean.getPinglun() != null && bean.getPinglun().size() != 0)
            pinglunshu = bean.getPinglun().size();
        if (bean.getBaojia() != null)
            baojianum = bean.getBaojia().getZongshu();
        switch (position) {
            case 0:
                vh.llMore.setVisibility(View.GONE);
                vh.tvMoreSome.setText("更多报价");
                vh.tvZhiwei.setText("商品报价（" + baojianum + "）");
                vh.tvMore.setVisibility(View.GONE);
                BaojiaAdapter adapter = new BaojiaAdapter();
                GridLayoutManager manager = new GridLayoutManager(mContext, 2) {
                    @Override
                    public boolean canScrollVertically() {
                        return false;
                    }
                };
                vh.recycle.setLayoutManager(manager);
                vh.recycle.setAdapter(adapter);
                adapter.setbaojiaBeanList(bean.getBaojia().getBaojia());
                break;
            case 1:
                vh.llMore.setVisibility(View.GONE);
                vh.tvMoreSome.setText("更多案例");
                vh.tvZhiwei.setText("作品案例（" + morecasenum + "）");
                vh.tvMore.setVisibility(View.GONE);
                ExampleOrWorksAdapter adapter2 = new ExampleOrWorksAdapter();
                GridLayoutManager manager2 = new GridLayoutManager(mContext, 2) {
                    @Override
                    public boolean canScrollVertically() {
                        return false;
                    }
                };
                vh.recycle.setLayoutManager(manager2);
                vh.recycle.setAdapter(adapter2);
                adapter2.setzuopingBeanList(bean.getZuoping().getZuopin());
                break;
            case 2:
                vh.llMore.setVisibility(View.GONE);
                vh.tvMoreSome.setText("查看全部20条用户评价");
                vh.tvZhiwei.setText("用户评价（" + pinglunshu + "）");
                vh.tvMore.setVisibility(View.GONE);
                LinearLayoutManager manager3 = new LinearLayoutManager(mContext) {
                    @Override
                    public boolean canScrollVertically() {
                        return false;
                    }
                };
                vh.recycle.setLayoutManager(manager3);
                PingjiaAdapter adapter3 = new PingjiaAdapter();
                vh.recycle.setAdapter(adapter3);
                adapter3.setPingjiaData(bean.getPinglun());
                break;
            case 3:
                vh.llMore.setVisibility(View.GONE);
                vh.tvZhiwei.setText("推荐团队");
                vh.tvMore.setVisibility(View.GONE);
                GridLayoutManager manager4 = new GridLayoutManager(mContext, 3) {
                    @Override
                    public boolean canScrollVertically() {
                        return false;
                    }
                };
                vh.recycle.setLayoutManager(manager4);
                TuiJianTeamAdapter adapter4 = new TuiJianTeamAdapter();
                vh.recycle.setAdapter(adapter4);
                adapter4.setTeamData(bean.getTuijiantd());
                break;
        }
    }

    @Override
    public int getItemCount() {
        if (bean == null) {
            return 0;
        } else {
            return 4;
        }
    }

    class ViewHolder extends RecyclerView.ViewHolder {
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

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

    public class BaojiaAdapter extends RecyclerView.Adapter<BaojiaAdapter.VH> {
        private List<ShopUserDetailsBean.BaojiaBeanX.BaojiaBean> baojiaBeanList;

        public void setbaojiaBeanList(List<ShopUserDetailsBean.BaojiaBeanX.BaojiaBean> baojiaBeanList) {
            this.baojiaBeanList = baojiaBeanList;
            this.notifyDataSetChanged();
        }

        @Override
        public BaojiaAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_mall_index_works_layout, parent, false);
            return new VH(view);
        }

        @Override
        public void onBindViewHolder(BaojiaAdapter.VH vh, int position) {

            vh.tvContext.setVisibility(View.GONE);
            vh.tvSaleCount.setVisibility(View.VISIBLE);
            vh.tvSeeCount.setVisibility(View.GONE);
            vh.tvSaleCount.setText("已售 " + baojiaBeanList.get(position).getNum());
            vh.tvPrice.setText(Constans.RMB + baojiaBeanList.get(position).getPrice());
            vh.tvTitle.setText("" + baojiaBeanList.get(position).getName());
            GlideLoad.GlideLoadImg(mContext, baojiaBeanList.get(position).getImglist(), vh.ivImg);
            vh.tvTitle.setText("" + baojiaBeanList.get(position).getName());
            vh.tvPrice.setText(Constans.RMB + baojiaBeanList.get(position).getPrice() + "");
        }

        @Override
        public int getItemCount() {
            if (baojiaBeanList == null) {
                return 0;
            } else {
                return baojiaBeanList.size();
            }
        }

        class VH extends RecyclerView.ViewHolder {
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

            VH(View view) {
                super(view);
                ButterKnife.bind(this, view);

                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        mContext.startActivity(new Intent(mContext, BaijiaDetailsActivity.class));
                    }
                });
            }
        }
    }

    public class ExampleOrWorksAdapter extends RecyclerView.Adapter<ExampleOrWorksAdapter.VH> {
        private List<ShopUserDetailsBean.ZuopingBean.ZuopinBean> zuopingBeanList;


        public void setzuopingBeanList(List<ShopUserDetailsBean.ZuopingBean.ZuopinBean> zuopingBeanList) {
            this.zuopingBeanList = zuopingBeanList;
            this.notifyDataSetChanged();
        }

        @Override
        public ExampleOrWorksAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_mall_index_works_layout, parent, false);
            return new VH(view);
        }

        @Override
        public void onBindViewHolder(ExampleOrWorksAdapter.VH vh, int position) {
            vh.tvContext.setVisibility(View.VISIBLE);
            vh.tvSaleCount.setVisibility(View.GONE);
            vh.tvSeeCount.setVisibility(View.VISIBLE);
            vh.tvContext.setText("" + zuopingBeanList.get(position).getWeddingdescribe());
            vh.tvSeeCount.setText("" + zuopingBeanList.get(position).getClicked());
            GlideLoad.GlideLoadImg(mContext, zuopingBeanList.get(position).getWeddingcover(), vh.ivImg);
            vh.tvTitle.setText("" + zuopingBeanList.get(position).getTitle());
            vh.tvPrice.setText(Constans.RMB + zuopingBeanList.get(position).getWeddingexpenses() + "");
        }

        @Override
        public int getItemCount() {
            if (zuopingBeanList == null) {
                return 0;
            } else {
                return zuopingBeanList.size();
            }
        }

        class VH extends RecyclerView.ViewHolder {
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

            VH(View view) {
                super(view);
                ButterKnife.bind(this, view);

                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        Intent intent = new Intent(mContext, ExampleDetailsActivity.class);
                        intent.putExtra("caseid", zuopingBeanList.get(getPosition()).getId());
                        mContext.startActivity(intent);
                    }
                });
            }
        }
    }

    public class PingjiaAdapter extends RecyclerView.Adapter<PingjiaAdapter.VHRePly> {
        private List<ShopUserDetailsBean.PinglunBean> pinglunBeanList;


        public void setPingjiaData(List<ShopUserDetailsBean.PinglunBean> pinglunBeanList) {
            this.pinglunBeanList = pinglunBeanList;
            notifyDataSetChanged();
        }

        @Override
        public PingjiaAdapter.VHRePly onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_reply_mall_layout2, parent, false);
            return new VHRePly(view);
        }

        @Override
        public void onBindViewHolder(PingjiaAdapter.VHRePly vh, int position) {
            GlideLoad.GlideLoadCircle(mContext, pinglunBeanList.get(position).getHead(), vh.ivHead);
            vh.tvName.setText("" + pinglunBeanList.get(position).getNickname());
            vh.tvTime.setText("" + pinglunBeanList.get(position).getCreated_at());
            vh.ratingbar.setStar(pinglunBeanList.get(position).getOrder_score());
            vh.tvStarCount.setText(pinglunBeanList.get(position).getOrder_score() + "分");
            vh.tvContext.setText(pinglunBeanList.get(position).getContent());

            final ArrayList<String> url = new ArrayList<>();
            for (int i = 0; i < pinglunBeanList.get(position).getPictures().size(); i++) {
                url.add(pinglunBeanList.get(position).getPictures().get(i));
            }
            GridLayoutManager manager = new GridLayoutManager(mContext, 3) {
                @Override
                public boolean canScrollVertically() {
                    return false;
                }
            };
            vh.recyclerView.setLayoutManager(manager);
            PingjiaImgAdapter adapter = new PingjiaImgAdapter(new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
                @Override
                public void onItemClick(View view, int postion) {
                    FullScreenUtil.showFullScreenDialog(mContext,postion,url,false);
                }
            }, mContext);
            vh.recyclerView.setAdapter(adapter);
            adapter.setPingJiaUrl(url);
            // vh.tvReply.setText("商家回复：非常高兴能为您带来优质的服务，我们准备着为你们主持的，不单单是一场婚礼，还是会是你们记忆中最珍贵，最浪漫的回忆。");
        }

        @Override
        public int getItemCount() {
            if (pinglunBeanList == null) {
                return 0;
            } else {
                return pinglunBeanList.size();
            }
        }

        class VHRePly extends RecyclerView.ViewHolder {
            @BindView(R.id.iv_head)
            ImageView ivHead;
            @BindView(R.id.tv_name)
            TextView tvName;
            @BindView(R.id.tv_time)
            TextView tvTime;
            @BindView(R.id.ratingbar)
            RatingBar ratingbar;
            @BindView(R.id.tv_star_count)
            TextView tvStarCount;
            @BindView(R.id.ll_pic)
            LinearLayout llPic;
            @BindView(R.id.tv_reply)
            TextView tvReply;
            @BindView(R.id.tv_context)
            TextView tvContext;
            @BindView(R.id.recycleview)
            RecyclerView recyclerView;

            VHRePly(View view) {
                super(view);
                ButterKnife.bind(this, view);
            }
        }
    }

    public class TuiJianTeamAdapter extends RecyclerView.Adapter<TuiJianTeamAdapter.VHTeam> {
        private List<ShopUserDetailsBean.TuijiantdBean> teamList;

        public void setTeamData(List<ShopUserDetailsBean.TuijiantdBean> teamList) {
            this.teamList = teamList;
            notifyDataSetChanged();
        }

        @Override
        public TuiJianTeamAdapter.VHTeam onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_tuijian_team_layout, parent, false);
            return new VHTeam(view);
        }

        @Override
        public void onBindViewHolder(TuiJianTeamAdapter.VHTeam vh, int position) {
            GlideLoad.GlideLoadCircle(mContext, teamList.get(position).getHead(), vh.ivHead);
            vh.tvName.setText("" + teamList.get(position).getNickname());
            vh.tvZhiwei.setText("" + teamList.get(position).getOccupationid());
            vh.btPrice.setText(Constans.RMB + teamList.get(position).getZuidijia() + "起");
        }

        @Override
        public int getItemCount() {
            if (teamList == null) {
                return 0;
            } else {
                return teamList.size();
            }
        }

        class VHTeam extends RecyclerView.ViewHolder {
            @BindView(R.id.iv_head)
            ImageView ivHead;
            @BindView(R.id.tv_name)
            TextView tvName;
            @BindView(R.id.tv_zhiwei)
            TextView tvZhiwei;
            @BindView(R.id.bt_price)
            Button btPrice;

            VHTeam(View view) {
                super(view);
                ButterKnife.bind(this, view);

                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        Intent intent = new Intent(mContext, MallDetailsActivity.class);
                        intent.putExtra("shop_id", teamList.get(getPosition()).getUserid());
                        mContext.startActivity(intent);
                    }
                });
            }
        }
    }

    public class PingjiaImgAdapter extends RecyclerView.Adapter<PingjiaImgAdapter.ImgVh> {


        private com.jcodecraeer.xrecyclerview.OnItemClickListener listener;
        private ArrayList<String> pingjiaurl;
        private Context mContext;

        public void setPingJiaUrl(ArrayList<String> pingjiaurl) {
            this.pingjiaurl = pingjiaurl;
            notifyDataSetChanged();
        }

        public PingjiaImgAdapter(com.jcodecraeer.xrecyclerview.OnItemClickListener listener, Context mContext) {
            this.listener = listener;
            this.mContext = mContext;
        }

        @Override
        public PingjiaImgAdapter.ImgVh onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.pingjia_img_item, parent, false);
            return new PingjiaImgAdapter.ImgVh(view);
        }

        @Override
        public void onBindViewHolder(PingjiaImgAdapter.ImgVh holder, int position) {
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
            @BindView(R.id.imgimage)
            ImageView imgimage;

            ImgVh(View view) {
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
            }
        }
    }
}
