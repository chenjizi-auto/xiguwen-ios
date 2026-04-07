package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.UserEntity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.luck.picture.lib.utils.ToastUtils;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class EditNicknameActivity extends BaseActivity {

    @BindView(R.id.ed_nickname)
    EditText edNickname;
    @BindView(R.id.iv_del)
    ImageView ivDel;

    public int code;
    private String content;


    public static void startAction(Context context, String content, int code) {
        Intent intent = new Intent(context, EditNicknameActivity.class);
        intent.putExtra("code", code);
        intent.putExtra("content", content);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_nickname);
        ButterKnife.bind(this);

    }

    @Override
    protected void initData() {
        code = getIntent().getIntExtra("code", 0);
        content = getIntent().getStringExtra("content");
        if (content != null) {
            edNickname.setText(content);
        }
        if (code == EventCode.USER_UPTATE_NAME) {
            setTitle("设置昵称");
        } else if (code == EventCode.USER_UPTATE_HEIGHT) {
            setTitle("修改身高");
            edNickname.setInputType(InputType.TYPE_CLASS_NUMBER);
            edNickname.setHint("身高cm");
        } else if (code == EventCode.USER_UPTATE_WEITHT) {
            edNickname.setHint("体重kg");
            edNickname.setInputType(InputType.TYPE_CLASS_NUMBER);
            setTitle("修改体重");

        } else if (code == EventCode.USER_UPTATE_ADDRESS) {
            setTitle("修改地址");
            edNickname.setHint("请输入地址");
        }
        setBack();
        setRight("确定", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                content = edNickname.getText().toString().trim();
                if (!AppUtil.isEmpty(content)) {
//                    UserEntity userEntity = new UserEntity();
//                    if (code == EventCode.USER_UPTATE_NAME) {
//                        userEntity.setNickname(content);
//                    } else if (code == EventCode.USER_UPTATE_HEIGHT) {
//                        userEntity.setHeight(content);
//                    } else if (code == EventCode.USER_UPTATE_WEITHT) {
//                        userEntity.setWeight(content);
//                    } else if (code == EventCode.USER_UPTATE_ADDRESS) {
//                        userEntity.setAddress(content);
//                    }
//                    updateUserInfo(userEntity);
                    EventBusUtil.sendEvent(new Event(code, content));
                    finish();
                }
            }
        });

        edNickname.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {
            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                if (charSequence.length() == 0) {
                    ivDel.setVisibility(View.GONE);
                } else {
                    ivDel.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });
    }

    @OnClick(R.id.iv_del)
    public void onClick() {
        edNickname.setText("");

    }


    private void updateUserInfo(UserEntity userEntity) {
        LoadDialog.showDialog(this);
        ApiManager.userInfoUpdate(userEntity, new OnRequestSubscribe<BaseBean<UserEntity>>() {
            @Override
            public void onSuccess(BaseBean<UserEntity> data) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, "修改成功");
                EventBusUtil.sendEvent(new Event(code, content));
                finish();
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, ex.getMessage());
            }
        });
    }
}
