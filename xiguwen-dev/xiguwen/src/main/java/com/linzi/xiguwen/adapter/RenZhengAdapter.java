package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.RenZhengListBean;
import com.linzi.xiguwen.fragment.RenZhengFragment;
import com.linzi.xiguwen.utils.DPUtils;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by PC on 2018-03-27.
 */

public class RenZhengAdapter extends RecyclerView.Adapter<RenZhengAdapter.ViewHolder> {

    private Context mContext;
    private List<RenZhengListBean.RenZhengBean> mDatas;
    private LayoutInflater mInflater;
    private OnItemClickListener mListener;  //条目点击事件
    private int mTag;

    public RenZhengAdapter(Context context, List<RenZhengListBean.RenZhengBean> datas, int tag){
        this.mContext = context;
        this.mDatas = datas;
        mInflater = LayoutInflater.from(mContext);
        this.mTag = tag;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        return new ViewHolder(mInflater.inflate(R.layout.item_renzheng, parent, false));
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        holder.setData(mDatas.get(position));
    }

    public void setOnItemClickListener(OnItemClickListener listener){
        this.mListener = listener;
    }

    @Override
    public int getItemCount() {
        return mDatas == null ? 0 : mDatas.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {

        @BindView(R.id.iv_rz_img)
        ImageView mIvImg;           //认证图片

        @BindView(R.id.tv_label)
        TextView tvLabel;           //认证名称

        @BindView(R.id.ll_star)
        LinearLayout ll_star;           //认证名称
        @BindView(R.id.tv_rz_type)
        TextView mTvName;           //认证名称
        @BindView(R.id.tv_notice)
        TextView mTvHint;           //认证提示
        @BindView(R.id.tv_is_rz)
        TextView mTvIsRenZheng;     //是否已经认证
        @BindView(R.id.bt_to_rz)
        Button mBtnControl;         // 认证操作

        private RenZhengListBean.RenZhengBean mData;


        public ViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
            mBtnControl.setOnClickListener(this);
        }

        public void setData(RenZhengListBean.RenZhengBean data){
            this.mData = data;
            if(mTag == RenZhengFragment.TAG_RENZHENG_XUEYUAN){
                mTvName.setText(mData.getParameter1());
                switch (mData.getState()){
                    case RenZhengListBean.RenZhengBean.STATE_XY_NO: // 未认证
                        mTvHint.setText("");
                        mTvHint.setVisibility(View.GONE);
                        mBtnControl.setVisibility(View.VISIBLE);
                        mTvIsRenZheng.setVisibility(View.GONE);
                        mBtnControl.setText("立即报名");
                        break;
                    case RenZhengListBean.RenZhengBean.STATE_XY_PASS:    // 已通过
                        mTvHint.setText("");
                        mTvHint.setVisibility(View.GONE);
                        mBtnControl.setVisibility(View.GONE);
                        mTvIsRenZheng.setVisibility(View.VISIBLE);
                        mTvIsRenZheng.setText("已通过");
                        break;
                    case RenZhengListBean.RenZhengBean.STATE_XY_UNPASS:    // 未通过
                        mTvHint.setText("（审核失败）");
                        mTvHint.setVisibility(View.VISIBLE);
                        mBtnControl.setVisibility(View.VISIBLE);
                        mTvIsRenZheng.setVisibility(View.GONE);
                        mBtnControl.setText("重新报名");
                        break;
                    case RenZhengListBean.RenZhengBean.STATE_XY_ON:    // 审核中
                        mTvHint.setText("（审核中）");
                        mTvHint.setVisibility(View.VISIBLE);
                        mBtnControl.setVisibility(View.VISIBLE);
                        mTvIsRenZheng.setVisibility(View.GONE);
                        mBtnControl.setText("查看资料");
                        break;
                    case RenZhengListBean.RenZhengBean.STATE_XY_NOTSUBMIT:    // 未提交资料
                        mTvHint.setText("（已缴费，未提交材料）");
                        mTvHint.setVisibility(View.VISIBLE);
                        mBtnControl.setVisibility(View.VISIBLE);
                        mTvIsRenZheng.setVisibility(View.GONE);
                        mBtnControl.setText("提交资料");
                        break;
                }
            }else if(mTag == RenZhengFragment.TAG_RENZHENG_CHENGXIN){
                mTvName.setText("诚信认证");
                switch (mData.getState()){
                    case RenZhengListBean.RenZhengBean.STATE_NO: // 未认证
                        mTvHint.setText("");
                        mTvHint.setVisibility(View.GONE);
                        mBtnControl.setVisibility(View.VISIBLE);
                        mTvIsRenZheng.setVisibility(View.GONE);
                        mBtnControl.setText("立即认证");
                        break;
                    case RenZhengListBean.RenZhengBean.STATE_REFUND:    // 已退款
                        mTvHint.setText("（已退款）");
                        mTvHint.setVisibility(View.VISIBLE);
                        mBtnControl.setVisibility(View.VISIBLE);
                        mTvIsRenZheng.setVisibility(View.GONE);
                        mBtnControl.setText("重新认证");
                        break;
                    case RenZhengListBean.RenZhengBean.STATE_FINISH:    // 认证完成
                    case RenZhengListBean.RenZhengBean.STATE_ON:    // 审核中
                        mBtnControl.setVisibility(View.VISIBLE);
                        mTvIsRenZheng.setVisibility(View.GONE);
                        mBtnControl.setText("退保证金");
                        break;
                }
            }else{ // 平台认证
                mTvName.setText(mData.getParameter1());
                mTvHint.setText("");
                switch (mData.getState()){
                    case RenZhengListBean.RenZhengBean.STATE_NO: // 未认证
                    case RenZhengListBean.RenZhengBean.STATE_REFUND:    // 已退款
                        mBtnControl.setVisibility(View.VISIBLE);
                        mTvIsRenZheng.setVisibility(View.GONE);
                        mBtnControl.setText("立即认证");
                        break;
                    case RenZhengListBean.RenZhengBean.STATE_ON:    // 审核中
                        mBtnControl.setVisibility(View.GONE);
                        mTvIsRenZheng.setVisibility(View.VISIBLE);
                        mTvIsRenZheng.setText("审核中");
                        break;
                    case RenZhengListBean.RenZhengBean.STATE_FINISH:    // 认证完成
                        mBtnControl.setVisibility(View.GONE);
                        mTvIsRenZheng.setVisibility(View.VISIBLE);
                        mTvIsRenZheng.setText("已认证");
                        break;
                }
            }

            if (mTag != RenZhengFragment.TAG_RENZHENG_XUEYUAN){
                mIvImg.setVisibility(View.VISIBLE);
                mIvImg.setImageResource(getImgId(mData.getParameter1()));
                tvLabel.setVisibility(View.GONE);
            }else{
                mIvImg.setVisibility(View.GONE);
                tvLabel.setVisibility(View.VISIBLE);
                tvLabel.setText(mData.getParameter3());

                String star = mData.getStar();
                if (!TextUtils.isEmpty(star)){
                    int s = Integer.valueOf(star).intValue();
                    ll_star.removeAllViews();
                    for (int i = 0; i <7; i++) {
                        ImageView imageView = new ImageView(tvLabel.getContext());
                        if (i<s){
                            imageView.setImageResource(R.mipmap.star_full);
                        }else {
                            imageView.setImageResource(R.mipmap.star_empty);
                        }
                        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(DPUtils.dip2px(mContext,14), DPUtils.dip2px(mContext,14));
                        params.leftMargin = 5;
                        imageView.setLayoutParams(params);
                        ll_star.addView(imageView);
                    }
                }


            }

        }

        @Override
        public void onClick(View view) {
            if(mListener != null){
                mListener.onClick(mData, getPosition());
            }
        }
    }

