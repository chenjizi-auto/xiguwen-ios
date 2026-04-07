package com.linzi.xiguwen.view;

import android.app.Activity;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.AppUtil;

/**
 * Created by pc on 2018/5/18.
 */

public class TextEditPopWindow extends PopupWindow {
    private Context context;
    // private Activity activity;
    private View rootView;
    private PostEditReuslt postEditReuslt;

    private EditText editText;
    private TextView button;

    private String content;

    public void setPostEditReuslt(PostEditReuslt postEditReuslt) {
        this.postEditReuslt = postEditReuslt;
    }

    public TextEditPopWindow(Context context, String content) {
        super(context);
        this.context = context;
        this.content = content;
        //this.activity = activity;
        rootView = LayoutInflater.from(context).inflate(R.layout.text_edit_pop_layout, null);
        initView();
    }

    private void initView() {
        // 设置弹出窗体可点击
        setFocusable(true);
        int w = ((Activity) context).getWindowManager().getDefaultDisplay().getWidth();
        //int h = AppUtil.dip2px(context, 50);
        setWidth(w);
        //setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0xffffff);
        // 设置弹出窗体的背景
        setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
         setAnimationStyle(R.style.AnimationPreview);
        setContentView(rootView);
        update();


        button = (TextView) rootView.findViewById(R.id.bt_sure);
        editText = (EditText) rootView.findViewById(R.id.et_editext);

        editText.setFocusable(true);
        editText.setFocusableInTouchMode(true);
        editText.requestFocus();
        //打开软键盘
        InputMethodManager imm = (InputMethodManager) context.getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.toggleSoftInput(0, InputMethodManager.HIDE_NOT_ALWAYS);

        if (content != null && !content.equals("")) {
            editText.setText(content);
        } else {
            editText.setHint("请输入需要展示的内容...");
        }
        editText.setSelection(editText.getText().length());

        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                postEditReuslt.onSubmit(editText.getText().toString().trim());
                dismiss();
            }
        });

        setOnDismissListener(new OnDismissListener() {
            @Override
            public void onDismiss() {
                InputMethodManager imm = (InputMethodManager) context.getSystemService(Context.INPUT_METHOD_SERVICE);
                imm.hideSoftInputFromWindow(editText.getWindowToken(), 0);
            }
        });
    }
}
