package com.linzi.xiguwen.fragment.city;

import android.content.Context;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.discover.HotCityAdapter;
import com.linzi.xiguwen.bean.CityEntity;
import com.linzi.xiguwen.widget.NoScrollGridView;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by devin on 2018/4/13 16:59
 * Description
 */

public class CityHeaderView extends LinearLayout {

    @BindView(R.id.tv_my_city)
    TextView tvMyCity;
    @BindView(R.id.gv_hot_city)
    NoScrollGridView gvHotCity;
    private View mView;
    private int width;
    private HotCityAdapter hotCityAdapter;

    public CityHeaderView(Context context) {
        super(context);
        mView = inflate(context, R.layout.include_hot_city, null);
        ButterKnife.bind(this, mView);
        addView(mView, LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT);
        hotCityAdapter = new HotCityAdapter(context, R.layout.item_hot_city);
        gvHotCity.setAdapter(hotCityAdapter);
    }

    public void setData(List<CityEntity> cityEntities) {
        if (hotCityAdapter != null) {
            hotCityAdapter.addFirst(cityEntities);
        }
    }

    public void setLocation(String city) {
        tvMyCity.setText(city + "");
    }

    public void setLocationOnclick(View.OnClickListener locationOnclick) {
        tvMyCity.setOnClickListener(locationOnclick);
    }

    public void setType(int type) {
        if (hotCityAdapter != null)
            hotCityAdapter.setType(type);
    }
}
