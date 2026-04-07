package com.linzi.xiguwen.view;

import android.content.Context;
import androidx.annotation.Nullable;
import android.util.AttributeSet;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.AtlasBean;
import com.linzi.xiguwen.bean.BaseStatusBean;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by PC on 2018-03-29.
 */

public class MineDetailControlView extends LinearLayout {
    @BindView(R.id.ll_weitijiao_yulan)
    LinearLayout llWeitijiaoYulan;
    @BindView(R.id.ll_weitijiao_edit)
    LinearLayout llWeitijiaoEdit;
    @BindView(R.id.ll_weitijiao_del)
    LinearLayout llWeitijiaoDel;
    @BindView(R.id.iv_end_icon)
    ImageView ivEndIcon;
    @BindView(R.id.tv_end_txt)
    TextView tvEndTxt;
    @BindView(R.id.ll_weitijiao_submit)
    LinearLayout llWeitijiaoSubmit;
    @BindView(R.id.ll_weitijiao)
    LinearLayout llWeitijiao;


    private BaseStatusBean mData;
    private OnControlListener mListener;

    public MineDetailControlView(Context context) {
        super(context);
        init();
    }

    public MineDetailControlView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    public MineDetailControlView(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init();
    }

    private void init(){
        inflate(getContext(), R.layout.view_mine_detail_control, this);
        ButterKnife.bind(this);
        setVisibility(View.GONE);
    }

    public void setData(BaseStatusBean bean){
        mData = bean;

        if(mData == null){
            setVisibility(View.GONE);
        }else{
            setVisibility(View.VISIBLE);
            refreshView();
        }
    }

    public void setOnControlListener(OnControlListener listener){
        this.mListener = listener;
    }

    private void refreshView(){
        llWeitijiao.setVisibility(VISIBLE);
        llWeitijiaoDel.setVisibility(VISIBLE);
        llWeitijiaoEdit.setVisibility(VISIBLE);
        llWeitijiaoSubmit.setVisibility(VISIBLE);
        llWeitijiaoYulan.setVisibility(VISIBLE);
        switch (mData.getMyState()){
            case BaseStatusBean.STATE_NO_SUBMIT_0: //待提交审核
                tvEndTxt.setText("提交审核");
                break;
            case BaseStatusBean.STATE_ON:// 审核中
                llWeitijiaoSubmit.setVisibility(View.GONE);
                break;
            case BaseStatusBean.STATE_PASS:// 审核通过
                if(mData.getMyStatus() == AtlasBean.STATUS_PUT_OFF_SHELVES){
                    ivEndIcon.setBackgroundDrawable(getResources().getDrawable(R.mipmap.icon_baojia_shangjia));
                    tvEndTxt.setText("上架");
                }else{
                    llWeitijiaoEdit.setVisibility(View.GONE);
                    llWeitijiaoDel.setVisibility(View.GONE);
                    ivEndIcon.setBackgroundDrawable(getResources().getDrawable(R.mipmap.icon_baojia_xiajia));
                    tvEndTxt.setText("下架");
                }
                break;
            case BaseStatusBean.STATE_FAILED: // 审核失败
                ivEndIcon.setBackgroundDrawable(getResources().getDrawable(R.mipmap.icon_baojia_chakan));
                tvEndTxt.setText("查看原因");
                break;
        }

        llWeitijiaoYulan.setVisibility(View.GONE);
    }


    @OnClick({R.id.ll_weitijiao_yulan, R.id.ll_weitijiao_edit, R.id.ll_weitijiao_del, R.id.ll_weitijiao_submit})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_weitijiao_yulan:
                if(mListener != null){
                    mListener.onPreview();
                }
                break;
            case R.id.ll_weitijiao_edit:
                if(mListener != null){
                    mListener.onEdit();
                }
                break;
            case R.id.ll_weitijiao_del:
                if(mListener != null){
                    mListener.onDelete();
                }
                break;
            case R.id.ll_weitijiao_submit:
                if(mData.getMyState() == BaseStatusBean.STATE_NO_SUBMIT_0 || mData.getMyState() == BaseStatusBean.STATE_NO_SUBMIT_4){ // 未提交
                    if(mListener != null){
                        mListener.onSubmit();
                    }
                }else if(mData.getMyState() == BaseStatusBean.STATE_FAILED){ // 审核失败
                    if(mListener != null){
                        mListener.onShowReason();
                    }
                }else{  //审核通过
                    if(mData.getMyStatus() == BaseStatusBean.STATUS_PUT_ON_SHELVES){ // 已上架
                        if(mListener != null){
                            mListener.onPutOffShelves();
                        }
                    }else{  // 已下架
                        if(mListener != null){
                            mListener.onPutOnShelves();
                        }
                    }
                }
                break;
        }
    }


    public interface OnControlListener{
        /**
         * 预览
         */
        void onPreview();

        /**
         * 编辑
         */
        void onEdit();

        /**
         * 删除
         */
        void onDelete();

        /**
         * 提交
         */
        void onSubmit();

        /**
         * 上架
         */
        void onPutOnShelves();

        /**
         * 下架
         */
        void onPutOffShelves();

        /**
         * 查看原因
         */
        void onShowReason();
    }
}
