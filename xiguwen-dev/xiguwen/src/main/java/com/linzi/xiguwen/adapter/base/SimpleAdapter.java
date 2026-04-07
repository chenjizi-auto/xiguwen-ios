package com.linzi.xiguwen.adapter.base;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

/**
 * adapter基类。 对于所有继承此的adapter只需重写getview方法
 *
 * @param <T>
 * @author devin
 */
public abstract class SimpleAdapter<T> extends BaseAdapter {

    public List<T> data = new ArrayList<T>();
    public int select = -1;
    public LayoutInflater inflater;
    public boolean isSelect = false;
    public Context context;
    private int mItemLayoutId;
    public int position;

    /**
     * @param context
     * @param mItemLayoutId adapter布局文件
     */
    public SimpleAdapter(Context context, int mItemLayoutId) {
        this.context = context;
        inflater = LayoutInflater.from(context);
        this.mItemLayoutId = mItemLayoutId;

    }

    @Override
    public int getCount() {

        if (data != null && data.size() > 0) {
            return data.size();
        }
        return 0;
    }

    @Override
    public T getItem(int position) {

        if (data != null && data.size() > 0) {
            // com.linzi.xiguwen.utils.LogUtil.e("position---------------->", position + "-----" +
            // data.size());
            return data.get(position);
        }
        return null;
    }

    @Override
    public long getItemId(int position) {

        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        final ViewHolder viewHolder = getViewHolder(position, convertView, parent);
        this.position = position;
        getView(viewHolder, getItem(position));
        return viewHolder.getConvertView();

    }

    /**
     * 在此实现BaseAdapter getView方法
     *
     * @param holder
     * @param item
     */
    public abstract void getView(ViewHolder holder, T item);

    private ViewHolder getViewHolder(int position, View convertView, ViewGroup parent) {

        return ViewHolder.get(context, convertView, parent, mItemLayoutId, position);
    }

    /**
     * 第一次或者下拉时加载数据
     *
     * @param data
     */
    public void addFirst(List<T> data) {
        this.data.clear();
        if (data != null && data.size() > 0) {
            this.data.addAll(0, data);
        }
        notifyDataSetChanged();
    }

    /**
     * 加载更多数据
     *
     * @param data
     */
    public void addMore(List<T> data) {

        if (data != null && data.size() > 0) {
            this.data.addAll(data);
            notifyDataSetChanged();
        }
    }

    /**
     * 数据加载
     *
     * @param page
     * @param data
     */
    public void addData(int page, List<T> data) {
        Toast.makeText(context, "" + page, Toast.LENGTH_SHORT).show();
        if (page > 1) {
            addMore(data);
        } else {
            addFirst(data);
        }
    }

    /**
     * 根据postion移除指定的view
     *
     * @param postion
     */
    public void removeView(int postion) {

        this.data.remove(postion);
        notifyDataSetChanged();
    }

    /**
     * 移除所有view
     */
    public void removeAllData() {
        // if (this.data != null) {
        // this.data.clear();
        // notifyDataSetChanged();
        // }

        this.data.clear();
        notifyDataSetChanged();
    }

    public void setData(List<T> data) {
        this.data = data;
        notifyDataSetChanged();
    }

    public List<T> getData() {
        return data;
    }

}
