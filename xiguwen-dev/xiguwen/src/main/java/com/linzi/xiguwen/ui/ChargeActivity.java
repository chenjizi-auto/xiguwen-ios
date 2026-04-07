package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MineNeedBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.ScrollerDatePicker;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ChargeActivity extends BaseActivity {

    Context mContext;

    @BindView(R.id.ed_price)
    EditText edPrice;
    @BindView(R.id.ed_ps)
    EditText edPs;
    @BindView(R.id.bt_submit)
    Button btSubmit;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_for_charge);
        ButterKnife.bind(this);
        EventBusUtil.register(this);
        mContext = this;
    }

    @Override
    protected void initData() {
        setTitle("充值");
        setBack();
//        edData.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                AppUtil.clearInputMethod(v);
//                new PopChooserUtils(ForNeedActivity.this)
//                        .setChooseData(new String[]{"婚庆","商城"})
//                        .setListenner(new PopChooserUtils.ItemClickListener() {
//                            @Override
//                            public void popItemClick(View view, int position) {
//                                type=position+1;
//                                switch(position){
//                                    case 0:
//                                        edData.setText("婚庆");
//                                    break;
//                                    case 1:
//                                        edData.setText("商城");
//                                    break;
//                                }
//                            }
//                        })
//                        .show(llParent);
//            }
//        });
        btSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String price = edPrice.getText().toString();
                if(price.isEmpty()){
                    NToast.show("请输入充值金额");
                    return;
                }
                if(Double.parseDouble(price) <=0){
                    NToast.show("请输入正确的金额");
                    return;
                }

                if(edPs.getText().toString().isEmpty()){
                    NToast.show("请输入备注");
                    return;
                }
                charge();
            }
        });

    }





    /**
     * 发布需求
     */
    private void charge(){
        LoadDialog.showDialog(mContext);
        Intent intent = new Intent(this, ToPayActivity.class);
        intent.putExtra("intentType", 7);
        intent.putExtra("price", edPrice.getText().toString());
        intent.putExtra("beizhu", edPs.getText().toString());
        startActivity(intent);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event event) {
        if (event == null)
            return;
        try {
            int code = event.getCode();
            switch (code) {
                case EventCode.PAY_SUCCRSS:
                    finish();
                    break;
            }
        } catch (Exception e) {
        }

    }

}
