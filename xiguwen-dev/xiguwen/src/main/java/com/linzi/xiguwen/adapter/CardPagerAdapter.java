package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.viewpager.widget.PagerAdapter;
import androidx.cardview.widget.CardView;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.PopupWindow;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.UnitByJson;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.view.PostEditReuslt;
import com.linzi.xiguwen.view.TextEditPopWindow;

import java.util.ArrayList;
import java.util.List;

public class CardPagerAdapter extends PagerAdapter implements CardAdapter {

    private List<CardView> mViews;
    private List<CardItem> mData;
    private float mBaseElevation;
    private Context context;

    private String content;

    private String json = "{\"bean\":[{\"page\":1,\"imageviewnum\":2,\"textviewnum\":1,\"unitBean\":[{\"type\":3,\"left\":92,\"top\":146,\"shape\":1,\"size\":0,\"index\":1,\"color\":\"\",\"width\":185,\"height\":185,\"layer\":2,\"value\":\"http://www.boyihunjia.com/h5/day2/img/4.jpg\"},{\"type\":2,\"left\":150,\"top\":474,\"shape\":0,\"size\":13,\"index\":1,\"color\":\"#000\",\"width\":92,\"height\":18,\"layer\":2,\"value\":\"各位亲朋好友：\"},{\"type\":2,\"left\":40,\"top\":505,\"shape\":0,\"size\":13,\"index\":2,\"color\":\"#000\",\"width\":265,\"height\":75,\"layer\":2,\"value\":\"我们决定奔向所有人向往的温馨甜蜜，并誓将快乐幸福进行到底。请第一时间前来参加我们的婚礼，为我们见证与祝福，谢谢！\"}],\"banckground\":\"http://yiniu.qanlian.com/s/b2.jpg\"},\n" +
            "{\"page\":1,\"imageviewnum\":2,\"textviewnum\":1,\"unitBean\":[{\"type\":3,\"left\":92,\"top\":146,\"shape\":1,\"size\":0,\"index\":1,\"color\":\"\",\"width\":185,\"height\":185,\"layer\":2,\"value\":\"http://www.boyihunjia.com/h5/day2/img/4.jpg\"},{\"type\":2,\"left\":150,\"top\":474,\"shape\":0,\"size\":13,\"index\":1,\"color\":\"#000\",\"width\":92,\"height\":18,\"layer\":2,\"value\":\"各位亲朋好友：\"},{\"type\":2,\"left\":40,\"top\":505,\"shape\":0,\"size\":13,\"index\":2,\"color\":\"#000\",\"width\":265,\"height\":75,\"layer\":2,\"value\":\"我们决定奔向所有人向往的温馨甜蜜，并誓将快乐幸福进行到底。请第一时间前来参加我们的婚礼，为我们见证与祝福，谢谢！\"}],\"banckground\":\"http://yiniu.qanlian.com/s/b2.jpg\"},\n" +
            "{\"page\":1,\"imageviewnum\":2,\"textviewnum\":1,\"unitBean\":[{\"type\":3,\"left\":92,\"top\":146,\"shape\":1,\"size\":0,\"index\":1,\"color\":\"\",\"width\":185,\"height\":185,\"layer\":2,\"value\":\"http://www.boyihunjia.com/h5/day2/img/4.jpg\"},{\"type\":2,\"left\":150,\"top\":474,\"shape\":0,\"size\":13,\"index\":1,\"color\":\"#000\",\"width\":92,\"height\":18,\"layer\":2,\"value\":\"各位亲朋好友：\"},{\"type\":2,\"left\":40,\"top\":505,\"shape\":0,\"size\":13,\"index\":2,\"color\":\"#000\",\"width\":265,\"height\":75,\"layer\":2,\"value\":\"我们决定奔向所有人向往的温馨甜蜜，并誓将快乐幸福进行到底。请第一时间前来参加我们的婚礼，为我们见证与祝福，谢谢！\"}],\"banckground\":\"http://yiniu.qanlian.com/s/b2.jpg\"},\n" +
            "{\"page\":1,\"imageviewnum\":2,\"textviewnum\":1,\"unitBean\":[{\"type\":3,\"left\":92,\"top\":146,\"shape\":1,\"size\":0,\"index\":1,\"color\":\"\",\"width\":185,\"height\":185,\"layer\":2,\"value\":\"http://www.boyihunjia.com/h5/day2/img/4.jpg\"},{\"type\":2,\"left\":150,\"top\":474,\"shape\":0,\"size\":13,\"index\":1,\"color\":\"#000\",\"width\":92,\"height\":18,\"layer\":2,\"value\":\"各位亲朋好友：\"},{\"type\":2,\"left\":40,\"top\":505,\"shape\":0,\"size\":13,\"index\":2,\"color\":\"#000\",\"width\":265,\"height\":75,\"layer\":2,\"value\":\"我们决定奔向所有人向往的温馨甜蜜，并誓将快乐幸福进行到底。请第一时间前来参加我们的婚礼，为我们见证与祝福，谢谢！\"}],\"banckground\":\"http://yiniu.qanlian.com/s/b2.jpg\"},\n" +
            "{\"page\":1,\"imageviewnum\":2,\"textviewnum\":1,\"unitBean\":[{\"type\":3,\"left\":92,\"top\":146,\"shape\":1,\"size\":0,\"index\":1,\"color\":\"\",\"width\":185,\"height\":185,\"layer\":2,\"value\":\"http://www.boyihunjia.com/h5/day2/img/4.jpg\"},{\"type\":2,\"left\":150,\"top\":474,\"shape\":0,\"size\":13,\"index\":1,\"color\":\"#000\",\"width\":92,\"height\":18,\"layer\":2,\"value\":\"各位亲朋好友：\"},{\"type\":2,\"left\":40,\"top\":505,\"shape\":0,\"size\":13,\"index\":2,\"color\":\"#000\",\"width\":265,\"height\":75,\"layer\":2,\"value\":\"我们决定奔向所有人向往的温馨甜蜜，并誓将快乐幸福进行到底。请第一时间前来参加我们的婚礼，为我们见证与祝福，谢谢！\"}],\"banckground\":\"http://yiniu.qanlian.com/s/b2.jpg\"},{\"page\":2,\"imageviewnum\":2,\"textviewnum\":1,\"unitBean\":[{\"type\":3,\"left\":92,\"top\":146,\"shape\":1,\"size\":0,\"index\":1,\"color\":\"\",\"width\":185,\"height\":185,\"layer\":2,\"value\":\"http://www.boyihunjia.com/h5/day2/img/4.jpg\"},{\"type\":2,\"left\":150,\"top\":474,\"shape\":0,\"size\":13,\"index\":1,\"color\":\"#000\",\"width\":92,\"height\":18,\"layer\":2,\"value\":\"各位亲朋好友：\"},{\"type\":2,\"left\":40,\"top\":505,\"shape\":0,\"size\":13,\"index\":2,\"color\":\"#000\",\"width\":265,\"height\":75,\"layer\":2,\"value\":\"我们决定奔向所有人向往的温馨甜蜜，并誓将快乐幸福进行到底。请第一时间前来参加我们的婚礼，为我们见证与祝福，谢谢！\"}],\"banckground\":\"http://yiniu.qanlian.com/s/b2.jpg\"}]}\n";

