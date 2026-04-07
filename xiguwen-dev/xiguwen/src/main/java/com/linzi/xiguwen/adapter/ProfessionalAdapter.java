package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.view.View;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.base.SimpleAdapter;
import com.linzi.xiguwen.adapter.base.ViewHolder;
import com.linzi.xiguwen.bean.ClassificationBean;
import com.linzi.xiguwen.interfacelistener.PopSelectListener;

/**
 * Created by PC on 2018-04-14.
 */

public class ProfessionalAdapter extends SimpleAdapter<ClassificationBean> {
    private PopSelectListener listener;
    public static final int Code = 10;

    /**
     * @param context
     */
    public ProfessionalAdapter(Context context, PopSelectListener listener) {
        super(context, R.layout.item_pop_list);
        this.listener = listener;
    }

    @Override
    public void getView(ViewHolder holder, final ClassificationBean item) {
        TextView txTitle = holder.getView(R.id.pop_tx);
        txTitle.setText(item.getProname());
        txTitle.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (listener != null) {
                    listener.popSelect(Code, item.getOccupationid(), item.getProname());
                }

            }
        });
    }


}
