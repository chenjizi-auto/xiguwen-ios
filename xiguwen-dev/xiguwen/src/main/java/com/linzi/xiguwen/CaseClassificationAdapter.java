package com.linzi.xiguwen;

import android.content.Context;
import android.view.View;
import android.widget.TextView;

import com.linzi.xiguwen.adapter.base.SimpleAdapter;
import com.linzi.xiguwen.adapter.base.ViewHolder;
import com.linzi.xiguwen.bean.CaseTypeEntity;
import com.linzi.xiguwen.interfacelistener.PopSelectListener;

/**
 * Created by PC on 2018-04-15.
 */

public class CaseClassificationAdapter extends SimpleAdapter<CaseTypeEntity> {

    public static final int CODE_TYPE = 12;
    public static final int CODE_ENVITONMENT = 13;
    private PopSelectListener listener;
    private int code;

    /**
     * @param context
     */
    public CaseClassificationAdapter(Context context, PopSelectListener listener) {
        super(context, R.layout.item_pop_list);
        this.listener = listener;
    }

    public void setCode(int code) {
        this.code = code;
    }

    @Override
    public void getView(ViewHolder holder, final CaseTypeEntity item) {
        TextView txTitle = holder.getView(R.id.pop_tx);
        txTitle.setText(item.getTitle());
        txTitle.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (listener != null) {
                    listener.popSelect(code, item.getId(), item.getTitle());
                }

            }
        });
    }
}
