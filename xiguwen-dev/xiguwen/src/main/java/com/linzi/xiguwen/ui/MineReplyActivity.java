package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MineReplyActivity extends BaseActivity {

    @BindView(R.id.ed_reply)
    EditText edReply;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_reply);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("回复");
        setBack();
        setRight("发送", new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });
    }
}
