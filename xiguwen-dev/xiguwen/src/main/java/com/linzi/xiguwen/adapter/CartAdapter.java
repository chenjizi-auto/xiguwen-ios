package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.os.Handler;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.NToast;
import com.yanzhenjie.recyclerview.swipe.SwipeMenu;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuBridge;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuCreator;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuItem;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuItemClickListener;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuRecyclerView;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;

import static android.view.ViewGroup.LayoutParams.MATCH_PARENT;

/**
 * Created by jiang on 2018/1/29.
 */

public class CartAdapter extends RecyclerView.Adapter<CartAdapter.ViewHolder> {
    Context mContext;
    CallBack.ChooseGoodsListener chooseGoodsListener;

    public CartAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public CartAdapter(Context mContext, CallBack.ChooseGoodsListener chooseGoodsListener) {
        this.mContext = mContext;
        this.chooseGoodsListener = chooseGoodsListener;
    }

    @Override
    public CartAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_cart_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(CartAdapter.ViewHolder vh, int position) {
        vh.tvName.setText("策划师 林子");
        LinearLayoutManager manager=new LinearLayoutManager(mContext){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        vh.goodsRecycle.setLayoutManager(manager);
        vh.goodsRecycle.setSwipeMenuCreator(new SwipeMenuCreator() {
            @Override
            public void onCreateMenu(SwipeMenu swipeLeftMenu, SwipeMenu swipeRightMenu, int viewType) {
                SwipeMenuItem deleteItem = new SwipeMenuItem(mContext);
                deleteItem.setBackgroundColor(mContext.getResources().getColor(R.color.colorTitleRed));
                deleteItem.setHeight(MATCH_PARENT);
                deleteItem.setWidth(dip2px(mContext,100));
                deleteItem.setText("删除");
                deleteItem.setTextColor(mContext.getResources().getColor(R.color.white));
                // 各种文字和图标属性设置。
                swipeRightMenu.addMenuItem(deleteItem); // 在Item左侧添加一个菜单。
            }
        });
        vh.goodsRecycle.setSwipeMenuItemClickListener(new SwipeMenuItemClickListener() {
            @Override
            public void onItemClick(SwipeMenuBridge menuBridge) {
                // 任何操作必须先关闭菜单，否则可能出现Item菜单打开状态错乱。
                menuBridge.closeMenu();

                int direction = menuBridge.getDirection(); // 左侧还是右侧菜单。
                int adapterPosition = menuBridge.getAdapterPosition(); // RecyclerView的Item的position。
                int menuPosition = menuBridge.getPosition(); // 菜单在RecyclerView的Item中的Position。

                NToast.show(""+direction);
            }
        });
        final GoodsAdapter adapter=new GoodsAdapter(vh.cbChoose);
        vh.goodsRecycle.setAdapter(adapter);

        vh.cbChoose.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                adapter.setChooseAll(b);
            }
        });
    }

    @Override
    public int getItemCount() {
        return 10;
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.cb_choose)
        CheckBox cbChoose;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.goods_recycle)
        SwipeMenuRecyclerView goodsRecycle;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

    public class GoodsAdapter extends RecyclerView.Adapter<GoodsAdapter.VH> {
        ArrayList<Integer> select_position = new ArrayList<>();
        boolean chooseAll=false;

        int Choose_id=0;
        CheckBox cb;

        public GoodsAdapter(CheckBox cb) {
            this.cb = cb;
        }

        @Override
        public GoodsAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_goods_cart_layout, parent, false);
            return new VH(view);
        }

        @Override
        public void onBindViewHolder(final GoodsAdapter.VH vh, final int position) {
            GlideLoad.GlideLoadImg(mContext,"http://pic41.nipic.com/20140503/18641501_163214498000_2.jpg",vh.ivImg);
            vh.tvDate.setText("2018-01-09");
            vh.tvTime.setText("中午");
            vh.tvTypePay.setText("定金");
            vh.tvDanjia.setText(Constans.RMB+"2000");
            vh.tvDingjin.setText(Constans.RMB+"2000");
            vh.edNum.setText("1");
            vh.btJia.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    int Num=Integer.valueOf(vh.edNum.getText().toString());
                    Num++;
                    vh.edNum.setText(""+Num);
                }
            });
            vh.btJian.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    int Num=Integer.valueOf(vh.edNum.getText().toString());
                    Num--;
                    if(Num<=0) {
                        Num=1;
                    }
                    vh.edNum.setText(""+Num);
                }
            });
            vh.cbChoose.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
                @Override
                public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                    if(b){
//                        if(!select_position.contains(position)){
//                            select_position.add(position);
                            if(chooseGoodsListener!=null){
                                chooseGoodsListener.chooseListener(position,true);
                            }
                            Choose_id++;
//                        }
                    }else{
//                        if(select_position.contains(position)){
//                            select_position.remove(position);
                            if(chooseGoodsListener!=null){
                                chooseGoodsListener.chooseListener(position,false);
                            }
                            Choose_id--;
//                        }
                    }
                    if(Choose_id==getItemCount()){
                        chooseAll=true;
                        cb.setChecked(true);
                    }else{
                        chooseAll=false;
                        cb.setChecked(false);
                    }
                }
            });
            vh.cbChoose.setChecked(chooseAll);
        }

        public void setChooseAll(boolean choose){
            chooseAll=choose;
            Handler handler = new Handler();
            final Runnable r = new Runnable() {
                public void run() {
                    notifyItemChanged(getItemCount() - 1);
                }
            };
            handler.post(r);
        }
//        private void specialUpdate() {
//
//        }


        @Override
        public int getItemCount() {
            return 3;
        }

        class VH extends RecyclerView.ViewHolder {
            @BindView(R.id.cb_choose)
            CheckBox cbChoose;
            @BindView(R.id.iv_img)
            ImageView ivImg;
            @BindView(R.id.tv_name)
            TextView tvName;
            @BindView(R.id.tv_date)
            TextView tvDate;
            @BindView(R.id.tv_time)
            TextView tvTime;
            @BindView(R.id.tv_type_pay)
            TextView tvTypePay;
            @BindView(R.id.tv_danjia)
            TextView tvDanjia;
            @BindView(R.id.tv_dingjin)
            TextView tvDingjin;
            @BindView(R.id.bt_jian)
            Button btJian;
            @BindView(R.id.ed_num)
            EditText edNum;
            @BindView(R.id.bt_jia)
            Button btJia;

            VH(View view) {
                super(view);
                ButterKnife.bind(this, view);
            }
        }
    }

    //将dp转换为px
    public  int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }
}
