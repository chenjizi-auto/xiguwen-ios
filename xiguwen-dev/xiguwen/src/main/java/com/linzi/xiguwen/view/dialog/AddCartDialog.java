package com.linzi.xiguwen.view.dialog;

import android.app.Activity;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RadioButton;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MyDateBean;
import com.linzi.xiguwen.bean.OffoerDetailsBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.NewBaijiaDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.view.dateview.ChooseDatePop;
import com.linzi.xiguwen.view.dateview.NewChooseDatePop;

import java.util.ArrayList;
import java.util.Calendar;

/**
 * Created by pc on 2018/4/12.
 */

public class AddCartDialog extends PopupWindow implements View.OnClickListener {

    ImageView ivImg;
    TextView tvName;
    TextView tvBaojiaPrice;
    EditText  etPrice;
    TextView tvTime;
    EditText edNum;
    Button btSubmit;
    RelativeLayout rv_choose_time;
    Button bt_add;
    Button bt_jian;
    RadioButton allpay;
    RadioButton dingjinpay;
    LinearLayout ll_edPrice;
    RadioButton rb_pay_agreed;
    RadioButton rb_pay_agreed_two;

    private View view;
    private Context context;
    private OffoerDetailsBean.BaojiaBean baojiaBean;
    private View showView;

    private String date;
    private int when = 2;//默认中午
    private int type = -1;//0 添加购物车 1立即购买
    private int paytype = -1;//1全款 2定金 3 约定价。4 约定定金价
    private double agreedPrice =0;

    public void setType(int type) {
        this.type = type;
    }

    private RefreshNum refreshNum;

    public void setRefreshNum(RefreshNum refreshNum) {
        this.refreshNum = refreshNum;
    }

    public interface RefreshNum {
        abstract void onRefresh(boolean isRefresh, String baojiadate, int baojiaid, int baojiatime, int paytype, String quantity,String agreedPrice);
    }

    public AddCartDialog(Context context, OffoerDetailsBean.BaojiaBean baojiaBean, View showView) {
        super(context);
        this.context = context;
        this.baojiaBean = baojiaBean;
        this.showView = showView;
        view = LayoutInflater.from(context).inflate(R.layout.baojia_addcart_layout, null);
        initPop();
        initView();
    }

