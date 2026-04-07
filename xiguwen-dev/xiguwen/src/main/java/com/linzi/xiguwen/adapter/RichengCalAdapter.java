package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.RadioButton;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.CalendarBean;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.Lunar;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by linzi on 2017/8/8.
 */

public class RichengCalAdapter extends BaseAdapter {
    Context mContext;
    List<CalendarBean> mList;
    CallBack.MainMenuClick mListener;
    public List<String> dots = new ArrayList<>();
    SimpleDateFormat chineseDateFormat = new SimpleDateFormat(
            "yyyy年MM月dd日");
    int year;
    int month;

    public RichengCalAdapter(Context mContext, List<CalendarBean> mList, CallBack.MainMenuClick mListener, int year, int month) {
        this.mContext = mContext;
        this.mList = mList;
        this.mListener = mListener;
        this.year = year;
        this.month = month;
    }
    public void setData( List<CalendarBean> mList, int year, int month){
        this.year = year;
        this.month = month;
        this.mList = mList;
    }
    @Override
    public int getCount() {
        return mList == null ? 0 : mList.size();
    }



    public void setDot(List<String> dots) {
        this.dots.clear();
        if (this.dots != null) {
            this.dots.addAll(dots);
        }
        notifyDataSetChanged();
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(final int position, View view, ViewGroup parent) {
        ViewHolder vh;
        if (view == null) {
            view = LayoutInflater.from(mContext).inflate(R.layout.item_richeng_lable_layout, null);
            vh = new ViewHolder(view);
            view.setTag(vh);
        } else {
            vh = (ViewHolder) view.getTag();
        }
        vh.tvData.setText(mList.get(position).getData());
        vh.rbLable.setChecked(mList.get(position).isChecked());
        vh.tvData.setChecked(mList.get(position).isChecked());
        vh.rbDataYin.setChecked(mList.get(position).isChecked());
        vh.rbThing.setChecked(mList.get(position).isChecked());
        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!mList.get(position).getData().isEmpty()) {
                    mListener.itemClick(mList.get(position).getId());
                }
            }
        });
        if (mList.get(position).isJi()) {
            vh.ivYinji.setVisibility(View.VISIBLE);
        } else {
            vh.ivYinji.setVisibility(View.GONE);
        }
        if (!mList.get(position).getData().isEmpty()) {
            Calendar today = Calendar.getInstance();
            try {
                today.setTime(chineseDateFormat.parse(year + "年" + (month + 1) + "月" + mList.get(position).getData() + "日"));
                Lunar lunar = new Lunar(today);
                vh.rbDataYin.setText(lunar.toString());
            } catch (ParseException e) {
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
            }
            //如果有日程则显示。。
//            if (position < 5) {
//                vh.rbThing.setVisibility(View.VISIBLE);
//            } else {
//                vh.rbThing.setVisibility(View.GONE);
//            }
            if (dots.contains(mList.get(position).getData())) {
                vh.rbThing.setVisibility(View.VISIBLE);
            } else {
                vh.rbThing.setVisibility(View.GONE);
            }
        } else {
            vh.rbDataYin.setText("");
            vh.rbThing.setVisibility(View.GONE);
        }
        return view;
    }

    class ViewHolder {
        @BindView(R.id.rb_lable)
        RadioButton rbLable;
        @BindView(R.id.rb_thing)
        RadioButton rbThing;
        @BindView(R.id.tv_data)
        RadioButton tvData;
        @BindView(R.id.rb_data_yin)
        RadioButton rbDataYin;
        @BindView(R.id.iv_yinji)
        ImageView ivYinji;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
