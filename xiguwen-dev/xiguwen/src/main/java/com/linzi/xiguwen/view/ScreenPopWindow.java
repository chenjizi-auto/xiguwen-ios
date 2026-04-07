package com.linzi.xiguwen.view;

import android.app.Activity;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.fragment.search.MyPopWindow;
import com.linzi.xiguwen.utils.AppUtil;
import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
/**
 * Created by PC on 2018-04-15.
 */

public class ScreenPopWindow {

    @BindView(R.id.rz_one)
    CheckBox rzOne;
    @BindView(R.id.rz_two)
    CheckBox rzTwo;
    @BindView(R.id.rz_three)
    CheckBox rzThree;
    @BindView(R.id.sj_one)
    CheckBox sjOne;
    @BindView(R.id.sj_two)
    CheckBox sjTwo;
    @BindView(R.id.vip_one)
    CheckBox vipOne;
    @BindView(R.id.vip_two)
    CheckBox vipTwo;
    @BindView(R.id.screen_item)
    LinearLayout screenItem;
    @BindView(R.id.price_one)
    EditText priceOne;
    @BindView(R.id.price_two)
    EditText priceTwo;
    @BindView(R.id.pop_submit)
    TextView popSubmit;
    private MyPopWindow screenPopView;
    private View contentView;

    private String floorprice;
    private String ceilingprice;
    private int college;
    private int isshopvip;
    private int platform;
    private int sincerity;
    private int team;
    private ScreenPopSelectListener screenPopSelectListener;

    public ScreenPopWindow(Activity activity, ScreenPopSelectListener screenPopSelectListener) {
        this.screenPopSelectListener = screenPopSelectListener;
        showScreenPop(activity);
        ButterKnife.bind(this, contentView);
    }

    public void showScreenPop(Activity activity) {
        contentView = LayoutInflater.from(activity).inflate(R.layout.pop_search_screen, null);
        //处理popWindow 显示内容
//            listView = contentView.findViewById(R.id.pop_list);
//            handleListView(listView);
        //创建并显示popWindow
        int width = AppUtil.getWidth(activity) * 3 / 4;
        screenPopView = new MyPopWindow.PopupWindowBuilder(activity)
                .setView(contentView)
                .size(width, ViewGroup.LayoutParams.MATCH_PARENT)//显示大小
                .setOutsideTouchable(true)
                .enableBackgroundDark(true)
                .create();


//        screenPopView.showAsDropDown(rbScreen, 0, 1);
//        screenPopView.showBackgroundDark();
//        screenPopView.showAtLocation(rbScreen, Gravity.RIGHT, 0, 0);

    }


    public void hideHeaderView() {
        screenItem.setVisibility(View.GONE);
    }

    public void show(View view) {
        screenPopView.showBackgroundDark();
        screenPopView.showAtLocation(view, Gravity.RIGHT, 0, 0);
    }


    public String getFloorprice() {
        return floorprice;
    }

    public String getCeilingprice() {
        return ceilingprice;
    }

    public int getCollege() {
        return college;
    }

    public int getIsshopvip() {
        return isshopvip;
    }

    public int getPlatform() {
        return platform;
    }

    public int getSincerity() {
        return sincerity;
    }

    public int getTeam() {
        return team;
    }

    @OnClick(R.id.pop_submit)
    public void onViewClicked() {
        floorprice = priceOne.getText().toString().trim();
        ceilingprice = priceTwo.getText().toString().trim();
        if (rzOne.isChecked()) {
            sincerity = 1;
        } else {
            sincerity = 0;
        }
        if (rzTwo.isChecked()) {
            platform = 1;
        } else {
            platform = 0;
        }
        if (rzThree.isChecked()) {
            college = 1;
        } else {
            college = 0;
        }

        if (sjOne.isChecked() && sjTwo.isChecked()) {
            team = 0;
        } else if (!sjOne.isChecked() && !sjTwo.isChecked()) {
            team = 0;
        } else {
            if (sjOne.isChecked()) {
                team = 1;
            }
            if (sjTwo.isChecked()) {
                team = 2;
            }
        }

        if (vipOne.isChecked()&&vipTwo.isChecked()){
            isshopvip=0;
        }else if (!vipOne.isChecked()&&!vipTwo.isChecked()){
            isshopvip=0;
        }else {
            if (vipOne.isChecked()) {
                isshopvip = 1;
            }
            if (vipTwo.isChecked()) {
                isshopvip = 2;
            }
        }
        screenPopView.dissmiss();
        if (screenPopSelectListener != null) {
            screenPopSelectListener.ScreenSelect(floorprice, ceilingprice, college, isshopvip, platform, sincerity, team);
        }
    }

    public interface ScreenPopSelectListener {
        void ScreenSelect(String floorprice,
                          String ceilingprice, int college, int isshopvip, int platform,
                          int sincerity, int team);
    }
}
