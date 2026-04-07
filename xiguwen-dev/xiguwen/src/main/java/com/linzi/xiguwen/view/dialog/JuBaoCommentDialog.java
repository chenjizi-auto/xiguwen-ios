package com.linzi.xiguwen.view.dialog;

import android.app.Dialog;
import android.content.Context;
import androidx.annotation.NonNull;

import android.view.Display;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;

import org.json.JSONObject;
import org.xutils.common.Callback;

/**
 * Created by devin on 2018/4/12 17:16
 * Description
 */

public class JuBaoCommentDialog extends Dialog {
    private Context mContext;
    private View mView;


    public JuBaoCommentDialog(@NonNull Context context) {
        super(context, R.style.Theme_Light_FullScreenDialogAct);
        mContext = context;
        LayoutInflater inflater = (LayoutInflater) context
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        mView = inflater.inflate(R.layout.pop_jubao_layout, null);
        this.setContentView(mView);
        setCanceledOnTouchOutside(true);

        EditText etContent = mView.findViewById(R.id.ed_context);

        final String complaint = etContent.getText().toString();
        Button btnSubmit = mView.findViewById(R.id.bt_submit);
        btnSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                int userid = (int) SPUtil.get("userid", SPUtil.Type.INT);
                ApiManager.userComplaint(""+userid,complaint,"1",new Callback.CommonCallback<String>(){
                    @Override
                    public void onSuccess(String result) {
                        try {
                            JSONObject object = new JSONObject(result);
                            NToast.show(object.optString("message"));
                        }catch (Exception e){
                            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                        }
                        dismiss();
                    }

                    @Override
                    public void onError(Throwable ex, boolean isOnCallback) {
                        NToast.show(ex.getMessage());
                    }

                    @Override
                    public void onCancelled(CancelledException cex) {

                    }

                    @Override
                    public void onFinished() {

                    }
                });

            }
        });

        mView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });
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
        super.show();
    }

}
