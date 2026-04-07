package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jungly.gridpasswordview.GridPasswordView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.BankCardEntity;
import com.linzi.xiguwen.fragment.search.MyPopWindow;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.PopNumKeyBordeUtils;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.luck.picture.lib.utils.ToastUtils;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class TXStep1Activity extends BaseActivity {

    @BindView(R.id.iv_bank_img)
    ImageView ivBankImg;
    @BindView(R.id.tv_banke_name)
    TextView tvBankeName;
    @BindView(R.id.tv_card_details)
    TextView tvCardDetails;
    @BindView(R.id.ll_choose_card)
    LinearLayout llChooseCard;
    @BindView(R.id.ed_money)
    EditText edMoney;
    @BindView(R.id.tv_yue)
    TextView tvYue;
    @BindView(R.id.bt_submit)
    Button btSubmit;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;
    @BindView(R.id.tv_add_card)
    TextView tvAddCard;

    private Double money;
    private Double txMoney;
    private BankCardEntity.ListBean bankCardEntity;

    //        InputPassWordDialog
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_txstep1);
        ButterKnife.bind(this);
    }


    @Override
    protected void initData() {
        setTitle("提现");
        setBack();
        EventBusUtil.register(this);
        httpData();
        edMoney.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence s, int i, int i1, int i2) {
                if (s.length() > 0) {
                    txMoney = Double.valueOf(s.toString());
                    if (txMoney > money) {
                        tvYue.setText("金额已超过可提取余额");
                        tvYue.setTextColor(getResources().getColor(R.color.colorTitleRed));
                    } else {
                        tvYue.setText("余额：" + money);
                        tvYue.setTextColor(getResources().getColor(R.color.colorHint));
                    }
                } else {
                    tvYue.setText("余额：" + money);
                    tvYue.setTextColor(getResources().getColor(R.color.colorHint));
                }
            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });
    }


