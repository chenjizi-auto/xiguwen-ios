package com.linzi.xiguwen.view;

import android.app.Dialog;
import android.content.Context;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.RenZhengListBean;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by linzi on 2017/8/10.
 */

public class RzDialog extends Dialog {
    Context mContext;
    ViewHolder vh;
    private int choose_id = 0;
    private List<RenZhengListBean.ChengXin> mChengXins;

    public RzDialog(@NonNull Context context) {
        super(context);
        mContext = context;
        initView();
    }

    private void initView() {
        View view = LayoutInflater.from(mContext).inflate(R.layout.dialog_rz, null);
        vh = new ViewHolder(view);
        setContentView(view);
        setCancelable(true);
        setCanceledOnTouchOutside(true);

        Window window = getWindow();
        window.setBackgroundDrawableResource(android.R.color.transparent);

        WindowManager.LayoutParams lp = window.getAttributes();
        lp.height = WindowManager.LayoutParams.WRAP_CONTENT;
        lp.width = getWindow().getWindowManager().getDefaultDisplay().getWidth() / 4 * 3;
        lp.gravity = Gravity.CENTER;
        window.setAttributes(lp);
    }

//    @Override
//    public void setTitle(@Nullable CharSequence title) {
////        super.setTitle(title);
//        vh.tvTitle.setText(title);
//    }

    public RzDialog setMessage(String msg) {
        vh.tvMsg.setText(msg);
        return this;
    }

    public RzDialog setPrice(String msg) {
        vh.tvPrice.setText(msg);
        return this;
    }

    public void setList(List<RenZhengListBean.ChengXin> chengXins){
        this.mChengXins = chengXins;
        MyAdapter adapter = new MyAdapter();
        vh.mRvCx.setLayoutManager(new LinearLayoutManager(getContext()));
        vh.mRvCx.setAdapter(adapter);
    }

    /**
     * 获取选中诚信认证的项
     * @return
     */
    public int getChooseId(){
        return choose_id;
    }

    public void setChooseId(int chooseId){
        this.choose_id = chooseId;

    }

    public RzDialog setCancleListener(View.OnClickListener listener) {
        vh.llClose.setOnClickListener(listener);
        this.dismiss();
        return this;
    }

    public RzDialog setSubmitListener(View.OnClickListener listener) {
        vh.llSubmit.setOnClickListener(listener);
        this.dismiss();
        return this;
    }

    public void showRemark(boolean show){
        if(show){
            vh.llRemark.setVisibility(View.VISIBLE);
        }else{
            vh.llRemark.setVisibility(View.GONE);
        }
    }

    public String getRemark(){
        return vh.etRemark.getText().toString().trim();
    }



    static class ViewHolder {
        @BindView(R.id.tv_msg)
        TextView tvMsg;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.rv_cx)
        RecyclerView mRvCx;
        @BindView(R.id.ll_close)
        LinearLayout llClose;
        @BindView(R.id.ll_submit)
        LinearLayout llSubmit;
        @BindView(R.id.ll_remark)
        LinearLayout llRemark;
        @BindView(R.id.et_remark)
        TextView etRemark;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

    class MyAdapter extends RecyclerView.Adapter<MyAdapter.VH> {

        @Override
        public VH onCreateViewHolder(ViewGroup parent, int viewType) {
            return new VH(getLayoutInflater().inflate(R.layout.view_radio_button, parent, false));
        }

        @Override
        public void onBindViewHolder(VH holder, int position) {
            if(position == choose_id){
                holder.radioButton.setChecked(true);
            }else{
                holder.radioButton.setChecked(false);
            }
            RenZhengListBean.ChengXin chengXin = mChengXins.get(position);
            holder.radioButton.setText(chengXin.getPrice());

        }

        @Override
        public int getItemCount() {
            return mChengXins == null ? 0 : mChengXins.size();
        }

        class VH extends RecyclerView.ViewHolder{

            RadioButton radioButton;

            public VH(View itemView) {
                super(itemView);
                radioButton = (RadioButton) itemView;

                radioButton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        choose_id = getPosition();
                        notifyDataSetChanged();
                    }
                });
            }
        }
    }
}