    public int getImgId(String name){
        switch (name){
            case "平台认证":
                return R.mipmap.icon_rz_pingtai;
            case "诚信认证1":
            case "诚信认证2":
            case "诚信认证3":
                return R.mipmap.icon_rz_chengxing;
            case "初级认证":
                return R.mipmap.icon_rz_chuji;
            case "中级认证":
                return R.mipmap.icon_rz_zhongji;
            case "高级认证":
                return R.mipmap.icon_rz_gaoji;
            case "总监认证":
                return R.mipmap.icon_rz_zongjie;
            case "大师认证":
                return R.mipmap.icon_rz_dashi;
            case "皇冠大师":
                return R.mipmap.icon_rz_huangguan;
            case "超凡大师":
                return R.mipmap.icon_rz_chaofan;
            case "一星白银团队认证":
                return R.mipmap.icon_rz_yixing;
            case "二星黄金团队认证":
                return R.mipmap.icon_rz_erxing;
            case "三星白金团队认证":
                return R.mipmap.icon_rz_sanxing;
            case "四星钻石团队认证":
                return R.mipmap.icon_rz_sixing;
            case "五星大师团队认证":
                return R.mipmap.icon_rz_wuxing;
            case "六星皇冠团队认证":
                return R.mipmap.icon_rz_liuxing;
            case "七星至尊团队认证":
                return R.mipmap.icon_rz_qixing;
        }
        return R.mipmap.icon_rz_pt;
    }

    public interface OnItemClickListener{
        void onClick(RenZhengListBean.RenZhengBean data, int position);
    }
}
