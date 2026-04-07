package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MyGradeBean;

import java.util.HashMap;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class MineDangqiChooseNoticeActivity extends BaseActivity {

    @BindView(R.id.ll_caipai)
    LinearLayout llCaipai;
    @BindView(R.id.ll_yuejian)
    LinearLayout llYuejian;
    @BindView(R.id.ll_other)
    LinearLayout llOther;

    HashMap<Integer, MyGradeBean.Grade.RemindData> mDatas;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_dangqi_choose_notice);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("添加提醒");
        setBack();
        mDatas = (HashMap<Integer, MyGradeBean.Grade.RemindData>) getIntent().getSerializableExtra("data");
        if(mDatas == null){
            mDatas = new HashMap<>();
        }
    }

    @OnClick({R.id.ll_caipai, R.id.ll_yuejian, R.id.ll_other})
    public void onClick(View view) {
        Intent intent;
        switch (view.getId()) {
            case R.id.ll_caipai:
                 intent=new Intent(this,CaiPaiTixingActivity.class);
                 intent.putExtra("data", mDatas.get(MyGradeBean.Grade.RemindData.TYPE_CAIPAI));
                 startActivityForResult(intent ,100);
                break;
            case R.id.ll_yuejian:
                 intent=new Intent(this,YueJianTixingActivity.class);
                 intent.putExtra("data", mDatas.get(MyGradeBean.Grade.RemindData.TYPE_YUEJIAN));
                 startActivityForResult(intent , 101);
                break;
            case R.id.ll_other:
                 intent=new Intent(this,OtherTixingActivity.class);
                 intent.putExtra("data", mDatas.get(MyGradeBean.Grade.RemindData.TYPE_QITA));
                 startActivityForResult(intent, 102);
                break;
        }
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(resultCode == RESULT_OK){
            switch (requestCode){
                case 100:
                    mDatas.put(MyGradeBean.Grade.RemindData.TYPE_CAIPAI, (MyGradeBean.Grade.RemindData) data.getSerializableExtra("data"));
                    break;
                case 101:
                    mDatas.put(MyGradeBean.Grade.RemindData.TYPE_YUEJIAN, (MyGradeBean.Grade.RemindData) data.getSerializableExtra("data"));
                    break;
                case 102:
                    mDatas.put(MyGradeBean.Grade.RemindData.TYPE_QITA, (MyGradeBean.Grade.RemindData) data.getSerializableExtra("data"));
                    break;
            }
        }
    }

    @Override
    public void finish() {
        if(mDatas.size() != 0){
            Intent data = new Intent();
            data.putExtra("data", mDatas);
            setResult(RESULT_OK, data);
        }
        super.finish();
    }
}
