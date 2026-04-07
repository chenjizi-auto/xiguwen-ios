package com.linzi.xiguwen.ui;

import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RadioGroup;
import android.widget.TextView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.SearchKeyBean;
import com.linzi.xiguwen.bean.SearchKeyHotBean;
import com.linzi.xiguwen.fragment.search.SearchMainActivity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.view.AutoWrapLayout;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class SearchActivity extends AppCompatActivity {

    @BindView(R.id.ed_search)
    EditText edSearch;
    @BindView(R.id.tv_close)
    TextView tvClose;
    @BindView(R.id.ll_lable)
    AutoWrapLayout llLable;
    @BindView(R.id.ll_history)
    AutoWrapLayout llHistory;
    @BindView(R.id.search_city)
    TextView txSearchCity;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;

    private RadioGroup radioGroup;

    private View.OnClickListener itemClickListenerHot;
    private View.OnClickListener itemClickListenerHistory;
    private AutoWrapLayout.WrapAdapter adapterHot;
    private AutoWrapLayout.WrapAdapter adapterHistory;

    private List<SearchKeyHotBean> hotBeans;
    private List<String> historyBeans = new ArrayList<>();
    private String content;
    private int cityType = 1;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
        StatusBarUtil.setStatusBarColor(SearchActivity.this, R.color.white);
        StatusBarUtil.setNavigationBarColor(SearchActivity.this, R.color.white);

        setContentView(R.layout.activity_search);
        ButterKnife.bind(this);
        initViews();
        initPop();
        event();
        httpdata();

    }

    private void initViews() {

        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(SearchActivity.this));
        llBar.setLayoutParams(params);
// ViewCompat.setAlpha(llBar, 0);
        llBar.setBackgroundColor(SearchActivity.this.getResources().getColor(R.color.white));


        String history = Preferences.getString(Preferences.SEARCH_HISTORE);
        try {
            if (!AppUtil.isEmpty(history)) {
                historyBeans = JSONArray.parseArray(history, String.class);
            }
        } catch (Exception e) {

        }

        prepareAdapter();

        llHistory.setAdapter(adapterHistory);

        tvClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (tvClose.getText().toString().equals("搜索")) {
                    search();
                }
                finish();
            }
        });


        edSearch.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                content = edSearch.getText().toString().trim();
                if (!AppUtil.isEmpty(content)) {
                    tvClose.setText("搜索");
                } else {
                    tvClose.setText("取消");
                }
            }
        });
    }

    private void httpdata() {

        ApiManager.getSearchHot(new OnRequestSubscribe<BaseBean<SearchKeyBean>>() {
            @Override
            public void onSuccess(BaseBean<SearchKeyBean> data) {
                hotBeans = data.getData().getHot();
                llLable.setAdapter(adapterHot);
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void event() {
        radioGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                if (checkedId == R.id.pop_city) {
                    cityType = 1;
                    txSearchCity.setText("同城");
                } else if (checkedId == R.id.pop_country) {
                    cityType = 2;
                    txSearchCity.setText("全国");
                }
                popupWindow.dismiss();
            }
        });
    }

    private void search() {
        if (!historyBeans.contains(content)) {
            historyBeans.add(content);
            Preferences.saveString(Preferences.SEARCH_HISTORE, JSON.toJSONString(historyBeans));
        }

        SearchMainActivity.startAction(this, "成都市", content, cityType);
    }

    private void prepareAdapter() {
        final LayoutInflater layoutInflater = LayoutInflater.from(this);
        itemClickListenerHot = new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int index = Integer.parseInt(v.getTag().toString());
//                Toast.makeText(SearchActivity.this, "itemClick - " + hotBeans.get(index).getTitle(), Toast.LENGTH_LONG).show();
                content = hotBeans.get(index).getTitle();
                search();
                finish();
            }
        };
        itemClickListenerHistory = new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int index = Integer.parseInt(v.getTag().toString());
//                Toast.makeText(SearchActivity.this, "itemClick - " + historyBeans.get(index), Toast.LENGTH_LONG).show();
                content = historyBeans.get(index);
                search();
                finish();
            }
        };
        adapterHot = new AutoWrapLayout.WrapAdapter() {

            @Override
            public int getItemCount() {
                return hotBeans == null ? 0 : hotBeans.size();
            }

            @Override
            public TextView onCreateTextView(int index) {
                TextView itemTv = (TextView) layoutInflater.inflate(R.layout.item_wrap_tv, null);
                itemTv.setText(hotBeans.get(index).getTitle());
                itemTv.setTag(index);
                itemTv.setOnClickListener(itemClickListenerHot);
                return itemTv;
            }
        };

        adapterHistory = new AutoWrapLayout.WrapAdapter() {

            @Override
            public int getItemCount() {
                return historyBeans == null ? 0 : historyBeans.size();
            }

            @Override
            public TextView onCreateTextView(int index) {
                TextView itemTv = (TextView) layoutInflater.inflate(R.layout.item_wrap_tv, null);
                itemTv.setText(historyBeans.get(index));
                itemTv.setTag(index);
                itemTv.setOnClickListener(itemClickListenerHistory);
                return itemTv;
            }
        };
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:// 点击返回图标事件
                finish();
            default:
                return super.onOptionsItemSelected(item);
        }
    }


    @OnClick({R.id.search_city, R.id.search_history_delete})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.search_city:
                showPop();
                break;
            case R.id.search_history_delete:
                Preferences.saveString(Preferences.SEARCH_HISTORE, "");
                historyBeans.clear();
                llHistory.setVisibility(View.GONE);

                break;
        }
    }

    private PopupWindow popupWindow;

    private void showPop() {
        //是否展开pop
        if (popupWindow == null) {
            return;
        }
        if (popupWindow.isShowing()) {
            popupWindow.dismiss();
        } else {
            popupWindow.showAsDropDown(txSearchCity);
        }
    }


    private void initPop() {
        View view = LayoutInflater.from(this).inflate(R.layout.pop_view_serarch_city, null);
        popupWindow = new PopupWindow(view, AppUtil.dip2px(this, 360), WindowManager.LayoutParams.WRAP_CONTENT, true);
        radioGroup = view.findViewById(R.id.pop_radiogroup);
        popupWindow.setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        popupWindow.setOutsideTouchable(true);
        // 设置PopupWindow是否能响应点击事件
        popupWindow.setTouchable(true);
    }
}
