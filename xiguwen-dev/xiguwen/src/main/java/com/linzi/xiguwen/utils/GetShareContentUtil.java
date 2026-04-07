package com.linzi.xiguwen.utils;

import android.app.Activity;

import com.linzi.xiguwen.bean.ShareContentBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;

/**
 * Created by pc on 2018/4/26.
 */

public class GetShareContentUtil {
    private static ShareContentBean shareContentBean;

    /**
     * @param id
     * @param type  1-10必须传id和type,9,10必须传三个参数，id，type,types 11，12必须传types和type不用传id
     *              <p>
     *              1://商品分享2://报价分享3://婚庆商家详情4://案例分享5://档期分享6://需求分享7://商家详情页8://社团详情页分享
     *              9://特别推荐、婚礼预约、新娘捧花、婚礼甜品，结婚对戒分享10://有好货、必买清单、爱逛街、限时抢购、抢爆款、男士专区分享
     *              11://热门-今日推荐，本周人气，本月人气，本周热门，本月热门分享12: //案例-今日推荐，本周人气，本月人气，本周热门，本月热门分享
     * @param types 9: 1 特别推荐、2 婚礼预约、3 新娘捧花、4婚礼甜品，5结婚对戒
     *              10:1有好货、2必买清单、3爱逛街、4限时抢购、5抢爆款、6男士专
     *              11，12: 1今日推荐，2本周人气，3本月人气，4本周热门，5本月热门
     * @return
     */
    public static void getContent(final Activity context, int id, int type, int types) {
        shareContentBean = new ShareContentBean();
        LoadDialog.showDialog(context);
        ApiManager.getShareContent(id, type, types, new OnRequestFinish<BaseBean<ShareContentBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ShareContentBean> data) {
                shareContentBean = data.getData();
                ShareUtils.showShare(context, shareContentBean.getUrl(), shareContentBean.getTitle(), shareContentBean.getImage(), shareContentBean.getDescr());
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    public static void getActivityContent(final Activity context, String str, int type) {
        shareContentBean = new ShareContentBean();
        LoadDialog.showDialog(context);
        ApiManager.getActivityShareContent(str, type, new OnRequestFinish<BaseBean<ShareContentBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ShareContentBean> data) {
                shareContentBean = data.getData();
                ShareUtils.showShare(context, shareContentBean.getUrl(), shareContentBean.getTitle(), shareContentBean.getImage(), shareContentBean.getDescr());
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }
}
