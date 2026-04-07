package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.SortModel_A;

import java.util.ArrayList;
import java.util.List;

public class SortAdapter extends BaseAdapter{
	private List<SortModel_A> all_data;
	private List<SortModel_A> data;
	private Context context;
	private List<SortModel_A> data_filter;

	public SortAdapter(Context context, List<SortModel_A> all_data){
		this.context=context;
		this.all_data=all_data;
		this.data=all_data;
	}

	@Override
	public int getCount() {
		com.linzi.xiguwen.utils.LogUtil.i("SystemOut", String.valueOf("size======"+data.size()));
		return data==null?0:data.size();
	}

	@Override
	public SortModel_A getItem(int position) {
		return data.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		ViewHolder holder=null;
		if (convertView == null) {
			convertView=LayoutInflater.from(context).inflate(R.layout.item_city_layout, null);
			holder=new ViewHolder();
			holder.sortLetter=(TextView) convertView.findViewById(R.id.word);
			holder.name=(TextView) convertView.findViewById(R.id.tv_city_name);
			convertView.setTag(holder);
		}else{
			holder=(ViewHolder) convertView.getTag();
		}
		SortModel_A sortModel = data.get(position);
		int selection=getSelectionByPosition(position);	// 首字母字�?
		int index=getPositionBySelection(selection);
		if (position == index) {
			// 说明这个条目是第�?个，�?要显示字�?
			holder.sortLetter.setVisibility(View.VISIBLE);
			holder.sortLetter.setText(sortModel.getSortLetter());
		}else{
			holder.sortLetter.setVisibility(View.GONE);
		}
		holder.name.setText(sortModel.getSm().getCity_name());
		return convertView;
	}
	
	public int getSelectionByPosition(int position){
		return data.get(position).getSortLetter().charAt(0);
	}
	
	/**
	 * 通过首字母获取显示该首字母的姓名的人，如：C,成龙
	 * @author Xubin
	 *
	 */
	public int getPositionBySelection(int selection){
		for (int i = 0; i < getCount(); i++) {
			String sortStr=data.get(i).getSortLetter();
			char firstChar=sortStr.toUpperCase().charAt(0);
			if (firstChar == selection) {
				return i;
			}
		}
		return -1;
	}

	class ViewHolder{
		TextView sortLetter;
		TextView name;
	}
}
