package com.linzi.xiguwen.adapter.discover;

import android.app.Activity;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.SectionIndexer;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.CityEntity;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;

import java.util.ArrayList;
import java.util.List;

public class SortAdapter extends BaseAdapter implements SectionIndexer {

    private List<CityEntity> list = new ArrayList<>();

    private Activity mContext;

    private int type;



    public SortAdapter(Activity mContext) {
        this.mContext = mContext;
    }

    public void setType(int type){
        this.type=type;
    }

    public void updateListView(List<CityEntity> list) {
        this.list = list;
        notifyDataSetChanged();
    }


    @Override
    public int getCount() {
        return list == null ? 0 : list.size();
    }

    @Override
    public Object getItem(int position) {
        return list.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        ViewHolder viewHolder = null;
        final CityEntity entity = list.get(position);
        if (convertView == null) {
            viewHolder = new ViewHolder();
            convertView = LayoutInflater.from(mContext).inflate(R.layout.item_city, null);
            viewHolder.tvTitle = (TextView) convertView.findViewById(R.id.title);
//			viewHolder.tvLetter = (TextView) convertView.findViewById(R.id.catalog);
            convertView.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) convertView.getTag();
        }
        if (entity.getMyType() == 1) {
            viewHolder.tvTitle.setBackgroundColor(Color.parseColor("#f2f2f2"));
        } else {
            viewHolder.tvTitle.setBackgroundColor(Color.WHITE);
        }
        viewHolder.tvTitle.setText(this.list.get(position).getName());

        viewHolder.tvTitle.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (entity.getMyType() == 0) {
                    if (type == 1) {
                        EventBusUtil.sendEvent(new Event(EventCode.USER_UPTATE_CITY, entity));
                    } else {
                        EventBusUtil.sendEvent(new Event(EventCode.CITY_SELECT, entity));
                    }
                    mContext.finish();
                }
            }
        });
        return convertView;
    }

    @Override
    public Object[] getSections() {
        return new Object[0];
    }

    @Override
    public int getPositionForSection(int sectionIndex) {
        for (int i = 0; i < getCount(); i++) {
            String sortStr = list.get(i).getInitial();
            char firstChar = sortStr.toUpperCase().charAt(0);
            if (firstChar == sectionIndex) {
                return i;
            }
        }

        return -1;
    }

    @Override
    public int getSectionForPosition(int position) {
        return list.get(position).getInitial().charAt(0);
    }

//    @Override
//    public Object[] getSections() {
//        return null;
//    }

//    @Override
//    public int getPositionForSection(int sectionIndex) {
//        for (int i = 0; i < getCount(); i++) {
//            String sortStr = list.get(i).getInitial();
//            char firstChar = sortStr.toUpperCase().charAt(0);
//            if (firstChar == sectionIndex) {
//                return i;
//            }
//        }
//
//        return -1;
//    }
//
//
//    @Override
//    public int getSectionForPosition(int position) {
//        return list.get(position).getInitial().charAt(0);
//    }


    final static class ViewHolder {
        //        TextView tvLetter;
        TextView tvTitle;
    }

    private String getAlpha(String str) {
        String sortStr = str.trim().substring(0, 1).toUpperCase();
        if (sortStr.matches("[A-Z]")) {
            return sortStr;
        } else {
            return "#";
        }
    }


}
