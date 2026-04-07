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
import com.linzi.xiguwen.bean.CaseDetailsBean;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.ExampleDetailsActivity;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
import com.linzi.xiguwen.utils.FullScreenUtil;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.NToast;


import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/4.
 */

public class ExampleDetailsAdapter extends RecyclerView.Adapter<ExampleDetailsAdapter.ViewHolder> {
    Context mContext;
    private int pinglunshu = 0;//评论总数
    private int morecasenum = 0;//更多案例总数
    private List<CaseDetailsBean.DataBean.PinglunBean> pinglunBeanList;
    private List<CaseDetailsBean.DataBean.GdanliBean> gdanliBeanList;
    private List<CaseDetailsBean.DataBean.TeamBean> teamList;


    public void setPinglunshu(int pinglunshu) {
        this.pinglunshu = pinglunshu;
        this.notifyDataSetChanged();
    }

    public void setmorecasenum(int morecasenum) {
        this.morecasenum = morecasenum;
        this.notifyDataSetChanged();
    }

    public void setGdanliBeanList(List<CaseDetailsBean.DataBean.GdanliBean> gdanliBeanList) {
        this.gdanliBeanList = gdanliBeanList;
        this.notifyDataSetChanged();
    }

    public void setPingjiaData(List<CaseDetailsBean.DataBean.PinglunBean> pinglunBeanList) {
        this.pinglunBeanList = pinglunBeanList;
        notifyDataSetChanged();
    }

    public void setTeamData(List<CaseDetailsBean.DataBean.TeamBean> teamList) {
        this.teamList = teamList;
        notifyDataSetChanged();
    }


    public ExampleDetailsAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public ExampleDetailsAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_club_someone_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ExampleDetailsAdapter.ViewHolder vh, final int position) {
        switch (position) {
            case 2:
                vh.llMore.setVisibility(View.GONE);
                vh.tvMoreSome.setText("更多案例");
                vh.tvZhiwei.setText("商家其他案例（" + morecasenum + "）");
                vh.tvMore.setVisibility(View.GONE);
                ExampleOrWorksAdapter adapter2 = new ExampleOrWorksAdapter(1);
                GridLayoutManager manager2 = new GridLayoutManager(mContext, 2) {
                    @Override
                    public boolean canScrollVertically() {
                        return false;
                    }
                };
                vh.recycle.setLayoutManager(manager2);
                vh.recycle.setAdapter(adapter2);
                break;
            case 1:
                vh.llMore.setVisibility(View.GONE);
                vh.tvMoreSome.setText("查看全部" + pinglunshu + "条用户评价");
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
                break;
            case 0:
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
                break;
        }
    }

    @Override
    public int getItemCount() {
        return 3;
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

    public class ExampleOrWorksAdapter extends RecyclerView.Adapter<ExampleOrWorksAdapter.VH> {

        private int type = 0;

        public ExampleOrWorksAdapter(int type) {
            this.type = type;

        }

        @Override
        public ExampleOrWorksAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_mall_index_works_layout, parent, false);
            return new VH(view);
        }

        @Override
        public void onBindViewHolder(ExampleOrWorksAdapter.VH vh, int position) {
            if (type == 0) {
                vh.tvContext.setVisibility(View.GONE);
                vh.tvSaleCount.setVisibility(View.VISIBLE);
                vh.tvSeeCount.setVisibility(View.GONE);
                vh.tvSaleCount.setText("已售 " + 100);
            } else if (type == 1) {
                vh.tvContext.setVisibility(View.VISIBLE);
                vh.tvSaleCount.setVisibility(View.GONE);
                vh.tvSeeCount.setVisibility(View.VISIBLE);
                vh.tvContext.setText("" + gdanliBeanList.get(position).getWeddingdescribe());
                vh.tvSeeCount.setText("" + gdanliBeanList.get(position).getClicked());
            }
            GlideLoad.GlideLoadImg(mContext, gdanliBeanList.get(position).getWeddingcover(), vh.ivImg);
            vh.tvTitle.setText("" + gdanliBeanList.get(position).getTitle());
            vh.tvPrice.setText(Constans.RMB + gdanliBeanList.get(position).getWeddingexpenses() + "");
        }

        @Override
        public int getItemCount() {
            if (gdanliBeanList == null) {
                return 0;
            } else {
                return gdanliBeanList.size();
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
                        intent.putExtra("caseid", gdanliBeanList.get(getPosition()).getId());
                        mContext.startActivity(intent);
                    }
                });
            }
        }
    }

    public class PingjiaAdapter extends RecyclerView.Adapter<PingjiaAdapter.VHRePly> {

        @Override
        public PingjiaAdapter.VHRePly onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_reply_mall_layout2, parent, false);
            return new VHRePly(view);
        }

        @Override
        public void onBindViewHolder(PingjiaAdapter.VHRePly vh, int position) {
            GlideLoad.GlideLoadCircle(mContext, pinglunBeanList.get(position).getTouxiang(), vh.ivHead);
            vh.tvName.setText("" + pinglunBeanList.get(position).getName());
            vh.tvTime.setText("" + pinglunBeanList.get(position).getSsj());
            vh.ratingbar.setStar(pinglunBeanList.get(position).getPingfen());
            vh.tvStarCount.setText(pinglunBeanList.get(position).getPingfen() + "分");
            vh.tvContext.setText(pinglunBeanList.get(position).getComment());

            GridLayoutManager manager = new GridLayoutManager(mContext, 3) {
                @Override
                public boolean canScrollVertically() {
                    return false;
                }
            };
            final ArrayList<String> url = new ArrayList<>();
            for (int i = 0; i < pinglunBeanList.get(position).getCommphoto().size(); i++) {
                url.add(pinglunBeanList.get(position).getCommphoto().get(i));
            }
            NToast.log("TAG  SIZE", "" + url.size());
            vh.recyclerView.setLayoutManager(manager);
            PingjiaImgAdapter adapter = new PingjiaImgAdapter(new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
                @Override
                public void onItemClick(View view, int postion) {
                    FullScreenUtil.showFullScreenDialog(mContext,postion,url);
                }
            }, mContext);
            vh.recyclerView.setAdapter(adapter);
            adapter.setPingJiaUrl(url);
            //vh.tvReply.setText("商家回复：非常高兴能为您带来优质的服务，我们准备着为你们主持的，不单单是一场婚礼，还是会是你们记忆中最珍贵，最浪漫的回忆。");
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
            vh.btPrice.setText(Constans.RMB + teamList.get(position).getZuidiqijia() + "起");
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
                        Intent intent = new Intent(mContext, NewMallDetailsActivity.class);
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
