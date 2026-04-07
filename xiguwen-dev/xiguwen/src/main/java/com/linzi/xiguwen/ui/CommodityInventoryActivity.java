package com.linzi.xiguwen.ui;

import android.app.Activity;
import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.CommodityInventoryBean;
import com.linzi.xiguwen.utils.NToast;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by PC on 2018-04-12.
 * 商品库存设置界面
 */

public class CommodityInventoryActivity extends BaseActivity {

    @BindView(R.id.recycler_view)
    RecyclerView mRecyclerView;
    @BindView(R.id.ll_parent)
    View mLlParent;
    private ViewHolder mVH;

    private ArrayList<CommodityInventoryBean> mDatas;
    private MyAdapter mAdapter;

    public static void startActivity(Activity activity, ArrayList<CommodityInventoryBean> datas, int requestCode){
        Intent intent = new Intent(activity, CommodityInventoryActivity.class);
        intent.putExtra("datas", datas);
        activity.startActivityForResult(intent, requestCode);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_commodity_inventory);
    }

    @Override
    protected void initData() {
        mDatas = (ArrayList<CommodityInventoryBean>) getIntent().getSerializableExtra("datas");
        if(mDatas == null){
            mDatas = new ArrayList<>();
        }
        setTitle("库存设置");
        setBack();
        setRightAdd(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                addInventory();
            }
        });

        mRecyclerView.setLayoutManager(new LinearLayoutManager(this));
        mAdapter = new MyAdapter();
        mRecyclerView.setAdapter(mAdapter);
    }

    private void addInventory() {
        final PopupWindow pop = new PopupWindow(this);
        if (mVH == null) {
            mVH = new ViewHolder(getLayoutInflater().inflate(R.layout.pop_set_commodity_inventory_layout, null));
        }
        mVH.mIvClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                pop.dismiss();
            }
        });
        mVH.mLlSave.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(check(mVH)){
                    CommodityInventoryBean data = new CommodityInventoryBean();
                    data.setNumber(mVH.mEdInventory.getText().toString().trim());
                    data.setPrices(mVH.mEdPrice.getText().toString().trim());
                    data.setSku1name(mVH.mEdProperty1.getText().toString().trim());
                    data.setSku2name(mVH.mEdProperty2.getText().toString().trim());
                    mDatas.add(data);
                    mAdapter.notifyDataSetChanged();
                    pop.dismiss();
                }
            }
        });
        pop.setOutsideTouchable(false);
        pop.setFocusable(true);
        int w = this.getWindowManager().getDefaultDisplay().getWidth();
        pop.setWidth(w);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0xffff0000);
        pop.setBackgroundDrawable(dw);
        pop.setAnimationStyle(R.style.AnimationPreview);
        pop.setContentView(mVH.mView);
        pop.update();
        pop.showAtLocation(mLlParent, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        lightoff(true);
        pop.setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });
    }

    private boolean check(ViewHolder vh){
        if(TextUtils.isEmpty(vh.mEdProperty1.getText().toString().trim())){
            NToast.show("请输入属性1");
            return false;
        }
        if(TextUtils.isEmpty(vh.mEdPrice.getText().toString().trim())){
            NToast.show("请输入商品价格");
            return false;
        }
        if(TextUtils.isEmpty(vh.mEdInventory.getText().toString().trim())){
            NToast.show("请输入商品价格");
            return false;
        }
        return true;
    }

    @Override
    public void finish() {
        Intent data = new Intent();
        data.putExtra("data", mDatas);
        setResult(RESULT_OK, data);
        super.finish();
    }


    class ViewHolder{

        @BindView(R.id.iv_close)
        ImageView mIvClose;
        @BindView(R.id.ed_property1)
        EditText mEdProperty1;
        @BindView(R.id.ed_property2)
        EditText mEdProperty2;
        @BindView(R.id.ed_price)
        EditText mEdPrice;
        @BindView(R.id.ed_inventory)
        EditText mEdInventory;
        @BindView(R.id.ll_save)
        View mLlSave;

        View mView;
        public ViewHolder(View view){
            mView = view;
            ButterKnife.bind(this, view);
        }
    }

    class MyAdapter extends RecyclerView.Adapter<MyAdapter.VH>{

        @Override
        public VH onCreateViewHolder(ViewGroup parent, int viewType) {
            return new VH(getLayoutInflater().inflate(R.layout.view_commodity_inventory, parent, false));
        }

        @Override
        public void onBindViewHolder(VH holder, int position) {
            CommodityInventoryBean data = mDatas.get(position);
            holder.tvType1.setText(data.getSku1name());
            holder.tvType2.setText(data.getSku2name());
            holder.tvPrice.setText(data.getPrices());
            holder.tvInventory.setText(data.getNumber());
        }

        @Override
        public int getItemCount() {
            return mDatas.size();
        }

        class VH extends RecyclerView.ViewHolder{

            @BindView(R.id.tv_property1)
            TextView tvType1;
            @BindView(R.id.tv_property2)
            TextView tvType2;
            @BindView(R.id.tv_price)
            TextView tvPrice;
            @BindView(R.id.tv_inventory)
            TextView tvInventory;

            public VH(View itemView) {
                super(itemView);
                ButterKnife.bind(this, itemView);
            }
        }
    }
}
