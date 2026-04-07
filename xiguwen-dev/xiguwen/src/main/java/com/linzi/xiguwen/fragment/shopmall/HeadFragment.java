package com.linzi.xiguwen.fragment.shopmall;

import android.content.Context;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.bean.ShopMallDetailsBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.NewShopMallDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by pc on 2018/4/7.
 */

public class HeadFragment extends BaseLazyFragment {
    @BindView(R.id.iv_head)
    ImageView ivHead;
    @BindView(R.id.tv_name)
    TextView tvName;
    @BindView(R.id.tv_fans_num)
    TextView tvFansNum;
    @BindView(R.id.iv_care)
    ImageView ivCare;
    @BindView(R.id.recycleview)
    RecyclerView recycleview;

    private int isCared;
    private List<Integer> url;
    private ImageAdapter adapter;

    private int userid;

    public static Fragment create() {
        HeadFragment fragment = new HeadFragment();
        return fragment;
    }

    @Override
    public void onLazyLoad() {

    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.shopmall_head_fr_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    private void initView() {
        ShopMallDetailsBean.UserBean userBean = ((NewShopMallDetailsActivity) getActivity()).getUserBean();
        userid = userBean.getUserid();
        isCared = userBean.getFollow();
        if (isCared == 1) {
            ivCare.setBackgroundResource(R.mipmap.icon_close_care);
        } else {
            ivCare.setBackgroundResource(R.mipmap.icon_add_care);
        }
        GlideLoad.GlideLoadCircle(userBean.getHead(), ivHead);
        tvName.setText(userBean.getNickname());
        tvFansNum.setText("粉丝数：" + userBean.getFans());
        url = new ArrayList<>();

        switch (userBean.getXinyu().getB()) {
            case 1:
                ctrlCredibility(1, userBean.getXinyu().getA());
                break;
            case 2:
                ctrlCredibility(2, userBean.getXinyu().getA());
                break;
            case 3:
                ctrlCredibility(3, userBean.getXinyu().getA());
                break;
            case 4:
                ctrlCredibility(4, userBean.getXinyu().getA());
                break;
            case 5:
                ctrlCredibility(5, userBean.getXinyu().getA());
                break;
        }

        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        manager.setOrientation(LinearLayoutManager.HORIZONTAL);
        recycleview.setLayoutManager(manager);

    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        initView();
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    @OnClick(R.id.iv_care)
    public void onViewClicked() {
        if (isCared == 1) {
            attentionCancel(userid);
        } else {
            attention(userid);
        }
    }

    //控制显示信誉等级
    private void ctrlCredibility(int index, String type) {
        int img = 0;
        switch (type) {
            case "q":
                img = R.mipmap.icon_hq;
                break;
            case "x":
                img = R.mipmap.icon_xx;
                break;
            case "z":
                img = R.mipmap.icon_zs;
                break;
            case "h":
                img = R.mipmap.icon_hg;
                break;
            case "j":
                img = R.mipmap.icon_zz;
                break;
        }
        for (int i = 0; i < index; i++) {
            url.add(img);
        }

        adapter = new ImageAdapter(url, getActivity());
        recycleview.setAdapter(adapter);
    }

    class ImageAdapter extends RecyclerView.Adapter<ImageAdapter.ViewHolder> {

        private List<Integer> url;
        private Context context;

        public ImageAdapter(List<Integer> url, Context context) {
            this.url = url;
            this.context = context;
        }

        @Override
        public ImageAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(context).inflate(R.layout.img_litem, null);
            return new ViewHolder(view);
        }

        @Override
        public void onBindViewHolder(ImageAdapter.ViewHolder holder, int position) {
            holder.img.setBackgroundResource(url.get(position).intValue());
        }

        @Override
        public int getItemCount() {
            return url == null ? 0 : url.size();
        }

        class ViewHolder extends RecyclerView.ViewHolder {
            @BindView(R.id.img)
            ImageView img;

            public ViewHolder(View itemView) {
                super(itemView);
                ButterKnife.bind(this, itemView);
            }
        }
    }

    private void attention(int id) {
        LoadDialog.showDialog(getActivity());
        ApiManager.discoverAttention(id + "", new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                ivCare.setBackgroundResource(R.mipmap.icon_close_care);
                isCared = 1;
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void attentionCancel(int id) {
        LoadDialog.showDialog(getActivity());
        ApiManager.discoverAttentionCancel(id + "", new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                ivCare.setBackgroundResource(R.mipmap.icon_add_care);
                isCared = 0;
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

}
