package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;

import com.alibaba.fastjson.JSONObject;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.HotCityGridAdapter;
import com.linzi.xiguwen.adapter.SortAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.CityBean;
import com.linzi.xiguwen.bean.SortModel;
import com.linzi.xiguwen.bean.SortModel_A;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.view.SideBar;

import org.xutils.common.Callback;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import butterknife.BindView;
import butterknife.ButterKnife;
import pinyin.PinYin;

public class SelectCityActivity extends BaseActivity {
    @BindView(R.id.ed_search)
    EditText edSearch;
    @BindView(R.id.main_lv)
    ListView mainLv;
    @BindView(R.id.dialog)
    TextView dialog;
    @BindView(R.id.side_bar)
    SideBar sideBar;

    private PinYin pinYin;
    private List<SortModel_A> data;
    private SortAdapter adapter;
    private SortModel_A model;
    private SortModel model_city;
    private SideBar.OnLetterSelectedListener letterSelectedListener;

    private CityBean cityBean;
    private ExecutorService cachedThreadPool = Executors.newCachedThreadPool();//线程池

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_select_city);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("当前城市-成都");
        setClose(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

        sideBar.setmTextView(dialog);
        letterSelectedListener = new SideBar.OnLetterSelectedListener() {
            @Override
            public void onLetterSelected(String s) {
                if (!s.equals("hot_city")) {
                    int position = adapter.getPositionBySelection(s.charAt(0));
                    //因为listview加入了head，所以定位语句+1
                    if(position!=-1) {
                        mainLv.setSelection(position + 1);
                    }
                } else {
                    mainLv.setSelection(0);
                }
            }
        };
        sideBar.setLetterSelectedListener(letterSelectedListener);

        getData();

    }

    private void getData() {
        LoadDialog.showDialog(this);
        new ApiManager().getCity(new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                cityBean = JSONObject.parseObject(result, CityBean.class);

                data = new ArrayList<>();
                String py, sortLetter;

                for (int x = 0; x < cityBean.getData().getSite().size(); x++) {
                    model = new SortModel_A();
                    model_city = new SortModel();
                    model_city.setCity_name(cityBean.getData().getSite().get(x).getName());
                    model_city.setCity_code("" + cityBean.getData().getSite().get(x).getId());
                    model_city.setPinyin(cityBean.getData().getSite().get(x).getPinyin());
                    model.setSm(model_city);
                    py = pinYin.getPinYin(model_city.getCity_name());
                    sortLetter = py.substring(0, 1).toUpperCase();    // 获取名字拼音的首字母大写
                    model.setSortLetter(sortLetter);
                    data.add(model);
                }

                setHead();

                // 按字母排序
//                Collections.sort(data, new PinYinComparator());
                // 创建适配器，显示在ListView上
                adapter = new SortAdapter(mContext, data);
                mainLv.setAdapter(adapter);

                mainLv.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                    @Override
                    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                        Intent intent = new Intent(SelectCityActivity.this, MainActivity.class);
                        intent.putExtra("city_code", data.get(position-1).getSm().getCity_code());
                        intent.putExtra("city_name", data.get(position-1).getSm().getCity_name());
                        setResult(121, intent);
                        finish();
                    }
                });

            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {

            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }
        });
    }

    private void setHead() {
        View view = LayoutInflater.from(mContext).inflate(R.layout.head_select_city_list, null);
        final ViewHolder vh=new ViewHolder(view);
        HotCityGridAdapter hotAdapter=new HotCityGridAdapter(cityBean.getData().getNewsite(), this, new CallBack.OnMenuItemClickListener() {
            @Override
            public void itemClick(int position) {
                Intent intent = new Intent(SelectCityActivity.this, MainActivity.class);
                intent.putExtra("city_code", cityBean.getData().getNewsite().get(position).getId());
                intent.putExtra("city_name", cityBean.getData().getNewsite().get(position).getName());
                setResult(121, intent);
                finish();
            }

            @Override
            public void itemClick(int position, String name) {

            }
        });
        GridLayoutManager manager=new GridLayoutManager(this,3){
            @Override
            public boolean canScrollVertically() {
                // 直接禁止垂直滑动
                return false;
            }
        };
        vh.hotRecycle.setLayoutManager(manager);
        vh.hotRecycle.setAdapter(hotAdapter);
        mainLv.addHeaderView(view);

        edSearch.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(final CharSequence s, int i, int i1, int i2) {
                if(data!=null){
                    if(!TextUtils.isEmpty(s)) {
                        cachedThreadPool.execute(new Runnable() {
                            @Override
                            public void run() {
                                for (int x = 0; x < data.size(); x++) {
                                    if (data.get(x).getSm().getPinyin().toLowerCase().contains(s.toString().toLowerCase())) {
                                        Message msg=new Message();
                                        msg.what=x;
                                        mHandler.sendMessage(msg);
                                        return;
                                    }
                                }
                            }
                        });
                    }else{
                        mainLv.setSelection(0);
                    }
                }
            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });
    }
    Handler mHandler=new Handler(){
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            mainLv.setSelection(msg.what + 1);
        }
    };
    class ViewHolder {
        @BindView(R.id.my_location)
        Button myLocation;
        @BindView(R.id.all)
        Button all;
        @BindView(R.id.hot_recycle)
        RecyclerView hotRecycle;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
