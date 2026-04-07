package com.linzi.xiguwen.widget;

import android.app.Activity;
import android.app.Dialog;
import android.os.Handler;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.widget.EditText;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.NToast;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2019/3/5.
 */

public class GetPayPop extends Dialog {

    private View view;
    private Activity context;
    private ViewHolder viewHolder;
    private GetPriceCallBack callBack;

    public GetPayPop(Activity context, GetPriceCallBack callBack, String amount_balance) {
        super(context);
        this.context = context;
        this.callBack = callBack;
        view = LayoutInflater.from(context).inflate(R.layout.pop_get_pay, null);
        viewHolder = new ViewHolder(view);
        viewHolder.edMoney.setText(amount_balance);
        viewHolder.tvNeedPrice.setText("￥" + amount_balance);
        initView();
    }

    private void initView() {
        setContentView(view);
        setCancelable(true);
        setCanceledOnTouchOutside(true);

        Window window = getWindow();
        window.setBackgroundDrawableResource(android.R.color.transparent);

        viewHolder.tvCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });
        viewHolder.tvSure.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!TextUtils.isEmpty(viewHolder.edMoney.getText().toString().trim())) {
                    callBack.onResult(viewHolder.edMoney.getText().toString().trim());
                    dismiss();
                } else {
                    NToast.show("请先填写金额哦~");
                }
            }
        });

        new Handler().postDelayed(new Runnable() {
            public void run() {
                viewHolder.edMoney.performClick();
            }
        }, 300);
    }

    public interface GetPriceCallBack {
        void onResult(String price);
    }

    static class ViewHolder {
        @BindView(R.id.ed_money)
        EditText edMoney;
        @BindView(R.id.tv_need_price)
        TextView tvNeedPrice;
        @BindView(R.id.tv_cancel)
        TextView tvCancel;
        @BindView(R.id.tv_sure)
        TextView tvSure;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