//    private void httpData() {
//        ApiManager.bankTixianDetail(new OnRequestSubscribe<BaseBean<TixianData>>() {
//            @Override
//            public void onSuccess(BaseBean<TixianData> data) {
//                try {
//                    money = Double.parseDouble(data.getData().getYue());
//                    tvYue.setText("余额：" + money);
//                    List<BankCardEntity> cardEntities = data.getData().getKahao();
//                    if (!AppUtil.isEmpty(cardEntities)) {
//                        bankCardEntity = cardEntities.get(0);
//                    }
//                    setContent();
//                } catch (Exception e) {
//
//                }
//
//            }
//
//            @Override
//            public void onError(Exception ex) {
//
//            }
//        });
//    }

    private void httpSubmit() {
        if (bankCardEntity != null && passwordView != null && passwordView.getPassWord().length() == 6 && txMoney != null && txMoney > 0) {
            myPopWindow.dissmiss();
            LoadDialog.showDialog(this);
            ApiManager.aliPayTixianSubmit(bankCardEntity.getId() + "", passwordView.getPassWord(), txMoney + "", new OnRequestSubscribe<BaseBean>() {
                @Override
                public void onSuccess(BaseBean data) {
                    LoadDialog.CancelDialog();
                    ToastUtils.showToast(TXStep1Activity.this, "提现成功");
                    money = money - txMoney;
                    txMoney = 0.0;
                    edMoney.setText("");
                    tvYue.setText("余额：" + money);
                }

                @Override
                public void onError(Exception ex) {
                    ToastUtils.showToast(TXStep1Activity.this, ex.getMessage());
                    LoadDialog.CancelDialog();
                }
            });
        }

    }

    private void httpData() {
        ApiManager.aliPayList(new OnRequestSubscribe<BaseBean<BankCardEntity>>() {
            @Override
            public void onSuccess(BaseBean<BankCardEntity> data) {
                try {
                    money = Double.parseDouble(data.getData().getMoney());
                    tvYue.setText("余额：" + money);
                    List<BankCardEntity.ListBean> cardEntities = data.getData().getList();
                    if (!AppUtil.isEmpty(cardEntities)) {
                        for (int i = 0; i < cardEntities.size(); i++) {
                            if (cardEntities.get(i).getSelection() == 1) {
                                bankCardEntity = cardEntities.get(i);
                                setContent();
                            }
                        }
                    }
                } catch (Exception e) {

                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void setContent() {
        if (bankCardEntity != null) {
            tvAddCard.setVisibility(View.GONE);
            llChooseCard.setVisibility(View.VISIBLE);
            tvBankeName.setText(bankCardEntity.getAli_name() + "");
            tvCardDetails.setText(bankCardEntity.getName() + "");
            // GlideLoad.GlideLoadCircle(bankCardEntity.getIcon(), ivBankImg);
            ivBankImg.setBackgroundResource(R.mipmap.icon_alipay);
        } else {
            tvAddCard.setVisibility(View.VISIBLE);
            llChooseCard.setVisibility(View.GONE);
        }
    }

    @OnClick({R.id.ll_choose_card, R.id.ed_money, R.id.bt_submit, R.id.tv_add_card})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_choose_card:
            case R.id.tv_add_card:
                Intent intent = new Intent(this, ChooseBankCardActivity.class);
                if (bankCardEntity != null) {
                    intent.putExtra("bandId", bankCardEntity.getId());
                }
                startActivity(intent);
                break;
            case R.id.ed_money:
                new PopNumKeyBordeUtils(TXStep1Activity.this)
                        .setKeyListenner(new PopNumKeyBordeUtils.KeyClickListener() {
                            @Override
                            public void keyListener(StringBuffer values_key) {
                                edMoney.setText(values_key.toString());
                            }
                        }).setSubmitListenner(new PopNumKeyBordeUtils.SubmitListener() {
                    @Override
                    public void submitListener(View view) {

                    }
                }).setDefValues(edMoney.getText().toString())
                        .show(llParent);
                break;
            case R.id.bt_submit:
                if (txMoney == null || txMoney <= 0 || bankCardEntity == null) {
                    return;
                }
                showPopListView(txMoney + "");
                if (popNumKeyBordeUtils == null) {
                    popNumKeyBordeUtils = new PopNumKeyBordeUtils(TXStep1Activity.this)
                            .setKeyListenner(new PopNumKeyBordeUtils.KeyClickListener() {
                                @Override
                                public void keyListener(StringBuffer values_key) {
//                                edMoney.setText(values_key.toString());
                                    passwordView.setPassword(values_key.toString());
                                }
                            }).setSubmitListenner(new PopNumKeyBordeUtils.SubmitListener() {
                                @Override
                                public void submitListener(View view) {
                                    httpSubmit();
                                }
                            });
                }

                popNumKeyBordeUtils.setDefValues("").show(llParent);

                break;
        }
    }

    PopNumKeyBordeUtils popNumKeyBordeUtils;

    private MyPopWindow myPopWindow;

    private void showPopListView(String price) {
        if (myPopWindow == null) {
            View contentView = LayoutInflater.from(this).inflate(R.layout.view_inputpassword_layout, null);
            //处理popWindow 显示内容
            handleListView(contentView);
            //创建并显示popWindow
            myPopWindow = new MyPopWindow.PopupWindowBuilder(TXStep1Activity.this)
                    .setView(contentView)
                    .size(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)//显示大小
                    .setOutsideTouchable(false)
                    .create();
        }
        txPopPrice.setText("￥" + price);
        myPopWindow.showBackgroundDark();
        passwordView.setPassword("");
        myPopWindow.getPopupWindow().setOutsideTouchable(false);
        myPopWindow.showAtLocation(tvAddCard, Gravity.CENTER, 0, -100);
    }

    TextView txPopPrice;
    private GridPasswordView passwordView;

    private void handleListView(View contentView) {
        txPopPrice = contentView.findViewById(R.id.tv_price);
        passwordView = contentView.findViewById(R.id.pswView);

        ImageView imageView = contentView.findViewById(R.id.iv_close);
        imageView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                myPopWindow.dissmiss();
                popNumKeyBordeUtils.dismiss();
            }
        });
//        passwordView.setOnPasswordChangedListener(new GridPasswordView.OnPasswordChangedListener() {
//            @Override
//            public void onTextChanged(String psw) {
//                if (psw.length() == 6) {//6位密码自动支付
//
//                }
//            }
//
//            @Override
//            public void onInputFinish(String psw) {
//
//            }
//        });
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.BANK_CHOSE:
                    bankCardEntity = (BankCardEntity.ListBean) entity.getData();
                    setContent();
                    break;
            }
        } catch (Exception e) {
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        EventBusUtil.unregister(this);
    }
}
