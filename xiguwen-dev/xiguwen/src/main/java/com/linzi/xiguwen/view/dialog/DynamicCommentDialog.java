package com.linzi.xiguwen.view.dialog;

import android.app.Dialog;
import android.content.Context;
import androidx.annotation.NonNull;
import android.text.TextUtils;
import android.view.Display;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.AppUtil;

/**
 * Created by devin on 2018/4/12 17:16
 * Description
 */

public class DynamicCommentDialog extends Dialog {
    private Context mContext;
    private View mView;
    private EditText etContent;
    private TextView txSend;
    private long currentPosition;
    public VideoBarrageSendListener listener;

    public void setListener(VideoBarrageSendListener listener) {
        this.listener = listener;
    }

    public DynamicCommentDialog(@NonNull Context context) {
        super(context, R.style.Theme_Light_FullScreenDialogAct);
        mContext = context;
        LayoutInflater inflater = (LayoutInflater) context
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        mView = inflater.inflate(R.layout.pop_reply_layout, null);
        this.setContentView(mView);
        etContent = mView.findViewById(R.id.ed_reply);
        txSend = mView.findViewById(R.id.tv_send);
        setCanceledOnTouchOutside(true);
        mView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });
        txSend.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String message = etContent.getText().toString().trim();
                if (listener != null && !TextUtils.isEmpty(message)) {
                    listener.dialogBarrageSend(currentPosition, message);
                    etContent.setText("");
                    AppUtil.clearInputMethod(etContent);
                    dismiss();
                }
            }
        });

    }


    public void setCurrentPosition(long currentPosition) {
        this.currentPosition = currentPosition;
    }


    @Override
    public void show() {

        Window window = this.getWindow();
        WindowManager m = (WindowManager) mContext.getSystemService(Context.WINDOW_SERVICE);
        Display display = m.getDefaultDisplay(); // 获取屏幕宽
        WindowManager.LayoutParams p = window.getAttributes(); // 获取对话框当前的参数值、高用
        p.width = (int) (display.getWidth()); // 宽度设置为屏幕的
        window.setAttributes(p);
        window.setGravity(Gravity.BOTTOM); // 此处可以设置dialog显示的位置


        getWindow().clearFlags(WindowManager.LayoutParams.FLAG_ALT_FOCUSABLE_IM);
        //弹出对话框后直接弹出键盘
        etContent.setFocusableInTouchMode(true);
        etContent.requestFocus();

        super.show();
    }

    public interface VideoBarrageSendListener {
        void dialogBarrageSend(long currentPosition, String message);
    }

    public void openInputMethoe() {
        InputMethodManager inputManager = (InputMethodManager) etContent.getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
        inputManager.showSoftInput(etContent, 0);
    }
}