    private double pageWidth;
    private double pageHeight;
    double paddingLeft, paddingTop, viewWidth, viewHeight, paddingBili, viewBili;

    public CardPagerAdapter(Context context) {
        this.context = context;
        mData = new ArrayList<>();
        mViews = new ArrayList<>();
    }

    public void addCardItem(CardItem item) {
        mViews.add(null);
        mData.add(item);
    }

    public float getBaseElevation() {
        return mBaseElevation;
    }

    @Override
    public CardView getCardViewAt(int position) {
        return mViews.get(position);
    }

    @Override
    public int getCount() {
        return mData.size();
    }

    @Override
    public boolean isViewFromObject(View view, Object object) {
        return view == object;
    }

    @Override
    public Object instantiateItem(ViewGroup container, int position) {
        final View view = LayoutInflater.from(container.getContext())
                .inflate(R.layout.adapter, container, false);
        container.addView(view);
        bind(mData.get(position), view);

//        paddingBili = 1.875;
//        viewBili = 1.779;

        final CardView cardView = view.findViewById(R.id.cardView);

//        ViewTreeObserver viewTreeObserver = cardView.getViewTreeObserver();
//        viewTreeObserver.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
//            @Override
//            public void onGlobalLayout() {
//                pageHeight = cardView.getHeight();
//                pageWidth = pageHeight / viewBili;
//
//                RelativeLayout.LayoutParams layoutParams = (RelativeLayout.LayoutParams) cardView.getLayoutParams();
//                layoutParams.height = (int) pageHeight;
//                layoutParams.width = (int) pageWidth;
//                cardView.setLayoutParams(layoutParams);
//
//                paddingTop = (viewBili * pageWidth - pageHeight) / 1.75;
//                paddingLeft = paddingTop * paddingBili;
//                viewWidth = pageWidth - 2 * paddingLeft;
//                viewHeight = pageHeight - 2 * paddingTop;
//                NToast.log("apptag", viewHeight + "\n" + viewWidth);
//                // view.setPadding((int) paddingLeft, (int) paddingTop, (int) paddingLeft, (int) paddingTop);
//            }
//        });

        RelativeLayout rlUnit = (RelativeLayout) view.findViewById(R.id.rl_unit);

        if (mBaseElevation == 0) {
            mBaseElevation = cardView.getCardElevation();
        }

        cardView.setMaxCardElevation(mBaseElevation * MAX_ELEVATION_FACTOR);
        mViews.set(position, cardView);

        createView(json, rlUnit, mData.get(position));
        return view;
    }

    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {
        container.removeView((View) object);
        mViews.set(position, null);
    }

