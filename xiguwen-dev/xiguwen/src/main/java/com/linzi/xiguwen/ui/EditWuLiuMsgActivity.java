package com.linzi.xiguwen.ui;

import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.KuaiDiBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;

public class EditWuLiuMsgActivity extends BaseActivity {

    @BindView(R.id.tv_wuliu)
    TextView tvWuliu;
    @BindView(R.id.ll_select_wuliu)
    LinearLayout llSelectWuliu;
    @BindView(R.id.tv_id)
    EditText tvId;
    @BindView(R.id.ed_context)
    EditText edContext;

    private Context context;
    private int order_id;
    private String kuaidicode;
    private RecyclerView poprecyclerView;
    private PopupWindow popupWindow;
    private ArrayList<KuaiDiBean> list;
    private boolean isTuiHuo;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_wu_liu_msg);
        ButterKnife.bind(this);
        context = this;
        order_id = getIntent().getIntExtra("order_id", -1);
        isTuiHuo = getIntent().getBooleanExtra("isTuiHuo", false);
        initView();
    }

    private void initView() {
        setTitle("填写物流信息");
        setBack();
        getWuLiuList();
        setRight("提交", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!TextUtils.isEmpty(tvId.getText().toString()) && kuaidicode != null && !kuaidicode.equals("")) {
                    if (isTuiHuo) {
                        postTuiHuoAdress(order_id, kuaidicode, tvId.getText().toString());
                    } else {
                        surePostGoods(order_id, kuaidicode, tvId.getText().toString());
                    }
                } else {
                    NToast.show("请完善所有信息再提交！");
                }
            }
        });
        edContext.setVisibility(View.GONE);
        initPop();

        llSelectWuliu.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (list != null && list.size() > 0) {
                    if (popupWindow.isShowing()) {
                        popupWindow.dismiss();
                    } else {
                        popupWindow.showAsDropDown(llSelectWuliu);
                    }
                }
            }
        });

    }

    @Override
    protected void initData() {

    }

    private void initPop() {
        View view = LayoutInflater.from(context).inflate(R.layout.find_pop_layout, null);
        poprecyclerView = (RecyclerView) view.findViewById(R.id.recycleview);
        LinearLayoutManager manager = new LinearLayoutManager(context);
        poprecyclerView.setLayoutManager(manager);
        popupWindow = new PopupWindow(view, WindowManager.LayoutParams.MATCH_PARENT, WindowManager.LayoutParams.WRAP_CONTENT, true);
        popupWindow.setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        popupWindow.setOutsideTouchable(false);
        // 设置PopupWindow是否能响应点击事件
        popupWindow.setTouchable(true);
    }

    //确认发货
    private void surePostGoods(int id, String kuaidicode, String kuaidinum) {
        if (order_id != -1) {
            LoadDialog.showDialog(context);
            ApiManager.postMallGoods(id, kuaidicode, kuaidinum, new OnRequestFinish<BaseBean>() {
                @Override
                public void onFinished() {
                    LoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean data) {
                    NToast.show(data.getMessage());
                    finish();
                    EventBusUtil.sendEvent(new Event(EventCode.REFRESH));
                }

                @Override
                public void onError(Exception ex) {
                    NToast.show(ex.getMessage());
                }
            });
        } else {
            finish();
            NToast.show("获取订单号失败，请尝试重试！");
        }
    }

    //买家退货，发货
    private void postTuiHuoAdress(int id, String kuaidicode, String kuaidinum) {
        if (order_id != -1) {
            LoadDialog.showDialog(context);
            ApiManager.postMallGoodsByUser(id, kuaidicode, kuaidinum, new OnRequestFinish<BaseBean>() {
                @Override
                public void onFinished() {
                    LoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean data) {
                    NToast.show(data.getMessage());
                    finish();
                    EventBusUtil.sendEvent(new Event(EventCode.REFRESH));
                }

                @Override
                public void onError(Exception ex) {
                    NToast.show(ex.getMessage());
                }
            });
        } else {
            finish();
            NToast.show("获取订单号失败，请尝试重试！");
        }
    }

    //获取物流公司
    private void getWuLiuList() {
        LoadDialog.showDialog(context);
        ApiManager.getKuaiDiList(new OnRequestFinish<BaseBean<ArrayList<KuaiDiBean>>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ArrayList<KuaiDiBean>> data) {
                list = data.getData();
                ItemAdapter itemAdapter = new ItemAdapter();
                poprecyclerView.setAdapter(itemAdapter);
                itemAdapter.setData(list);
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    class ItemAdapter extends RecyclerView.Adapter<ItemAdapter.ViewHolder> {
        private ArrayList<KuaiDiBean> list;
        private int index;

        private void setIndex(int index) {
            this.index = index;
            notifyDataSetChanged();
        }

        public void setData(ArrayList<KuaiDiBean> list) {
            this.list = list;
            notifyDataSetChanged();
        }

        @Override
        public ItemAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(context).inflate(R.layout.find_text_item, parent, false);
            return new ViewHolder(view);
        }

        @Override
        public void onBindViewHolder(ItemAdapter.ViewHolder holder, int position) {
            holder.textView.setTextColor(position == index ? Color.parseColor("#FFFC5888") : Color.parseColor("#FF262626"));
            holder.textView.setText(list.get(position).getEsslistname());
        }

        @Override
        public int getItemCount() {
            return list == null ? 0 : list.size();
        }

        class ViewHolder extends RecyclerView.ViewHolder {
            TextView textView;

            public ViewHolder(View itemView) {
                super(itemView);
                textView = (TextView) itemView.findViewById(R.id.tv_title);
                itemView.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        setIndex(getPosition());
                        tvWuliu.setText(list.get(getPosition()).getEsslistname());
                        kuaidicode = list.get(getPosition()).getEsslistcode();
                        popupWindow.dismiss();
                    }
                });
            }
        }

    }
}
