package com.linzi.xiguwen.adapter.discover;

import android.app.Activity;
import android.content.Context;
import android.view.View;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.base.SimpleAdapter;
import com.linzi.xiguwen.adapter.base.ViewHolder;
import com.linzi.xiguwen.bean.CityEntity;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;

public class HotCityAdapter extends SimpleAdapter<CityEntity> {

    private Activity activity;
    private int type;

    public HotCityAdapter(Context context, int mItemLayoutId) {
        super(context, mItemLayoutId);
        activity = (Activity) context;
    }

    public void setType(int type) {
        this.type = type;
    }

    @Override
    public void getView(ViewHolder holder, final CityEntity item) {
        TextView mCity = holder.getView(R.id.tv_hot_city);
        mCity.setText(item.getName());
        mCity.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (type == 1) {
                    EventBusUtil.sendEvent(new Event(EventCode.USER_UPTATE_CITY, item));
                } else {
                    EventBusUtil.sendEvent(new Event(EventCode.CITY_SELECT, item));
                }
                activity.finish();
            }
        });
    }

}