    private void bind(CardItem item, View view) {
        ImageView titleTextView = (ImageView) view.findViewById(R.id.iv_img);
        GlideLoad.GlideLoadImgNoCenter(item.getImgResource(), titleTextView);
    }

    private List<UnitByJson.BeanBean> unitBeans;

    //解析json生成对应的UI
    private void createView(String json, final RelativeLayout rootView, CardItem item) {
//        unitBeans = new Gson().fromJson(json, UnitByJson.class).getBean();
//        for (int i = 0; i < unitBeans.size(); i++) {
//            if (unitBeans.get(i).getPage() == item.getIndex()) {
//                List<UnitByJson.BeanBean.UnitBeanBean> unitBeanBeanList = unitBeans.get(i).getUnitBean();
//                for (int j = 0; j < unitBeanBeanList.size(); j++) {
//                    if (unitBeanBeanList.get(j).getType() == 2) {//文本
//                        final TextView textView = new TextView(context);
//                        textView.setText(unitBeanBeanList.get(j).getValue());
//                        textView.setPadding(20, 20, 20, 20);
//                        content = unitBeanBeanList.get(j).getValue();
//                        textView.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View view) {
//                                //textView.setBackgroundResource(R.drawable.m_editable_textimageview_bg);
//                                createPopWindows(textView, content);
//                            }
//                        });
//
//                        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
//                        layoutParams.topMargin = unitBeanBeanList.get(j).getTop();
//                        layoutParams.leftMargin = unitBeanBeanList.get(j).getLeft();
//                        rootView.addView(textView, layoutParams);
//                    } else {//图片框
//                        final ImageView imageView = new ImageView(context);
//                        GlideLoad.GlideLoadImgNoCenter(unitBeanBeanList.get(j).getValue(), imageView);
//                        content = unitBeanBeanList.get(j).getValue();
//                        imageView.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View view) {
//                                //textView.setBackgroundResource(R.drawable.m_editable_textimageview_bg);
//                                ImageSelect.ActivityImageSelectSingle((Activity) context, context, 1001);
//                            }
//                        });
//
//                        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
//                        layoutParams.topMargin = unitBeanBeanList.get(j).getTop();
//                        layoutParams.leftMargin = unitBeanBeanList.get(j).getLeft();
//                        rootView.addView(imageView, layoutParams);
//                    }
//                }
//            }
//        }
    }


    private void createPopWindows(final TextView view, String content) {
        TextEditPopWindow textEditPopWindow = new TextEditPopWindow(context, content);
        textEditPopWindow.setInputMethodMode(PopupWindow.INPUT_METHOD_NEEDED);
        textEditPopWindow.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
        textEditPopWindow.setPostEditReuslt(new PostEditReuslt() {
            @Override
            public void onSubmit(String str) {
                view.setText(str);
            }
        });


        textEditPopWindow.showAtLocation(view, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
    }

}