    private void initPop() {
        // 设置弹出窗体可点击
        setFocusable(true);
        int w = ((Activity) context).getWindowManager().getDefaultDisplay().getWidth();
        int h = (((Activity) context).getWindowManager().getDefaultDisplay().getHeight() / 2) + 200;
        setWidth(w);
        setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0xffff0000);
        // 设置弹出窗体的背景
        setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        setAnimationStyle(R.style.AnimationPreview);
        setContentView(view);
        update();
        setOnDismissListener(new OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });

        ivImg = view.findViewById(R.id.iv_img);
        tvName = view.findViewById(R.id.tv_name);
        tvBaojiaPrice = view.findViewById(R.id.tv_baojia_price);
        etPrice = view.findViewById(R.id.et_price);
        tvTime = view.findViewById(R.id.tv_time);
        edNum = view.findViewById(R.id.ed_num);
        rv_choose_time = view.findViewById(R.id.rv_choose_time);
        bt_add = view.findViewById(R.id.bt_add);
        btSubmit = view.findViewById(R.id.bt_submit);
        bt_jian = view.findViewById(R.id.bt_jian);
        allpay = view.findViewById(R.id.allpay);
        dingjinpay = view.findViewById(R.id.dingjinpay);
        ll_edPrice = view.findViewById(R.id.ll_edPrice);
        rb_pay_agreed = view.findViewById(R.id.rb_pay_agreed);
        rb_pay_agreed_two = view.findViewById(R.id.rb_pay_agreed_two);

        rv_choose_time.setOnClickListener(this);
        bt_add.setOnClickListener(this);
        btSubmit.setOnClickListener(this);
        bt_jian.setOnClickListener(this);

        allpay.setOnClickListener(this);
        dingjinpay.setOnClickListener(this);
        rb_pay_agreed.setOnClickListener(this);
        rb_pay_agreed_two.setOnClickListener(this);

        etPrice.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void afterTextChanged(Editable editable) {
                if (paytype == 3) {

                    int Num = Integer.valueOf(edNum.getText().toString());
                    if (!TextUtils.isEmpty(editable)){
                        tvBaojiaPrice.setText("约定价 ￥" + editable.toString());
                        agreedPrice = Double.valueOf(editable.toString()) * Num;
                    }else {
                        tvBaojiaPrice.setText("请输入约定价");
                    }
                } else if (paytype == 4) {
                    int Num = Integer.valueOf(edNum.getText().toString());
                    if (!TextUtils.isEmpty(editable.toString())){
                        Double pg = Double.valueOf(editable.toString()).intValue() * 0.2 * Num;
                        tvBaojiaPrice.setText("约定价 定金￥" + Math.round(pg));
                        agreedPrice = Double.valueOf(editable.toString()) * Num;
                    }else {
                        tvBaojiaPrice.setText("请输入约定价 ");
                    }
                }
            }
        });
    }


    private void initView() {
        GlideLoad.GlideLoadImg2(baojiaBean.getImglist().get(0), ivImg);
        tvName.setText("" + baojiaBean.getName());
        tvBaojiaPrice.setText("￥" + baojiaBean.getPrice());
        tvTime.setText(getNowDate());
    }

    private String getNowDate() {
        Calendar calendar = Calendar.getInstance();
        date = calendar.get(Calendar.YEAR) + "-" + (calendar.get(Calendar.MONTH) + 1) + "-" +
                calendar.get(Calendar.DAY_OF_MONTH);
        return calendar.get(Calendar.YEAR) + "-" + (calendar.get(Calendar.MONTH) + 1) + "-" +
                calendar.get(Calendar.DAY_OF_MONTH) + " " + "中午";
    }

    //显示消失动画
    public void lightoff(boolean isoff) {
        WindowManager.LayoutParams lp = ((Activity) context).getWindow().getAttributes();
        if (isoff) {
            lp.alpha = 0.3f;
        } else {
            lp.alpha = 1f;
        }
        ((Activity) context).getWindow().setAttributes(lp);
    }

    public void setShowWithView(View view) {
        showAtLocation(view, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        lightoff(true);
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.bt_jian:
                int Num = Integer.valueOf(edNum.getText().toString());
                Num--;
                if (Num <= 0) {
                    Num = 1;
                }
                edNum.setText("" + Num);
                break;
            case R.id.bt_add:
                int Num2 = Integer.valueOf(edNum.getText().toString());
                Num2++;
                edNum.setText("" + Num2);
                break;
            case R.id.bt_submit:
                if (allpay.isChecked()) {
                    paytype = 1;
                } else if (dingjinpay.isChecked()){
                    paytype = 2;
                }else if (rb_pay_agreed.isChecked()){
                    paytype = 3;
                }else if (rb_pay_agreed_two.isChecked()){
                    paytype = 4;
                }
                btSubmit.setClickable(false);
                if (paytype ==3 || paytype ==4 ){
                  if (agreedPrice<= 0){
                      NToast.show("金额错误");
                      btSubmit.setClickable(true);
                      return;
                  }
                }
                if (type == 0) {
                    addGoods();
                } else {
//                    //立即购买
//                    dismiss();
//                    refreshNum.onRefresh(false, date, baojiaBean.getQuotationid(), when, paytype, edNum.getText().toString());
                    btSubmit.setClickable(true);
                    int userid = (int) SPUtil.get("userid", SPUtil.Type.INT);
                    isTrueDate(date, baojiaBean.getQuotationid(), when, userid);
                }

                break;
            case R.id.rv_choose_time:
                dismiss();
                createChooseTimePop(showView);
                break;
            case R.id.allpay:
                tvBaojiaPrice.setText("￥" + baojiaBean.getPrice());
                ll_edPrice.setVisibility(View.GONE);
                break;
            case R.id.dingjinpay:
                tvBaojiaPrice.setText("全款定金 ￥" + baojiaBean.getTemporarypay());
                ll_edPrice.setVisibility(View.GONE);
                break;
            case R.id.rb_pay_agreed:
                tvBaojiaPrice.setText("请输入约定价");
                if (paytype != 3){
                    etPrice.setText("");
                    agreedPrice = 0;
                }
                paytype=3;
                ll_edPrice.setVisibility(View.VISIBLE);
                break;
            case R.id.rb_pay_agreed_two:
                tvBaojiaPrice.setText("请输入约定价");
                if (paytype != 4){
                    etPrice.setText("");
                    agreedPrice = 0;
                }
                paytype =4;
                ll_edPrice.setVisibility(View.VISIBLE);
                break;
        }
    }

    //创建时间选择器
    private void createChooseTimePop(View llParent) {
        ArrayList<MyDateBean> when_list = new ArrayList<>();
        for (int x = 0; x < 4; x++) {
            MyDateBean mBean = new MyDateBean();
            mBean.setId(x);
            switch (x) {
                case 0:
                    mBean.setDate("上午");
                    break;
                case 1:
                    mBean.setDate("中午");
                    break;
                case 2:
                    mBean.setDate("下午");
                    break;
                case 3:
                    mBean.setDate("晚上");
                    break;
            }
            when_list.add(mBean);
        }
        ChooseDatePop chooseDatePop = new ChooseDatePop(context, when_list, false);
        chooseDatePop.setShowWithView(llParent);
        chooseDatePop.setListener(new ChooseDatePop.ReturnTimeStr() {
            @Override
            public void onSubmit(String string, String date, int whenid) {
                setShowWithView(showView);
                tvTime.setText(string);
                AddCartDialog.this.date = date;
                AddCartDialog.this.when = whenid;
            }
        });
//        NewChooseDatePop pop = new NewChooseDatePop(context);
//        pop.setShowWithView(llParent);
    }

    private void addGoods() {
        LoadDialog.showDialog(context);
        ApiManager.addWeddingCartGoods(date, baojiaBean.getQuotationid() + "", when, paytype, edNum.getText().toString(),""+agreedPrice, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show("添加成功！");
                btSubmit.setClickable(true);
                dismiss();
                if (type == 0) {
                    //刷新
                    refreshNum.onRefresh(true, date, baojiaBean.getQuotationid(), when, paytype, edNum.getText().toString(),""+agreedPrice);
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                btSubmit.setClickable(true);
            }
        });
    }

    //校验档期是否符合要求
    private void isTrueDate(String baojiadate, int id, int baojiatime, int userid) {

        LoadDialog.showDialog(context);
        ApiManager.chaDangQi(id, baojiatime, baojiadate, userid, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                dismiss();
                refreshNum.onRefresh(false, date, baojiaBean.getQuotationid(), when, paytype, edNum.getText().toString(),""+agreedPrice);
                //btSubmit.setClickable(true);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }
}
