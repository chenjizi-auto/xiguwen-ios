package com.linzi.xiguwen.network;

import androidx.annotation.Nullable;
import android.text.TextUtils;

import com.google.gson.reflect.TypeToken;
import com.linzi.xiguwen.bean.*;
import com.linzi.xiguwen.fragment.shop.model.bean.DongTaiBean;
import com.linzi.xiguwen.fragment.shop.model.bean.EvaluateBean;
import com.linzi.xiguwen.fragment.shop.model.bean.WorksBean;
import com.linzi.xiguwen.net.Api;
import com.linzi.xiguwen.net.BaseCallBack;
import com.linzi.xiguwen.net.MapUtils;
import com.linzi.xiguwen.net.MapUtilsX;
import com.linzi.xiguwen.net.OkHttpRequest;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.ui.MineListActivity;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;

import org.xutils.common.Callback;
import org.xutils.common.util.KeyValue;
import org.xutils.common.util.LogUtil;
import org.xutils.http.RequestParams;
import org.xutils.http.body.MultipartBody;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by linzi on 2017/6/6.
 */

public class ApiManager {
    int page_num = 6;

    /**
     * xutils中封装的okhttp请求方式
     *
     * @param url  接口地址
     * @param data 参数
     * @param call 回调信息
     */
    public void Example(String url, String data, Callback.CommonCallback call) {
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("参数名", data);
        OkHttpRequest.post(params, call);
    }

    /**
     * 获取城市
     *
     * @param call
     */
    public void getCity(Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST + Constans.Type.LOGIN + Constans.Action.CITY;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("time", "" + System.currentTimeMillis());
//        params.addBodyParameter("token","");
        OkHttpRequest.post(params, call);
    }

    /**
     * 获取城市
     *
     * @param call
     */
    public static void cityList(OnRequestSubscribe<BaseBean<CityData>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.CITY;
        RequestParams params = new RequestParams(url);
//        params.addBodyParameter("time", "" + System.currentTimeMillis());
//        params.addBodyParameter("token","");
        OkHttpRequest.post(params, new BaseCallBack<>(new TypeToken<BaseBean<CityData>>() {
        }, call));
    }

    /**
     * 用户登录
     */
    public void login(String phone, String pwd, int type, String login_id, String registrationid, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.LOGIN;
//        NToast.log("url", url);
//        NToast.log("type", "" + type);
//        NToast.log("mobile", phone);
//        NToast.log("password", pwd);
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("type", "" + type);
        params.addBodyParameter("registrationid", registrationid);
        if (type != 0) {
            params.addBodyParameter("thirdSystemId", login_id);
        } else {
            params.addBodyParameter("mobile", phone);
            params.addBodyParameter("password", pwd);
        }
//        params.addBodyParameter("token","");
        com.linzi.xiguwen.utils.LogUtil.e("addBodyParameter ",params.toString() );
        OkHttpRequest.post(params, call);
    }


    /**
     * 用户注销
     */
    public static void userCancel(String userid, String status, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.UserCancel;
//        NToast.log("url", url);
//        NToast.log("type", "" + type);
//        NToast.log("mobile", phone);
//        NToast.log("password", pwd);
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("userid", "" + userid);
        params.addBodyParameter("status", status);
//        params.addBodyParameter("token","");
        OkHttpRequest.post(params, call);
    }


    /**
     * 用户投诉
     */
    public static void userComplaint(String userid,String complaint, String status, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.COMPLAINT;
//        NToast.log("url", url);
//        NToast.log("type", "" + type);
//        NToast.log("mobile", phone);
//        NToast.log("password", pwd);
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("userid", "" + userid);
        params.addBodyParameter("complaint", "" + userid);
        params.addBodyParameter("status", status);
//        params.addBodyParameter("token","");
        OkHttpRequest.post(params, call);
    }

    /**
     * 用户登录
     */
    public void loginOther(String nickname, String head, String sex, int type, String login_id, String registrationid, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.LOGIN_OTHER;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("type", "" + type);
        params.addBodyParameter("thirdSystemId", login_id);
        params.addBodyParameter("registrationid", registrationid);
        params.addBodyParameter("nickname", nickname);
        params.addBodyParameter("head", head);
        params.addBodyParameter("sex", sex);
//        params.addBodyParameter("token","");
        OkHttpRequest.post(params, call);
    }


    /**
     * 获取验证码
     */
    public void getSms(String phone, String type, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.GETSMS;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("type", "" + type);
        params.addBodyParameter("mobile", phone);
        OkHttpRequest.post(params, call);
    }

    /**
     * 获取验证码
     */
    public static void getSms1(String phone, String type, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.GETSMS;
        MapUtils mapUtils = MapUtils.create();
        if (type != null) {
            mapUtils.putBody("type", type);
        }
        mapUtils.putBody("mobile", phone);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    public void register(String phone, String code, String pwd, String pwd2, int type, String province, String city, String county, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.RIGIST;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("type", "" + type);
        params.addBodyParameter("code", code);
        params.addBodyParameter("mobile", phone);
        params.addBodyParameter("password", pwd);
        params.addBodyParameter("repassword", pwd2);
        params.addBodyParameter("province", province);
        params.addBodyParameter("city", city);
        params.addBodyParameter("county", county);
        OkHttpRequest.post(params, call);
    }

    //第三方注册后绑定手机号码
    public static void registerOther(String phone, String code, String pwd, String pwd2, int type, String userid, String token, String province, String city, String county, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.BIND_OTHER_PHONE;
//        RequestParams params = new RequestParams(url);
        MapUtils params = MapUtils.create();
        params.putBody("type", "" + type);
        params.putBody("code", code);
        params.putBody("mobile", phone);
        params.putBody("password", pwd);
        params.putBody("passwords", pwd2);
        params.putBody("userid", userid);
        params.putBody("token", token);
        params.putBody("province", province);
        params.putBody("city", city);
        params.putBody("county", county);
//        OkHttpRequest.post(params, call);
        Api.post(url, params, new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    public void ForGot(String phone, String code, String pwd, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.FORGOT;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("code", code);
        params.addBodyParameter("mobile", phone);
        params.addBodyParameter("password", pwd);
        OkHttpRequest.post(params, call);
    }

    /**
     * 获取首页数据
     *
     * @param city_id
     * @param token
     * @param user_id
     * @param page
     * @param call
     */
    public void getIndex(String city_id, String token, String user_id, int page, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME + Constans.Action.INDEX;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("city_id", city_id);
        params.addBodyParameter("p", "" + page);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", user_id);
        OkHttpRequest.post(params, call);
    }

    /**
     * 获取婚庆首页数据
     *
     * @param cityid
     * @param call
     */
    public static void getIndex(String cityid, OnRequestSubscribe<BaseBean<NewIndexBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME + Constans.Action.INDEX;
        Api.post(url, MapUtils.createToken().putBody("cityid", cityid), new BaseCallBack<>(new TypeToken<BaseBean<NewIndexBean>>() {
        }, call));
    }

    /**
     * 获取婚庆首页菜单分类数据
     *
     * @param call
     */
    public static void getIndexWeddingType(OnRequestSubscribe<BaseBean<ArrayList<IndexWeddingTypeBean>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME + Constans.Action.GET_HUNQIN_MENU;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<IndexWeddingTypeBean>>>() {
        }, call));
    }

    /**
     * 取消商品关注
     *
     * @param user_id
     * @param token
     * @param id
     * @param call
     */
    public void delCare(int user_id, String token, int id, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.DEL_FOLLOW;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", "" + user_id);
        params.addBodyParameter("id", "" + id);
        OkHttpRequest.post(params, call);
    }

    /**
     * 添加商品关注
     *
     * @param user_id
     * @param token
     * @param id
     * @param call
     */
    public void addCare(int user_id, String token, int id, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.ADD_FOLLOW;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", "" + user_id);
        params.addBodyParameter("id", "" + id);
        OkHttpRequest.post(params, call);
    }

    /**
     * 取消关注商品
     *
     * @param id
     * @param call
     */
    public static void delGoodsCare(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.DEL_FOLLOW;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 关注商品
     *
     * @param id
     * @param call
     */
    public static void addGoodsCare(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.ADD_FOLLOW;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 取消商家关注
     *
     * @param user_id
     * @param token
     * @param id
     * @param call
     */
    public void delSJCare(int user_id, String token, int id, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.DEL_SJ_FOLLOW;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", "" + user_id);
        params.addBodyParameter("id", "" + id);
        OkHttpRequest.post(params, call);
    }

    /**
     * 添加商家关注
     *
     * @param user_id
     * @param token
     * @param id
     * @param call
     */
    public void addSJCare(int user_id, String token, int id, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.ADD_SJ_FOLLOW;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", "" + user_id);
        params.addBodyParameter("id", "" + id);
        OkHttpRequest.post(params, call);
    }

    public static void delSJCare(String id, OnRequestSubscribe<BaseBean> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/23 16:54

         * @param id 商家id
         * @param call

         * @Description:取消关注商家

         *

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.DEL_SJ_FOLLOW;
        MapUtils body;
        if (SPUtil.get("token", SPUtil.Type.STR) == null && SPUtil.get("token", SPUtil.Type.STR).equals("")) {
            body = MapUtils.craete().putBody("id", id);
        } else {
            body = MapUtils.craete().putBody("id", id).putBody("token", (String) SPUtil.get("token", SPUtil.Type.STR)).putBody("userid", "" + (int) SPUtil.get("userid", SPUtil.Type.INT));
        }
        Api.post(url, body, new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    public static void addSJCare(String id, OnRequestSubscribe<BaseBean> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/23 16:54

         * @param id 商家id
         * @param call

         * @Description:关注商家

         *

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.ADD_SJ_FOLLOW;
        MapUtils body;
        if (SPUtil.get("token", SPUtil.Type.STR) == null && SPUtil.get("token", SPUtil.Type.STR).equals("")) {
            body = MapUtils.craete().putBody("id", id);
        } else {
            body = MapUtils.craete().putBody("id", id).putBody("token", (String) SPUtil.get("token", SPUtil.Type.STR)).putBody("userid", "" + (int) SPUtil.get("userid", SPUtil.Type.INT));
        }
        Api.post(url, body, new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }


    /**
     * 取消报价关注
     *
     * @param user_id
     * @param token
     * @param id
     * @param call
     */
    public void delBJCare(int user_id, String token, int id, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.DEL_BJ_FOLLOW;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", "" + user_id);
        params.addBodyParameter("id", "" + id);
        OkHttpRequest.post(params, call);
    }

    /**
     * 添加报价关注
     *
     * @param user_id
     * @param token
     * @param id
     * @param call
     */
    public void addBJCare(int user_id, String token, int id, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.ADD_BJ_FOLLOW;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", "" + user_id);
        params.addBodyParameter("id", "" + id);
        OkHttpRequest.post(params, call);
    }

    /**
     * 取消案例关注
     *
     * @param user_id
     * @param token
     * @param id
     * @param call
     */
    public void delALCare(int user_id, String token, int id, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.DEL_AL_FOLLOW;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", "" + user_id);
        params.addBodyParameter("id", "" + id);
        OkHttpRequest.post(params, call);
    }

    /**
     * 关注报价
     *
     * @param id
     * @param call
     */
    public static void addBJcare(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.ADD_BJ_FOLLOW;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 取消关注报价
     *
     * @param id
     * @param call
     */
    public static void delBJcare(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.DEL_BJ_FOLLOW;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 添加案例关注
     *
     * @param user_id
     * @param token
     * @param id
     * @param call
     */
    public void addALCare(int user_id, String token, int id, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.ADD_AL_FOLLOW;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", "" + user_id);
        params.addBodyParameter("id", "" + id);
        OkHttpRequest.post(params, call);
    }

    /**
     * 添加需求
     *
     * @param user_id
     * @param token
     * @param price
     * @param sheng
     * @param shi
     * @param qu
     * @param detais
     * @param title
     * @param open_msg
     * @param open_phone
     * @param type
     * @param call
     */
    public void addNeed(int user_id, String token, String price, String sheng, String shi, String qu, String detais, String title, int open_msg, int open_phone, int type, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NEED + Constans.Action.ADD_NEED;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", "" + user_id);
        params.addBodyParameter("cityid", "" + shi);
        params.addBodyParameter("countyid", "" + qu);
        params.addBodyParameter("provinceid", "" + sheng);
        params.addBodyParameter("details", "" + detais);
        params.addBodyParameter("openmessage", "" + open_msg);
        params.addBodyParameter("openphone", "" + open_phone);
        params.addBodyParameter("price", "" + price);
        params.addBodyParameter("title", "" + title);
        params.addBodyParameter("type", "" + type);
        params.addBodyParameter("address", "" + sheng + "-" + shi + "-" + qu);
        OkHttpRequest.post(params, call);
    }

    /**
     * 添加需求
     *
     * @param type      类型 	1 婚庆 2 商城
     * @param title     需求标题
     * @param price     意向价格
     * @param details   需求详情
     * @param province  省
     * @param city      市
     * @param county    区
     * @param openChart 是否公开即时通讯    1是 0不是
     * @param openPhone 是否公开电话        1是 0不是
     * @param callBack  回调
     */
    public static void addNeed(int type, String title, String price, String details, String province, String city, String county, boolean openChart, boolean openPhone, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NEED + Constans.Action.ADD_NEED;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("type", type);
        mapUtils.putBody("title", title);
        mapUtils.putBody("price", price);
        mapUtils.putBody("details", details);
        mapUtils.putBody("provinceid", province);
        mapUtils.putBody("cityid", city);
        mapUtils.putBody("countyid", county);
        mapUtils.putBody("address", String.format("%s-%s-%s", province, city, county));
        mapUtils.putBody("openmessage", openChart ? 1 : 0);
        mapUtils.putBody("openphone", openPhone ? 1 : 0);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }



    /**
     * 修改我的需求
     *
     * @param id
     * @param type
     * @param title
     * @param price
     * @param details
     * @param province
     * @param city
     * @param county
     * @param openChart
     * @param openPhone
     * @param callBack
     */
    public static void editNeed(int id, int type, String title, String price, String details, String province, String city, String county, boolean openChart, boolean openPhone, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NEED + Constans.Action.EDIT_NEED;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("id", id);
        mapUtils.putBody("type", type);
        mapUtils.putBody("title", title);
        mapUtils.putBody("price", price);
        mapUtils.putBody("details", details);
        mapUtils.putBody("provinceid", province);
        mapUtils.putBody("cityid", city);
        mapUtils.putBody("countyid", county);
        mapUtils.putBody("address", String.format("%s-%s-%s", province, city, county));
        mapUtils.putBody("openmessage", openChart ? 1 : 0);
        mapUtils.putBody("openphone", openPhone ? 1 : 0);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取我的邀请函列表
     *
     * @param token
     * @param user_id
     * @param page
     * @param call
     */
    public void getMineInvitation(String token, int user_id, int page, int rows, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.MINE_INVITATION;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", "" + user_id);
        params.addBodyParameter("p", "" + page);
        params.addBodyParameter("rows", "" + rows);
        OkHttpRequest.post(params, call);
    }

    /**
     * 获取预览地址
     *
     * @param token
     * @param user_id
     * @param call
     */
    public void getInvitationUrl(String token, int user_id, int id, int type, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.GET_INVITATION_URL;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", "" + user_id);
        params.addBodyParameter("id", "" + id);
        params.addBodyParameter("type", "" + type);
        OkHttpRequest.post(params, call);
    }

    /**
     * 获取婚庆交界面菜单
     *
     * @param rows
     * @param call
     */
    public void getHunQinMenu(int rows, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME + Constans.Action.GET_HUNQIN_MENU;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("p", "" + 1);
        params.addBodyParameter("rows", "" + rows);
        OkHttpRequest.post(params, call);
    }

    /**
     * 获取分类列表
     *
     * @param ceilingprice
     * @param city
     * @param college
     * @param comprehensive
     * @param countyid
     * @param floorprice
     * @param isvip
     * @param keyword
     * @param occupationid
     * @param page
     * @param platform
     * @param sincerity
     * @param team
     * @param call
     */
    public void getBusiness(String ceilingprice, String city, int college
            , int comprehensive, String countyid, String floorprice, int isvip
            , String keyword, int occupationid, int page, int platform, int sincerity, int team, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME + Constans.Action.GET_BUSINESS;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("ceilingprice", ceilingprice);
        params.addBodyParameter("cityid", "" + city);
        params.addBodyParameter("college", "" + college);
        params.addBodyParameter("comprehensive", "" + comprehensive);
        params.addBodyParameter("countyid", "" + countyid);
        params.addBodyParameter("floorprice", "" + floorprice);
        params.addBodyParameter("isshopvip", "" + isvip);
        params.addBodyParameter("keyword", "" + keyword);
        params.addBodyParameter("occupationid", "" + occupationid);
        params.addBodyParameter("p", "" + page);
        params.addBodyParameter("platform", "" + platform);
        params.addBodyParameter("rows", "" + 10);
        params.addBodyParameter("sincerity", "" + sincerity);
        params.addBodyParameter("team", "" + team);
        OkHttpRequest.post(params, call);
    }

    /**
     * 获取商城首页
     *
     * @param city_code
     * @param token
     * @param user_id
     * @param call
     */
    public void getHomtList(int city_code, String token, int user_id, Callback.CommonCallback<String> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME_SHOP + Constans.Action.INDEX;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", "" + user_id);
        params.addBodyParameter("cityid", "" + city_code);
        OkHttpRequest.post(params, call);
    }

    /**
     * 将输入流转换成字符串
     *
     * @param is 从网络获取的输入流
     * @return
     */
    public static String streamToString(InputStream is) {
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024];
            int len = 0;
            while ((len = is.read(buffer)) != -1) {
                baos.write(buffer, 0, len);
            }
            baos.close();
            is.close();
            byte[] byteArray = baos.toByteArray();
            return new String(byteArray);
        } catch (Exception e) {
            com.linzi.xiguwen.utils.LogUtil.e("HttpManager", e.toString());
            return null;
        }
    }

    public void getCase(int cityid, String p, String rows, String token, String type, String userid, Callback.CommonCallback<String> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/19 18:25

         * @param city
         * @param p
         * @param rows
         * @param token
         * @param type
         * @param userid
         * @param call
         * @Description:获取案例数据
         *
         */
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME_HOT + Constans.Action.GET_CASE;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("cityid", cityid + "");
        params.addBodyParameter("p", p + "");
        params.addBodyParameter("rows", rows + "");
        params.addBodyParameter("userid", userid + "");
        params.addBodyParameter("token", token + "");
        params.addBodyParameter("type", type + "");
        OkHttpRequest.post(params, call);
    }

    /**
     * 首页获取案例
     *
     * @param p
     * @param rows
     * @param type
     * @param call
     */
    public static void getCase(int cityid, int p, int rows, int type, OnRequestSubscribe<BaseBean<CaseListBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME_HOT + Constans.Action.GET_CASE;
        Api.post(url, MapUtils.createToken().putBody("cityid", cityid).putBody("p", p).putBody("rows", rows).putBody("type", type), new BaseCallBack<>(new TypeToken<BaseBean<CaseListBean>>() {
        }, call));
    }

    public void getCaseDetails(String id, String token, String userid, Callback.CommonCallback<String> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/21 16:20

         * @param id
         * @param token
         * @param userid
         * @param call

         * @Description:获取案例列表

         *

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.USER + Constans.Action.GET_CASS_DETAILS;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("id", id);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", userid);
        OkHttpRequest.post(params, call);
    }

    /**
     * 获取案例详情
     *
     * @param id   案例id
     * @param call
     */
    public static void getCaseDetails(String id, OnRequestSubscribe<BaseBean<NewCaseBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.USER + Constans.Action.GET_CASS_DETAILS;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<NewCaseBean>>() {
        }, call));
    }

    public void isCarUser(String id, String token, String userid, Callback.CommonCallback<String> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/21 16:25

         * @param id
         * @param token
         * @param userid
         * @param call

         * @Description:关注商家

         *

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.ADD_AL_FOLLOW;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("id", id);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", userid);
        OkHttpRequest.post(params, call);
    }

    public void cancelCarUser(String id, String token, String userid, Callback.CommonCallback<String> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/21 16:31

         * @param id
         * @param token
         * @param userid
         * @param call

         * @Description:取消关注

         *

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.DEL_AL_FOLLOW;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("id", id);
        params.addBodyParameter("token", token);
        params.addBodyParameter("userid", userid);
        OkHttpRequest.post(params, call);
    }

    public void getWhthin(String date, String occupationid, String p, String rows, String timeslot, Callback.CommonCallback<String> call) {
        /**

         * @Author: tinyyoung
         * @Date: 2018/3/21 19:04
         * @param date 时间格式2018-5-5
         * @param occupationid 	职业id
         * @param p
         * @param rows
         * @param timeslot 时间段，1上午2中午3下午4晚上5全天
         * @param call
         * @Description:
         * 获取查档列表
         *
         */
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.WHTHIN;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("date", date);
        params.addBodyParameter("occupationid", occupationid);
        params.addBodyParameter("p", p);
        params.addBodyParameter("rows", rows);
        params.addBodyParameter("timeslot", timeslot);
        OkHttpRequest.post(params, call);
    }

    public static void getWhthin(@Nullable String date, int cityid, String occupationid, String p, String rows, @Nullable String timeslot, OnRequestSubscribe<BaseBean<ArrayList<WhthinBean>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.WHTHIN;
        MapUtils mapUtils = MapUtils.create();
        if (date != null) {
            mapUtils.putBody("date", date);
        }
        if (date != null) {
            mapUtils.putBody("timeslot", timeslot);
        }
        Api.post(url, mapUtils.putBody("p", p).putBody("rows", rows).putBody("occupationid", occupationid).putBody("cityid", cityid), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<WhthinBean>>>() {
        }, call));
    }

    public void getClassificationlist(String p, String rows, Callback.CommonCallback<String> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/21 19:18

         * @param p
         * @param rows
         * @param call

         * @Description:

         *  获取职业列表

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME2 + Constans.Action.GET_HUNQIN_MENU;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("p", p);
        params.addBodyParameter("rows", rows);
        OkHttpRequest.post(params, call);
    }

    /**
     * 获取区县列表
     *
     * @param city 城市名字或者城市id
     * @param call 网络回调
     */
    public static void getCiteListe(String city, OnRequestSubscribe<BaseBean<ArrayList<GetCityBean>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.GET_CITY;
        MapUtils body = MapUtils.create().putBody("city", city);
        Api.post(url, body, new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<GetCityBean>>>() {
        }, call));
    }

    /**
     * 获取区县列表
     *
     * @param city 城市名字或者城市id
     * @param call 网络回调
     */
    public static void getCiteListeNew(String city, OnRequestSubscribe<BaseBean<ArrayList<CityEntity>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.GET_CITY;
        MapUtils body = MapUtils.create().putBody("city", city);
        Api.post(url, body, new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<CityEntity>>>() {
        }, call));
    }

    /**
     * 获取职业列表..
     *
     * @param call 网络回调
     */
    public static void getClassification(OnRequestSubscribe<BaseBean<ArrayList<ClassificationBean>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME + Constans.Action.CLASSIFICATION_LIST2;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<ClassificationBean>>>() {
        }, call));
    }
    /**
     * 获取职业列表..
     *
     * @param call 网络回调
     */
    public static void getClassification2(OnRequestSubscribe<BaseBean<ArrayList<ClassificationBean>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME + Constans.Action.CLASSIFICATION_LIST;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<ClassificationBean>>>() {
        }, call));
    }

    /**
     * 获取社团列表
     *
     * @param call 网络回调
     */
    public static void getAssociation(OnRequestSubscribe<BaseBean<ArrayList<ClassificationBean>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME_HOT + Constans.Action.ASSOCIATION;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<ClassificationBean>>>() {
        }, call));
    }

    /**
     * 获取社团列表
     *
     * @param call 网络回调
     */
    public static void getAssociation(@Nullable String cityid
            , @Nullable String comprehensive
            , @Nullable String moneymax
            , @Nullable String moneymin
            , @Nullable String p
            , @Nullable String rows
            , @Nullable String type, @Nullable String city
            , OnRequestSubscribe<BaseBean<AssociationBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME_HOT + Constans.Action.ASSOCIATION;
        MapUtils body = MapUtils.create();
        if (cityid != null) {
            body.putBody("cityid", cityid);
        }
        if (comprehensive != null) {
            body.putBody("comprehensive", comprehensive);
        }
        if (moneymax != null) {
            body.putBody("moneymax", moneymax);
        }
        if (moneymin != null) {
            body.putBody("moneymin", moneymin);
        }
        if (p != null) {
            body.putBody("p", p);
        }
        if (rows != null) {
            body.putBody("rows", rows);
        }
        if (type != null) {
            body.putBody("type", type);
        }
        if (city != null) {
            body.putBody("city", city);
        }
        Api.post(url, body, new BaseCallBack<>(new TypeToken<BaseBean<AssociationBean>>() {
        }, call));
    }

    /**
     * 社团详情接口
     *
     * @param id              社团id
     * @param p               页码
     * @param row             条数
     * @param onRequestFinish 请求回调
     */
    public static void getShetuanIndex(String id, String p, String row, OnRequestFinish<BaseBean<ShetuanIndexBean>> onRequestFinish) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHETUAN + Constans.Action.INDEX;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("p", p).putBody("row", row), new BaseCallBack<>(new TypeToken<BaseBean<ShetuanIndexBean>>() {
        }, onRequestFinish));
    }

    public void getHotSearchList(String token, String type, String userid, Callback.CommonCallback<String> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/22 12:03

         * @param token
         * @param type
         * @param userid
         * @param call

         * @Description:

         *获取热门搜索

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME2 + Constans.Action.GET_HUNQIN_MENU;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("token", token);
        params.addBodyParameter("type", type);
        params.addBodyParameter("userid", userid);
        OkHttpRequest.post(params, call);
    }

    public void getDetails(String id, Callback.CommonCallback<String> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/22 14:10

         * @param id
         * @param call

         * @Description:

         *获取案例明细

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.USER + Constans.Action.CASE_DETAILS;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("id", id);
        OkHttpRequest.post(params, call);
    }


    public void getCasePeopleNum(Callback.CommonCallback<String> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/22 14:10

         * @param call

         * @Description:

         *免费获取方案 获取人数

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME2 + Constans.Action.GET_PEOPLE_NUMBER;
        RequestParams params = new RequestParams(url);
        OkHttpRequest.post(params, call);
    }


    public void postUserCase(String cityid, String contenta, String countyid, String datepicker, String mobile, String price, String provinceid, Callback.CommonCallback<String> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/22 17:30

         * @param cityid
         * @param contenta
         * @param countyid
         * @param datepicker
         * @param mobile
         * @param price
         * @param provinceid
         * @param call

         * @Description:

         *      提交获取免费方案

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME2 + Constans.Action.POST_CASE;
        RequestParams params = new RequestParams(url);
        params.addBodyParameter("cityid", cityid);
        params.addBodyParameter("contenta", contenta);
        params.addBodyParameter("countyid", countyid);
        params.addBodyParameter("datepicker", datepicker);
        params.addBodyParameter("mobile", mobile);
        params.addBodyParameter("price", price);
        params.addBodyParameter("provinceid", provinceid);
        OkHttpRequest.post(params, call);
    }

    public static void getUserDetails(String id, OnRequestSubscribe<BaseBean<ShopUserDetailsBean>> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/23 16:43

         * @param id 商家ID
         * @param call

         * @Description:获取商家详情

         *

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.USER + Constans.Action.INDEX;
        MapUtils body;
        if (SPUtil.get("token", SPUtil.Type.STR) != null && !SPUtil.get("token", SPUtil.Type.STR).equals("")) {
            body = MapUtils.create().putBody("id", id).putBody("token", (String) SPUtil.get("token", SPUtil.Type.STR)).putBody("userid", "" + (int) SPUtil.get("userid", SPUtil.Type.INT));
        } else {
            body = MapUtils.create().putBody("id", id);
        }
        Api.post(url, body, new BaseCallBack<>(new TypeToken<BaseBean<ShopUserDetailsBean>>() {
        }, call));
    }

    public static void getMerchantdata(String userid, OnRequestSubscribe<BaseBean<UserMerchant>> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/24 15:38

         * @param userid    商家id
         * @param call

         * @Description:[商家详情]商家资料

         *

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.USER + Constans.Action.MERCHANTDATA;
        MapUtils body = MapUtils.create().putBody("userid", userid);
        Api.post(url, body, new BaseCallBack<>(new TypeToken<BaseBean<UserMerchant>>() {
        }, call));
    }

    public static void getSchedule(String id, OnRequestSubscribe<BaseBean<ArrayList<ScheduleBean>>> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/24 15:38

         * @param id    商家id
         * @param call

         * @Description:[商家详情]商家档期

         *

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.USER + Constans.Action.DANGQI;
        MapUtils body = MapUtils.create().putBody("id", id);
        Api.post(url, body, new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<ScheduleBean>>>() {
        }, call));
    }

    public static void getOffer(String id, String p, String rows, OnRequestSubscribe<BaseBean<ShopUserDetailsBean.BaojiaBeanX>> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/24 15:38

         * @param id    商家id
         * @param call

         * @Description:[商家详情]商家报价

         *

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.USER + Constans.Action.BAOJIALIST;
        MapUtils body = MapUtils.create().putBody("id", id).putBody("p", p).putBody("rows", rows);
        Api.post(url, body, new BaseCallBack<>(new TypeToken<BaseBean<ShopUserDetailsBean.BaojiaBeanX>>() {
        }, call));
    }

    public static void getCase(String id, String p, String rows, OnRequestSubscribe<BaseBean<ZuoPingBean>> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/24 15:38

         * @param id    商家id
         * @param call

         * @Description:[商家详情]商家作品

         *

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.USER + Constans.Action.ZUOPING;
        MapUtils body = MapUtils.create().putBody("id", id).putBody("p", p).putBody("rows", rows);
        Api.post(url, body, new BaseCallBack<>(new TypeToken<BaseBean<ZuoPingBean>>() {
        }, call));
    }

    public static void getCaseNew(String id, String p, String rows, OnRequestSubscribe<BaseBean<WorksBean>> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/24 15:38

         * @param id    商家id
         * @param call

         * @Description:[商家详情]商家作品

         *

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.USER + Constans.Action.ZUOPING;
        MapUtils body = MapUtils.create().putBody("id", id).putBody("p", p).putBody("rows", rows);
        Api.post(url, body, new BaseCallBack<>(new TypeToken<BaseBean<WorksBean>>() {
        }, call));
    }


    public static void getEvaluation(String id, String p, String rows, OnRequestSubscribe<BaseBean<EvaluateBean>> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/24 15:38

         * @param id    商家id
         * @param call

         * @Description:[商家详情]商家评价

         *

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.USER + Constans.Action.EVALUTE;
        MapUtils body = MapUtils.create().putBody("id", id).putBody("p", p).putBody("rows", rows);
        Api.post(url, body, new BaseCallBack<>(new TypeToken<BaseBean<EvaluateBean>>() {
        }, call));
    }

    public static void getDynamic(String id, String p, String rows, OnRequestSubscribe<BaseBean<DongTaiBean>> call) {
        /**

         * @Author: tinyyoung

         * @Date: 2018/3/24 15:38

         * @param id    商家id
         * @param call

         * @Description:[商家详情]商家动态

         *

         */
        String url = Constans.SERVER_HOST2 + Constans.Type.USER + Constans.Action.DONGTAI;
        MapUtils body = MapUtils.create().putBody("id", id).putBody("p", p).putBody("rows", rows);
        Api.post(url, body, new BaseCallBack<>(new TypeToken<BaseBean<DongTaiBean>>() {
        }, call));
    }

    /**
     * 获取店铺信息接口
     *
     * @param callBack 回调
     */
    public static void getStoreInformation(OnRequestSubscribe<BaseBean<StoreInformationBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.STOREINFORMATION;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<StoreInformationBean>>() {
        }, callBack));
    }

    /**
     * 修改店铺详情
     *
     * @param nickname   店铺名称
     * @param area
     * @param background
     * @param content
     * @param occupation
     * @param shopimg
     * @param shoptype
     * @param site
     * @param callBack
     */
    public static void changeStoreInformation(int onlinestatus, String nickname, String area, String background, String content, int occupation, String shopimg, int shoptype, String site, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.CHANGE_STORE_INFORMATION;
        MapUtilsX mapUtils = MapUtilsX.createToken();
        mapUtils.putBody("nickname", nickname);
        mapUtils.putBody("area", area);
        mapUtils.putBody("background", background);
        mapUtils.putBody("content", content);
        mapUtils.putBody("occupation", occupation);
        mapUtils.putBody("shopimg", shopimg);
        mapUtils.putBody("shoptype", shoptype);
        mapUtils.putBody("site", site);
        mapUtils.putBody("onlinestatus", onlinestatus);


        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 上传无水印文件
     *
     * @param file
     * @param callBack
     * @param <T>
     */
    public static <T extends BaseBean> void uploadImgNormal(File file, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.UPLOAD_FILE;
        RequestParams entity = new RequestParams(url);
        entity.addBodyParameter("img", file);
        OkHttpRequest.post(entity, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 上传视频
     *
     * @param <T>
     * @param file
     * @param callBack
     */
    public static <T extends BaseBean> Callback.Cancelable uploadVideo(File file, Callback.ProgressCallback<String> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.UPLOAD_VIDEO;
        RequestParams entity = new RequestParams(url);
        entity.addBodyParameter("file", file);
        entity.setMultipart(true);
        return OkHttpRequest.post(entity, callBack);
    }

    /**
     * 获取婚礼类型列表
     *
     * @param callBack
     */
    public static void getWeddingTypes(OnRequestSubscribe<BaseBean<List<WeddingTypsBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.GET_WEDDING_TYPE_LIST;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<List<WeddingTypsBean>>>() {
        }, callBack));
    }

    /**
     * 获取婚礼环境列表
     *
     * @param callBack
     */
    public static void getWeddingEnvironment(OnRequestSubscribe<BaseBean<List<WeddingEnvironmentBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.GET_WEDDING_ENVIRONMENT_LIST;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<List<WeddingEnvironmentBean>>>() {
        }, callBack));
    }

    /**
     * 获取婚礼类型列表
     *
     * @param callBack
     */
    public static void getWeddingTypes1(OnRequestSubscribe<BaseBean<List<CaseTypeEntity>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.GET_WEDDING_TYPE_LIST;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<List<CaseTypeEntity>>>() {
        }, callBack));
    }

    /**
     * 获取婚礼环境列表
     *
     * @param callBack
     */
    public static void getWeddingEnvironment1(OnRequestSubscribe<BaseBean<List<CaseTypeEntity>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.GET_WEDDING_ENVIRONMENT_LIST;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<List<CaseTypeEntity>>>() {
        }, callBack));
    }

    /**
     * 上传图片Base64数据
     *
     * @param imgBase64Code
     * @param callBack
     * @param <T>
     */
    public static <T extends BaseBean> void uploadImgBase64(String imgBase64Code, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.UPLOAD_IMG_NIU;
        RequestParams entity = new RequestParams(url);
        entity.setConnectTimeout(600000);
        entity.addBodyParameter("img", imgBase64Code);
        double random = Math.random();
        entity.addBodyParameter("random", random);
        entity.addBodyParameter("type", "1");
        NToast.log("request random ","url is "+url +" random is "+ random +"imgBase64Code len "+imgBase64Code.length());
        OkHttpRequest.post(entity, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }


    /**
     * 获取认证信息
     *
     * @param callBack
     */
    public static void getRenZhengInfo(OnRequestSubscribe<BaseBean<RenZhengListBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.AUTHENTICATION + Constans.Action.SHOP_MYAUTH;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<RenZhengListBean>>() {
        }, callBack));

    }

    /**
     * 查看认证资料
     *
     * @param id       认证id
     * @param callBack
     */
    public static void getRenZhengSubmitInfo(int id, OnRequestSubscribe<BaseBean<RenZhengSubmitInfoBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.AUTHENTICATION + Constans.Action.GET_RENZHENG_SUBMIT_INFO;
        Api.post(url, MapUtilsX.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<RenZhengSubmitInfoBean>>() {
        }, callBack));
    }

    /**
     * 提交认证资料
     *
     * @param id       认证id
     * @param photo    图片，多张用“，”分隔
     * @param video    视频链接
     * @param callBack
     */
    public static void submitRenZhengInfo(int id, String photo, String video, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.AUTHENTICATION + Constans.Action.SUBMIT_RENZHENG_INFO;
        Api.post(url, MapUtilsX.createToken().putBody("id", id).putBody("photo", photo).putBody("video", video), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 重新提交认证资料
     *
     * @param did      资料表id
     * @param id       认证id
     * @param photo    图片，多张用“，”分隔
     * @param video    视频链接
     * @param callBack
     */
    public static void reSubmitRenZhengInfo(int did, int id, String photo, String video, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.AUTHENTICATION + Constans.Action.RESUBMIT_RENZHENG_INFO;
        Api.post(url, MapUtilsX.createToken().putBody("did", did).putBody("id", id).putBody("photo", photo).putBody("video", video), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

//    /**
//     * 获取认证列表
//     *
//     * @param callBack
//     */
//    public static void getRenZhengList(OnRequestSubscribe<BaseBean<ArrayList<RenZhengBean>>> callBack) {
//        String url = Constans.SERVER_HOST2 + Constans.Type.AUTHENTICATION + Constans.Action.RENZHENG_LIST;
//        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<RenZhengBean>>>() {
//        }, callBack));
//    }

    /**
     * 提交认证订单
     *
     * @param money    认证价格
     * @param reamk    备注
     * @param type     认证类型
     * @param callBack
     */
    public static void submitRenZheng(String money, String reamk, int type, OnRequestSubscribe<BaseBean<RenZhengOrderBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.AUTHENTICATION + Constans.Action.SUBMIT_RENZHENG;
        Api.post(url, MapUtils.createToken().putBody("money", money).putBody("reamk", reamk).putBody("type", type + ""), new BaseCallBack<BaseBean<RenZhengOrderBean>>(new TypeToken<BaseBean<RenZhengOrderBean>>() {
        }, callBack));
    }

    /**
     * 退保证金操作
     *
     * @param id
     * @param callBack
     */
    public static void refundRenZheng(int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.AUTHENTICATION + Constans.Action.REFUND_RENZHENG;
        Api.post(url, MapUtilsX.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取档期里列表
     *
     * @param page     页数
     * @param rows     记录条数
     * @param callBack
     */
    public static void getGradeList(int page, int rows, OnRequestSubscribe<BaseBean<List<MyGradeBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.GET_GRADE_LIST;
        Api.post(url, MapUtilsX.createToken().putBody("p", page).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<List<MyGradeBean>>>() {
        }, callBack));
    }

    /**
     * 设置接单数量
     *
     * @param setnumber 接单数量
     * @param sjdate    日期  如：2019-02-08
     * @param callBack
     */
    public static void setTakingOrderNum(int setnumber, String sjdate, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.SET_TAKING_ORDER_NUM;
        Api.post(url, MapUtilsX.createToken().putBody("setnumber", setnumber).putBody("sjdate", sjdate), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取接单数量
     *
     * @param date     时间戳
     * @param callBack
     */
    public static Callback.Cancelable getTakingOrderNum(long date, OnRequestSubscribe<BaseBean<TakingOrderNumBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.GET_TAKING_ORDER_NUM;
        return Api.post(url, MapUtilsX.createToken().putBody("date", date), new BaseCallBack<>(new TypeToken<BaseBean<TakingOrderNumBean>>() {
        }, callBack));
    }

    /**
     * 添加档期
     *
     * @param contactnumber 联系电话
     * @param contacts      联系人
     * @param date          档期日期
     * @param remarks       备注
     * @param timeslot      时间段，1上午2中午3下午4晚上5全天6不接单
     * @param tixing        提醒的json字符串
     * @param callBack
     */
    public static void addGrade(String contactnumber, String contacts, String date, String remarks, int timeslot, String tixing, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.ADD_GRADE;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        mapUtilsX.putBody("contactnumber", contactnumber);
        mapUtilsX.putBody("contacts", contacts);
        mapUtilsX.putBody("date", date);
        mapUtilsX.putBody("remarks", remarks);
        mapUtilsX.putBody("timeslot", timeslot);
        mapUtilsX.putBody("tixing", tixing);
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 删除档期
     *
     * @param id       档期id
     * @param callBack
     */
    public static void delGrade(int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.DEL_GRADE;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        mapUtilsX.putBody("id", id);
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 修改档期
     *
     * @param id            档期id, 其他参数见添加档期
     * @param contactnumber
     * @param contacts
     * @param date
     * @param remarks
     * @param timeslot
     * @param tixing
     * @param callBack
     */
    public static void editGrade(int id, String contactnumber, String contacts, String date, String remarks, int timeslot, String tixing, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.EDIT_GRADE;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        mapUtilsX.putBody("id", id);
        mapUtilsX.putBody("contactnumber", contactnumber);
        mapUtilsX.putBody("contacts", contacts);
        mapUtilsX.putBody("date", date);
        mapUtilsX.putBody("remarks", remarks);
        mapUtilsX.putBody("timeslot", timeslot);
        mapUtilsX.putBody("tixing", tixing);
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 生成档期卡
     */
    public static void createGradeCard(int type, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.CREATE_GRADE_CARD;
        Api.post(url, MapUtilsX.create().putBody("id", SPUtil.get("userid", SPUtil.Type.INT)).putBody("type", type), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取报价列表
     *
     * @param callBack
     */
    public static void getMyBaoJia(int p, int rows, int state, OnRequestSubscribe<BaseBean<ArrayList<BaoJiaBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.BAOJIA + Constans.Action.GET_BAOJIA_LIST;
        Api.post(url, MapUtils.createToken().putBody("p", p + "").putBody("rows", rows + "").putBody("state", state + ""), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<BaoJiaBean>>>() {
        }, callBack));
    }

    /**
     * 添加报价
     *  @param couponsPrice 抵扣金额
     * @param price        价格
     * @param shopname     商品名称
     * @param temporarypay 定金金额
     * @param weigh        权重
     * @param shopimg      图片数组
     * @param ps
     */
    public static void addBaoJia(float couponsPrice, float price, String shopname, float temporarypay, float weigh, List<String> shopimg, String ps, OnRequestSubscribe<BaseBean<String>> callBack) {
        String img = "";
        if (shopimg != null) {
            for (String path : shopimg) {
                if (TextUtils.isEmpty(img)) {
                    img = path;
                } else {
                    img = img + "," + path;
                }
            }
        }
        String url = Constans.SERVER_HOST2 + Constans.Type.BAOJIA + Constans.Action.ADD_BAOJIA;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        mapUtilsX.putBody("coupons_price", couponsPrice);
        mapUtilsX.putBody("price", price);
        mapUtilsX.putBody("shopimg", img);
        mapUtilsX.putBody("shopname", shopname);
        mapUtilsX.putBody("temporarypay", temporarypay);
        mapUtilsX.putBody("weigh", weigh);
        if (!TextUtils.isEmpty(ps)){
            mapUtilsX.putBody("miaoshu", ps);
        }
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 编辑报价
     *
     * @param id           报价id   其他参考添加报价
     * @param couponsPrice
     * @param price
     * @param shopname
     * @param temporarypay
     * @param weigh
     * @param shopimg
     * @param callBack
     */
    public static void editBaoJia(int id, float couponsPrice, float price, String shopname, float temporarypay, float weigh, List<String> shopimg, OnRequestSubscribe<BaseBean<String>> callBack) {
        String img = "";
        if (shopimg != null) {
            for (String path : shopimg) {
                if (TextUtils.isEmpty(img)) {
                    img = path;
                } else {
                    img = img + "," + path;
                }
            }
        }
        String url = Constans.SERVER_HOST2 + Constans.Type.BAOJIA + Constans.Action.EDIT_BAOJIA;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        mapUtilsX.putBody("quotationid", id);
        mapUtilsX.putBody("coupons_price", couponsPrice);
        mapUtilsX.putBody("price", price);
        mapUtilsX.putBody("shopimg", img);
        mapUtilsX.putBody("shopname", shopname);
        mapUtilsX.putBody("temporarypay", temporarypay);
        mapUtilsX.putBody("weigh", weigh);
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));

    }

    /**
     * 获取报价详情
     *
     * @param quotationid 报价id
     * @param callBack
     */
    public static void getBaoJiaDetail(int quotationid, OnRequestSubscribe<BaseBean<BaoJiaDetailBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.BAOJIA + Constans.Action.GET_BAOJIA_DETAIL;
        Api.post(url, MapUtilsX.createToken().putBody("quotationid", quotationid), new BaseCallBack<>(new TypeToken<BaseBean<BaoJiaDetailBean>>() {
        }, callBack));
    }

    /**
     * 获取所有地区
     *
     * @param callBack
     */
    public static void getProvinces(OnRequestSubscribe<BaseBean<List<ProvinceBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.GET_PROVINCES;
        Api.post(url, MapUtilsX.create(), new BaseCallBack<>(new TypeToken<BaseBean<List<ProvinceBean>>>() {
        }, callBack));
    }

    /**
     * 获取图册列表
     *
     * @param p        页
     * @param rows     记录条数
     * @param status   状态
     * @param callBack
     */
    public static void getAtlasList(int p, int rows, int status, OnRequestSubscribe<BaseBean<List<AtlasBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ATLAS + Constans.Action.GET_ATLAS;
        Api.post(url, MapUtilsX.createToken().putBody("p", p).putBody("rows", rows).putBody("status", status), new BaseCallBack<>(new TypeToken<BaseBean<List<AtlasBean>>>() {
        }, callBack));
    }

    /**
     * 获取图册详情
     *
     * @param id
     * @param callBack
     */
    public static void getAtlasDetail(int id, OnRequestSubscribe<BaseBean<AtlasDetailBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ATLAS + Constans.Action.GET_ATLAS_DETAIL;
        Api.post(url, MapUtilsX.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<AtlasDetailBean>>() {
        }, callBack));
    }

    /**
     * 获取动态详情 - 已登录
     */
    public static void getSynamicdetails(int id, OnRequestFinish<BaseBean<SynamicdetailsBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOUND + Constans.Action.DYNAMICDETAILS;
        Api.post(url, MapUtilsX.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<SynamicdetailsBean>>() {
        }, callBack));
    }

    /**
     * 获取动态详情 - 未登录
     */
    public static void getSynamicdetailsNotLogin(int id, OnRequestFinish<BaseBean<SynamicdetailsBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOUND + Constans.Action.DYNAMICDETAILS;
        Api.post(url, MapUtilsX.create().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<SynamicdetailsBean>>() {
        }, callBack));
    }


    /**
     * 发布动态评论
     */
    public static void synamicPublishComment(int id, int pid, String comm, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOUND + Constans.Action.DYNAMIC_COMMENT;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        mapUtilsX.putBody("id", id);
        if (pid != -1) {
            mapUtilsX.putBody("pid", pid);
        }
        mapUtilsX.putBody("comm", comm);
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));


    }


    /**
     * 婚庆圈
     *
     * @param follow
     * @param hot
     * @param newest
     * @param p
     * @param rows
     * @param type
     * @param callBack
     */
    public static void getHunQingQuan(@Nullable String follow, @Nullable String hot, @Nullable String newest, String p, String rows, @Nullable String type, OnRequestSubscribe<BaseBean<ArrayList<WeddingRingBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOUND + Constans.Action.HUNQINGQUAN;
        MapUtils mapUtils = MapUtils.createToken();
        if (follow != null) {
            mapUtils.putBody("follow", follow + "");
        }
        if (hot != null) {
            mapUtils.putBody("hot", hot + "");
        }
        if (newest != null) {
            mapUtils.putBody("newest", newest + "");
        }
        if (type != null) {
            mapUtils.putBody("type", type + "");
        }
        Api.post(url, mapUtils.putBody("p", p + "").putBody("rows", rows + ""), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<WeddingRingBean>>>() {
        }, callBack));
    }

    /**
     * 商城圈
     *
     * @param follow
     * @param hot
     * @param newest
     * @param p
     * @param rows
     * @param callBack
     */
    public static void getShopQuan(@Nullable String follow, @Nullable String hot, @Nullable String newest, String p, String rows, OnRequestSubscribe<BaseBean<ArrayList<WeddingRingBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOUND + Constans.Action.SHOPQUAN;
        MapUtils mapUtils = MapUtils.createToken();
        if (follow != null) {
            mapUtils.putBody("follow", follow + "");
        }
        if (hot != null) {
            mapUtils.putBody("hot", hot + "");
        }
        if (newest != null) {
            mapUtils.putBody("newest", newest + "");
        }
        Api.post(url, mapUtils.putBody("p", p + "").putBody("rows", rows + ""), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<WeddingRingBean>>>() {
        }, callBack));
    }

    /**
     * 获取社团成员列表
     */
    public static void getMemberList(int id, OnRequestFinish<BaseBean<MemberBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHETUAN + Constans.Action.MEMBER;
        Api.post(url, MapUtilsX.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<MemberBean>>() {
        }, callBack));
    }

    /**
     * 添加图册
     *
     * @param cover    图册封面地址
     * @param name     图册名称
     * @param photo    图册图片地址
     * @param synopsis 图册简介
     * @param weight   权重
     * @param callBack
     */
    public static void addAtlas(String cover, String name, List<String> photo, String synopsis, String weight, OnRequestSubscribe<BaseBean<String>> callBack) {
        String img = "";
        if (photo != null) {
            for (String path : photo) {
                if (TextUtils.isEmpty(img)) {
                    img = path;
                } else {
                    img = img + "," + path;
                }
            }
        }
        String url = Constans.SERVER_HOST2 + Constans.Type.ATLAS + Constans.Action.ADD_ATLAS;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        mapUtilsX.putBody("cover", cover);
        mapUtilsX.putBody("name", name);
        mapUtilsX.putBody("photo", img);
        mapUtilsX.putBody("synopsis", synopsis);
        mapUtilsX.putBody("weight", weight);
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 编辑图册
     *
     * @param id       图册id
     * @param cover    图册封面地址
     * @param name     图册名称
     * @param photo    图册图片地址
     * @param synopsis 图册简介
     * @param weight   权重
     * @param callBack
     */
    public static void editAtlas(int id, String cover, String name, List<String> photo, String synopsis, String weight, OnRequestSubscribe<BaseBean<String>> callBack) {
        String img = "";
        if (photo != null) {
            for (String path : photo) {
                if (TextUtils.isEmpty(img)) {
                    img = path;
                } else {
                    img = img + "," + path;
                }
            }
        }
        String url = Constans.SERVER_HOST2 + Constans.Type.ATLAS + Constans.Action.EDIT_ATLAS;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        mapUtilsX.putBody("id", id);
        mapUtilsX.putBody("cover", cover);
        mapUtilsX.putBody("name", name);
        mapUtilsX.putBody("photo", img);
        mapUtilsX.putBody("synopsis", synopsis);
        mapUtilsX.putBody("weight", weight);
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取视频列表
     *
     * @param status
     * @param callBack
     */
    public static void getVideoList(int p, int rows, int status, OnRequestSubscribe<BaseBean<List<VideoBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.VIDEO + Constans.Action.GET_VIDEO_LIST;
        Api.post(url, MapUtilsX.createToken().putBody("p", p).putBody("rows", rows).putBody("status", status), new BaseCallBack<>(new TypeToken<BaseBean<List<VideoBean>>>() {
        }, callBack));
    }

    /**
     * 获取单个视频详情
     *
     * @param id       视频id
     * @param callBack
     */
    public static void getVideoDetail(int id, OnRequestSubscribe<BaseBean<VideoBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.VIDEO + Constans.Action.GET_VIDEO_DETAIL;
        Api.post(url, MapUtilsX.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<VideoBean>>() {
        }, callBack));
    }

    /**
     * 添加视频
     *
     * @param cover     视频封面
     * @param title     视频标题
     * @param video_url 视频url
     * @param weigh     视频排序
     * @param callBack
     */
    public static void addVideo(String cover, String title, String video_url, int weigh, OnRequestFinish<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.VIDEO + Constans.Action.ADD_VIDEO;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("cover", cover);
        mapUtils.putBody("title", title);
        mapUtils.putBody("video_url", video_url);
        mapUtils.putBody("weigh", weigh);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 编辑视频
     *
     * @param id
     * @param cover
     * @param title
     * @param video_url
     * @param weigh
     * @param callBack
     */
    public static void editVideo(int id, String cover, String title, String video_url, int weigh, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.VIDEO + Constans.Action.EDIT_VIDEO;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("id", id);
        mapUtils.putBody("cover", cover);
        mapUtils.putBody("title", title);
        mapUtils.putBody("video_url", video_url);
        mapUtils.putBody("weigh", weigh);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取我的案例列表
     *
     * @param p
     * @param rows
     * @param status
     * @param callBack
     */
    public static void getMyExampleList(int p, int rows, int status, OnRequestSubscribe<BaseBean<List<MyExampleBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.CASES + Constans.Action.GET_MY_EXAMPLE_LIST;
        Api.post(url, MapUtilsX.createToken().putBody("p", p).putBody("rows", rows).putBody("status", status), new BaseCallBack<>(new TypeToken<BaseBean<List<MyExampleBean>>>() {
        }, callBack));
    }

    /**
     * 获取我的案例详情
     *
     * @param id       案例id
     * @param callBack
     */
    public static void getMyExampleDetail(int id, OnRequestSubscribe<BaseBean<MyExampleDetailBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.CASES + Constans.Action.GET_MY_EXAMPLE_DETAIL;
        Api.post(url, MapUtilsX.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<MyExampleDetailBean>>() {
        }, callBack));
    }

    /**
     * 添加案例
     *
     * @param title                案例名称
     * @param photourl             婚礼图片
     * @param weddingcover         封面图片地址
     * @param weddingdescribe      婚礼描述
     * @param weddingenvironmentid 婚礼环境表id
     * @param weddingexpenses      婚礼费用
     * @param weddingplace         婚礼地点
     * @param weddingtime          婚礼时间  格式  ：2018-08-01
     * @param weddingtypeid        婚礼类型表id
     * @param weigh                权重
     */
    public static void addMyExample(String title, List<String> photourl, String weddingcover, String weddingdescribe, int weddingenvironmentid,
                                    String weddingexpenses, String weddingplace, String weddingtime, int weddingtypeid, String weigh,
                                    OnRequestSubscribe<BaseBean<String>> callBack) {
        String img = "";
        if (photourl != null) {
            for (String path : photourl) {
                if (TextUtils.isEmpty(img)) {
                    img = path;
                } else {
                    img = img + "," + path;
                }
            }
        }
        String url = Constans.SERVER_HOST2 + Constans.Type.CASES + Constans.Action.ADD_MY_EXAMPLE;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        mapUtilsX.putBody("title", title);
        mapUtilsX.putBody("photourl", img);
        mapUtilsX.putBody("weddingcover", weddingcover);
        mapUtilsX.putBody("weddingdescribe", weddingdescribe);
        mapUtilsX.putBody("weddingenvironmentid", weddingenvironmentid);
        mapUtilsX.putBody("weddingexpenses", weddingexpenses);
        mapUtilsX.putBody("weddingplace", weddingplace);
        mapUtilsX.putBody("weddingtime", weddingtime);
        mapUtilsX.putBody("weddingtypeid", weddingtypeid);
        mapUtilsX.putBody("weigh", weigh);
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 编辑我的案例
     *
     * @param title
     * @param photourl
     * @param weddingcover
     * @param weddingdescribe
     * @param weddingenvironmentid
     * @param weddingexpenses
     * @param weddingplace
     * @param weddingtime
     * @param weddingtypeid
     * @param weigh
     * @param callBack
     */
    public static void editMyExample(int id, String title, List<String> photourl, String weddingcover, String weddingdescribe, int weddingenvironmentid,
                                     String weddingexpenses, String weddingplace, String weddingtime, int weddingtypeid, String weigh,
                                     OnRequestSubscribe<BaseBean<String>> callBack) {
        String img = "";
        if (photourl != null) {
            for (String path : photourl) {
                if (TextUtils.isEmpty(img)) {
                    img = path;
                } else {
                    img = img + "," + path;
                }
            }
        }
        String url = Constans.SERVER_HOST2 + Constans.Type.CASES + Constans.Action.EDIT_MY_EXAMPLE;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        mapUtilsX.putBody("id", id);
        mapUtilsX.putBody("title", title);
        mapUtilsX.putBody("photourl", img);
        mapUtilsX.putBody("weddingcover", weddingcover);
        mapUtilsX.putBody("weddingdescribe", weddingdescribe);
        mapUtilsX.putBody("weddingenvironmentid", weddingenvironmentid);
        mapUtilsX.putBody("weddingexpenses", weddingexpenses);
        mapUtilsX.putBody("weddingplace", weddingplace);
        mapUtilsX.putBody("weddingtime", weddingtime);
        mapUtilsX.putBody("weddingtypeid", weddingtypeid);
        mapUtilsX.putBody("weigh", weigh);
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }


    /**
     * 获取商品详情
     *
     * @param shopid
     * @param callBack
     */
    public static void getMyCommodity(int shopid, OnRequestSubscribe<BaseBean<CommodityBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHOPS + Constans.Action.GET_MY_COMMODITY_DETAIL;
        Api.post(url, MapUtils.createToken().putBody("shopid", shopid), new BaseCallBack<>(new TypeToken<BaseBean<CommodityBean>>() {
        }, callBack));
    }

    /**
     * 添加我的商品
     *
     * @param pcolumnid     商品类目
     * @param columnid      商品子类
     * @param shopname      商品名称
     * @param price         商品价格
     * @param company       商品单位
     * @param coupons_price 现金抵扣券
     * @param weigh         商品排序
     * @param expressid     运费模板id
     * @param site          商品地区   省-市-区
     * @param sku1          属性设置1
     * @param sku2          属性设置2
     * @param shopimg       商品图片
     * @param callBack
     */
    public static void addMyCommodity(int pcolumnid, int columnid, String shopname, String price, String company, String coupons_price, String weigh, int expressid, String site,
                                      String sku1, String sku2, String sku /*List<CommodityInventoryBean> inventory/*List<String> sku1name, List<String> sku2name, List<String> prices, List<String> number*/, List<String> shopimg,
                                      OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHOPS + Constans.Action.ADD_MY_COMMODITY;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        mapUtilsX.putBody("pcolumnid", pcolumnid);
        mapUtilsX.putBody("columnid", columnid);
        mapUtilsX.putBody("shopname", shopname);
        mapUtilsX.putBody("price", price);
        mapUtilsX.putBody("company", company);
        mapUtilsX.putBody("coupons_price", coupons_price);
        mapUtilsX.putBody("weigh", weigh);
        mapUtilsX.putBody("expressid", expressid);
        mapUtilsX.putBody("site", site);
        mapUtilsX.putBody("sku1", sku1);
        mapUtilsX.putBody("sku2", sku2);
//        StringBuffer sku1name = new StringBuffer();
//        StringBuffer sku2name = new StringBuffer();
//        StringBuffer prices = new StringBuffer();
//        StringBuffer number = new StringBuffer();
//        for (CommodityInventoryBean bean : inventory) {
//            if (sku1name.length() == 0) {
//                sku1name.append(bean.getProperty1());
//            } else {
//                sku1name.append("," + bean.getProperty1());
//            }
//
//            if (sku2name.length() == 0) {
//                sku2name.append(bean.getProperty2());
//            } else {
//                sku2name.append("," + bean.getProperty2());
//            }
//
//            if (prices.length() == 0) {
//                prices.append(bean.getPrice());
//            } else {
//                prices.append("," + bean.getPrice());
//            }
//
//            if (number.length() == 0) {
//                number.append(bean.getNum());
//            } else {
//                number.append("," + bean.getNum());
//            }
//        }
//        mapUtilsX.putBody("sku1name", sku1name.toString());
//        mapUtilsX.putBody("sku2name", sku2name.toString());
//        mapUtilsX.putBody("prices", prices.toString());
//        mapUtilsX.putBody("number", number.toString());

        mapUtilsX.putBody("sku", sku);
        StringBuffer imgs = new StringBuffer();
        for (String img : shopimg) {
            if (imgs.length() == 0) {
                imgs.append(img);
            } else {
                imgs.append("," + img);
            }
        }
        mapUtilsX.putBody("shopimg", imgs.toString());
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 修改我的商品
     *
     * @param pcolumnid     商品类目
     * @param columnid      商品子类
     * @param shopname      商品名称
     * @param price         商品价格
     * @param company       商品单位
     * @param coupons_price 现金抵扣券
     * @param weigh         商品排序
     * @param expressid     运费模板id
     * @param site          商品地区   省-市-区
     * @param sku1          属性设置1
     * @param sku2          属性设置2
     * @param shopimg       商品图片
     * @param callBack
     */
    public static void editMyCommodity(int shopid, int pcolumnid, int columnid, String shopname, String price, String company, String coupons_price, String weigh, int expressid, String site,
                                       String sku1, String sku2, String sku /*List<CommodityInventoryBean> inventory/*List<String> sku1name, List<String> sku2name, List<String> prices, List<String> number*/, List<String> shopimg,
                                       OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHOPS + Constans.Action.EDIT_MY_COMMODITY;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        mapUtilsX.putBody("shopid", shopid);
        mapUtilsX.putBody("pcolumnid", pcolumnid);
        mapUtilsX.putBody("columnid", columnid);
        mapUtilsX.putBody("shopname", shopname);
        mapUtilsX.putBody("price", price);
        mapUtilsX.putBody("company", company);
        mapUtilsX.putBody("coupons_price", coupons_price);
        mapUtilsX.putBody("weigh", weigh);
        mapUtilsX.putBody("expressid", expressid);
        mapUtilsX.putBody("site", site);
        mapUtilsX.putBody("sku1", sku1);
        mapUtilsX.putBody("sku2", sku2);
        //        StringBuffer sku1name = new StringBuffer();
//        StringBuffer sku2name = new StringBuffer();
//        StringBuffer prices = new StringBuffer();
//        StringBuffer number = new StringBuffer();
//        for (CommodityInventoryBean bean : inventory) {
//            if (sku1name.length() == 0) {
//                sku1name.append(bean.getProperty1());
//            } else {
//                sku1name.append("," + bean.getProperty1());
//            }
//
//            if (sku2name.length() == 0) {
//                sku2name.append(bean.getProperty2());
//            } else {
//                sku2name.append("," + bean.getProperty2());
//            }
//
//            if (prices.length() == 0) {
//                prices.append(bean.getPrice());
//            } else {
//                prices.append("," + bean.getPrice());
//            }
//
//            if (number.length() == 0) {
//                number.append(bean.getNum());
//            } else {
//                number.append("," + bean.getNum());
//            }
//        }
//        mapUtilsX.putBody("sku1name", sku1name.toString());
//        mapUtilsX.putBody("sku2name", sku2name.toString());
//        mapUtilsX.putBody("prices", prices.toString());
//        mapUtilsX.putBody("number", number.toString());

        mapUtilsX.putBody("sku", sku);

        StringBuffer imgs = new StringBuffer();
        for (String img : shopimg) {
            if (imgs.length() == 0) {
                imgs.append(img);
            } else {
                imgs.append("," + img);
            }
        }
        mapUtilsX.putBody("shopimg", imgs);
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取我的商品父级类目
     */
    public static void getMineCommodityTypeParent(OnRequestSubscribe<BaseBean<List<MineCommodityType>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHOPS + Constans.Action.GET_MY_COMMODITY_TYPE_PARENT;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<List<MineCommodityType>>>() {
        }, callBack));
    }

    /**
     * 获取我的商品子级类目
     */
    public static void getMineCommodityTypeChild(int pid, OnRequestSubscribe<BaseBean<List<MineCommodityType>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHOPS + Constans.Action.GET_MY_COMMODITY_TYPE_CHILD;
        Api.post(url, MapUtils.create().putBody("pid", pid), new BaseCallBack<>(new TypeToken<BaseBean<List<MineCommodityType>>>() {
        }, callBack));
    }

    /**
     * 获取运费模板
     *
     * @param callBack
     */
    public static void getMineCommodityFreightTemplate(OnRequestSubscribe<BaseBean<List<FreightTemplateBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHOPS + Constans.Action.GET_MY_COMMODITY_FREIGHT_TEMPLATE;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<List<FreightTemplateBean>>>() {
        }, callBack));
    }

    /**
     * 获取我的XX列表
     *
     * @param p
     * @param rows
     * @param status
     * @param callBack
     */
    public static void getMyList(int pageType, int p, int rows, int status, OnRequestSubscribe<BaseBean<List<BaseStatusBean>>> callBack) {
        String url = null;
        BaseCallBack baseCallBack = null;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        mapUtilsX.putBody("p", p);
        mapUtilsX.putBody("rows", rows);
        switch (pageType) {
            case MineListActivity.TYPE_BAOJIA:
                url = Constans.SERVER_HOST2 + Constans.Type.BAOJIA + Constans.Action.GET_BAOJIA_LIST;
                baseCallBack = new BaseCallBack(new TypeToken<BaseBean<List<BaoJiaBean>>>() {
                }, callBack);
                mapUtilsX.putBody("state", status);
                break;
            case MineListActivity.TYPE_TUCE:
                url = Constans.SERVER_HOST2 + Constans.Type.ATLAS + Constans.Action.GET_ATLAS;
                baseCallBack = new BaseCallBack(new TypeToken<BaseBean<List<AtlasBean>>>() {
                }, callBack);
                mapUtilsX.putBody("status", status);
                break;
            case MineListActivity.TYPE_SHIPING:
                url = Constans.SERVER_HOST2 + Constans.Type.VIDEO + Constans.Action.GET_VIDEO_LIST;
                baseCallBack = new BaseCallBack(new TypeToken<BaseBean<List<VideoBean>>>() {
                }, callBack);
                mapUtilsX.putBody("status", status);
                break;
            case MineListActivity.TYPE_ANLI:
                url = Constans.SERVER_HOST2 + Constans.Type.CASES + Constans.Action.GET_MY_EXAMPLE_LIST;
                baseCallBack = new BaseCallBack(new TypeToken<BaseBean<List<MyExampleBean>>>() {
                }, callBack);
                mapUtilsX.putBody("status", status);
                break;
            case MineListActivity.TYPE_COMMODITY:
                url = Constans.SERVER_HOST2 + Constans.Type.SHOPS + Constans.Action.GET_MY_COMMODITY_LIST;
                baseCallBack = new BaseCallBack(new TypeToken<BaseBean<List<CommodityBean>>>() {
                }, callBack);
                mapUtilsX.putBody("status", status);
                break;
        }
        Api.post(url, mapUtilsX, baseCallBack);
    }

    /**
     * 删除我的XX
     *
     * @param pageType
     * @param id
     * @param callBack
     */
    public static void mineDel(int pageType, int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = null;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        switch (pageType) {
            case MineListActivity.TYPE_BAOJIA:
                url = Constans.SERVER_HOST2 + Constans.Type.BAOJIA + Constans.Action.DEL_BAOJIA;
                mapUtilsX.putBody("quotationid", id);
                break;
            case MineListActivity.TYPE_TUCE:
                url = Constans.SERVER_HOST2 + Constans.Type.ATLAS + Constans.Action.DEL_ATLAS;
                mapUtilsX.putBody("id", id);
                break;
            case MineListActivity.TYPE_SHIPING:
                url = Constans.SERVER_HOST2 + Constans.Type.VIDEO + Constans.Action.DEL_VIDEO;
                mapUtilsX.putBody("id", id);
                break;
            case MineListActivity.TYPE_ANLI:
                url = Constans.SERVER_HOST2 + Constans.Type.CASES + Constans.Action.DEL_MY_EXAMPLE;
                mapUtilsX.putBody("id", id);
                break;
            case MineListActivity.TYPE_COMMODITY:
                url = Constans.SERVER_HOST2 + Constans.Type.SHOPS + Constans.Action.DEL_MY_COMMODITY;
                mapUtilsX.putBody("shopid", id);
                break;
        }
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取审核失败原因
     *
     * @param pageType
     * @param id
     * @param callBack
     */
    public static void mineGetFailedReason(int pageType, int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = null;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        switch (pageType) {
            case MineListActivity.TYPE_BAOJIA:
                url = Constans.SERVER_HOST2 + Constans.Type.BAOJIA + Constans.Action.GET_BAOJIA_REASON;
                mapUtilsX.putBody("quotationid", id);
                break;
            case MineListActivity.TYPE_TUCE:
                url = Constans.SERVER_HOST2 + Constans.Type.ATLAS + Constans.Action.GET_ATLAS_REASON;
                mapUtilsX.putBody("id", id);
                break;
            case MineListActivity.TYPE_SHIPING:
                url = Constans.SERVER_HOST2 + Constans.Type.VIDEO + Constans.Action.GET_VIDEO_REASON;
                mapUtilsX.putBody("id", id);
                break;
            case MineListActivity.TYPE_ANLI:
                url = Constans.SERVER_HOST2 + Constans.Type.CASES + Constans.Action.GET_EXAMPLE_REASON;
                mapUtilsX.putBody("id", id);
                break;
            case MineListActivity.TYPE_COMMODITY:
                url = Constans.SERVER_HOST2 + Constans.Type.SHOPS + Constans.Action.GET_MY_COMMODITY_REASON;
                mapUtilsX.putBody("shopid", id);
                break;
        }
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 上下架
     *
     * @param pageType
     * @param id
     * @param status   1上架  0下架
     * @param callBack
     */
    public static void minePutOnOffShelves(int pageType, int id, int status, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = null;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        switch (pageType) {
            case MineListActivity.TYPE_BAOJIA:
                url = Constans.SERVER_HOST2 + Constans.Type.BAOJIA + Constans.Action.SET_BAOJIA_STATUS;
                mapUtilsX.putBody("quotationid", id);
                mapUtilsX.putBody("status", status);
                break;
            case MineListActivity.TYPE_TUCE:
                url = Constans.SERVER_HOST2 + Constans.Type.ATLAS + Constans.Action.SET_ATLAS_STATUS;
                mapUtilsX.putBody("id", id);
                mapUtilsX.putBody("status", status);
                break;
            case MineListActivity.TYPE_SHIPING:
                url = Constans.SERVER_HOST2 + Constans.Type.VIDEO + Constans.Action.SET_VIDEO_STATUS;
                mapUtilsX.putBody("id", id);
                mapUtilsX.putBody("status", status);
                break;
            case MineListActivity.TYPE_ANLI:
                url = Constans.SERVER_HOST2 + Constans.Type.CASES + Constans.Action.SET_CASES_STATUS;
                mapUtilsX.putBody("id", id);
                mapUtilsX.putBody("status", status);
                break;
            case MineListActivity.TYPE_COMMODITY:
                url = Constans.SERVER_HOST2 + Constans.Type.SHOPS + Constans.Action.SET_MY_COMMODITY_STATUS;
                mapUtilsX.putBody("shopid", id);
                mapUtilsX.putBody("status", status);
                break;
        }
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 提交审核
     *
     * @param pageType
     * @param id
     * @param callBack
     */
    public static void mineSubmit(int pageType, int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = null;
        MapUtilsX mapUtilsX = MapUtilsX.createToken();
        switch (pageType) {
            case MineListActivity.TYPE_BAOJIA:
                url = Constans.SERVER_HOST2 + Constans.Type.BAOJIA + Constans.Action.SUBMIT_BAOJIA;
                mapUtilsX.putBody("quotationid", id);
                break;
            case MineListActivity.TYPE_TUCE:
                url = Constans.SERVER_HOST2 + Constans.Type.ATLAS + Constans.Action.SUBMIT_ATLAS;
                mapUtilsX.putBody("id", id);
                break;
            case MineListActivity.TYPE_SHIPING:
                url = Constans.SERVER_HOST2 + Constans.Type.VIDEO + Constans.Action.SUBMIT_VIDEO;
                mapUtilsX.putBody("id", id);
                break;
            case MineListActivity.TYPE_ANLI:
                url = Constans.SERVER_HOST2 + Constans.Type.CASES + Constans.Action.SUBMIT_EXAMPLE;
                mapUtilsX.putBody("id", id);
                break;
            case MineListActivity.TYPE_COMMODITY:
                break;
        }
        Api.post(url, mapUtilsX, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取我的服务城市列表
     */
    public static void getMyServiceCityList(int p, int rows, OnRequestSubscribe<BaseBean<List<ServiceCity>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.GET_MY_SERVICE_CITY_LIST;
        Api.post(url, MapUtilsX.createToken().putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<List<ServiceCity>>>() {
        }, callBack));
    }

    /**
     * 删除服务城市
     *
     * @param id       服务城市条目id
     * @param callBack
     */
    public static void delMyServiceCity(int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.DEL_MY_SERVICE_CITY;
        Api.post(url, MapUtilsX.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 添加服务城市
     *
     * @param province 省份名称
     * @param city     城市名称
     * @param callBack
     */
    public static void addMyServiceCity(String province, String city, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.ADD_MY_SERVICE_CITY;
        Api.post(url, MapUtilsX.createToken().putBody("province", province).putBody("city", city), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取推荐团队列表
     *
     * @param callBack
     */
    public static void getRecommendedTeamList(OnRequestSubscribe<BaseBean<List<RecommendedTeam>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.GET_RECOMMENDED_TEAM_LIST;
        Api.post(url, MapUtilsX.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<List<RecommendedTeam>>>() {
        }, callBack));
    }

    /**
     * 删除推荐团队
     *
     * @param id       推荐团队id
     * @param callBack
     */
    public static void delRecommendedTeam(int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.DEL_RECOMMENDED_TEAM_LIST;
        Api.post(url, MapUtilsX.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 添加推荐团队
     *
     * @param shopcode 店铺编码
     * @param weight   权重
     * @param callBack
     */
    public static void addRecommendedTeam(String shopcode, String weight, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.ADD_RECOMMENDED_TEAM;
        Api.post(url, MapUtils.createToken().putBody("shopcode", shopcode).putBody("weight", weight), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取推广助手剩余数量
     */
    public static void getPopularizeRemainNum(OnRequestSubscribe<PopularizeRemainBean> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.GET_POPULARIZE_REMAIN_NUM;
        Api.post(url, MapUtils.createToken(), new BaseCallBack(new TypeToken<PopularizeRemainBean>() {
        }, callBack));
    }

    /**
     * 抢推广
     */
    public static void robPopularize(OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.ROB_POPULARIZE;
        Api.post(url, MapUtils.createToken(), new BaseCallBack(new TypeToken<PopularizeRemainBean>() {
        }, callBack));
    }

    /**
     * 抢推广
     */
    public static void robPopularizePay(String type, @Nullable String pwd, OnRequestSubscribe<BaseBean<PayBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.ROB_POPULARIZE_PAY;
        MapUtils mapUtils = MapUtils.createToken();
        if (pwd != null && !pwd.equals("")) {
            mapUtils.putBody("pwd", pwd);
        }
        Api.post(url, mapUtils.putBody("type", type), new BaseCallBack<>(new TypeToken<BaseBean<PayBean>>() {
        }, callBack));
    }


    /**
     * 获取作品列表
     *
     * @param callBack
     */
    public static void getWorkList(int id, OnRequestFinish<BaseBean<WorkBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHETUAN + Constans.Action.ZUOPIN;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<WorkBean>>() {
        }, callBack));
    }

    /**
     * 获取联系人列表
     *
     * @param callBack
     */
    public static void getContactList(int id, OnRequestFinish<BaseBean<ContactBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHETUAN + Constans.Action.CONTACT;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<ContactBean>>() {
        }, callBack));
    }

    /**
     * 动态点赞
     *
     * @param id   动态id
     * @param call
     */
    public static void giveALike(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOUND + Constans.Action.LIKE;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 动态取消点赞
     *
     * @param id   动态id
     * @param call
     */
    public static void disGiveALike(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOUND + Constans.Action.DISLIKE;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }


    /**
     * 发布动态
     *
     * @param content
     * @param path
     * @param callBack
     */
    public static void dynamicPublish(String content, List<File> path, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOUND + Constans.Action.PUBLISH_DYNAMICS;
        List<KeyValue> list = new ArrayList<KeyValue>();
        if (!AppUtil.isEmpty(path)) {
            for (int i = 0; i < path.size(); i++) {
                list.add(new KeyValue("photourl[]", path.get(i)));
            }
        }
        list.add(new KeyValue("userid", SPUtil.get("userid", SPUtil.Type.INT) + ""));
        list.add(new KeyValue("token", SPUtil.get("token", SPUtil.Type.STR).toString()));
        list.add(new KeyValue("content", content));
        RequestParams params = new RequestParams(url);
        MultipartBody body = new MultipartBody(list, "UTF-8");
        params.setRequestBody(body);
        params.setMultipart(true);

        OkHttpRequest.post(params, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));

    }


    public static void getOfferDetailsBean(int id, OnRequestSubscribe<BaseBean<OffoerDetailsBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.USER + Constans.Action.OFFOER;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<OffoerDetailsBean>>() {
        }, call));
    }

    /**
     * 获取发言稿列表
     *
     * @param p
     * @param rows
     * @param callBack
     */
    public static void getFaYanGaoList(int p, int rows, OnRequestSubscribe<BaseBean<List<FaYanGaoBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.GET_FAYANGAO_LIST;
        Api.post(url, MapUtils.createToken().putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<List<FaYanGaoBean>>>() {
        }, callBack));
    }

    /**
     * 删除发言稿
     *
     * @param id
     * @param callBack
     */
    public static void delFaYanGao(int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.DEL_FAYANGAO;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 添加发言稿
     *
     * @param title    标题
     * @param content  内容
     * @param callBack
     */
    public static void addFaYanGao(String title, String content, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.ADD_FAYANGAO;
        Api.post(url, MapUtils.createToken().putBody("title", title).putBody("content", content), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 修改发言稿
     *
     * @param id       发言稿id， 其它见addFaYanGao
     * @param title
     * @param content
     * @param callBack
     */
    public static void editFaYanGao(int id, String title, String content, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.EDIT_FAYANGAO;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("title", title).putBody("content", content), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 首页热门
     *
     * @param ceilingprice  最高价
     * @param college       是否学院认证1是 2不是
     * @param comprehensive 综合
     * @param countyid      区域id查询
     * @param floorprice    最低价
     * @param isshopvip     是否会员商家1是2否
     * @param p             页码
     * @param platform      是否平台认证1是 2不是
     * @param rows          单页数量
     * @param sincerity     是否诚信认证1是 2不是
     * @param team          商家类型，1个人，2团队
     * @param type          全部（职业类型）
     * @param types         1今日推荐2本周人气3本月人气4本周热门5本月热门
     * @param callBack
     */
    public static void getIndexHot(@Nullable int ceilingprice, @Nullable int college, @Nullable int comprehensive, @Nullable int cityid, @Nullable int countyid, @Nullable int floorprice, @Nullable int isshopvip, int p, @Nullable int platform, int rows, @Nullable int sincerity, @Nullable int team, @Nullable int type, @Nullable int types, OnRequestSubscribe<BaseBean<HotBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME_HOT + Constans.Action.GET_INDEX_HOT;
        MapUtils mapUtils = MapUtils.create();
        if (ceilingprice != -1) {
            mapUtils.putBody("ceilingprice", ceilingprice);
        }
        if (college != -1) {
            mapUtils.putBody("college", college);
        }
        if (comprehensive != -1) {
            mapUtils.putBody("comprehensive", comprehensive);
        }
        if (cityid != -1) {
            mapUtils.putBody("cityid", cityid);
        }
        if (countyid != -1) {
            mapUtils.putBody("countyid", countyid);
        }
        if (floorprice != -1) {
            mapUtils.putBody("floorprice", floorprice);
        }
        if (isshopvip != -1) {
            mapUtils.putBody("isshopvip", isshopvip);
        }
        if (platform != -1) {
            mapUtils.putBody("platform", platform);
        }
        if (sincerity != -1) {
            mapUtils.putBody("sincerity", sincerity);
        }
        if (team != -1) {
            mapUtils.putBody("team", team);
        }
        if (type != -1) {
            mapUtils.putBody("type", type);
        }
        if (types != -1) {
            mapUtils.putBody("types", types);
        }
        Api.post(url, mapUtils.putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<HotBean>>() {
        }, callBack));
    }

    /**
     * 首页商城
     *
     * @param cityid
     * @param call
     */
    public static void getIndexShop(int cityid, OnRequestSubscribe<BaseBean<ShopIndexBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME_SHOP + Constans.Action.GET_INDEX_SHOP;
        Api.post(url, MapUtils.createToken().putBody("cityid", cityid), new BaseCallBack<>(new TypeToken<BaseBean<ShopIndexBean>>() {
        }, call));
    }

    /**
     * 首页商城分类
     *
     * @param call
     */
    public static void getIndexShopType(OnRequestSubscribe<BaseBean<ArrayList<IndexShopTypeBean>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME_SHOP + Constans.Action.GET_INDEX_SHOP_FENLEI;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<IndexShopTypeBean>>>() {
        }, call));
    }

    /**
     * 新增婚礼流程
     *
     * @param p
     * @param rows
     * @param callBack
     */
    public static void getWeddingFlowList(int p, int rows, OnRequestSubscribe<BaseBean<List<WeddingFlowBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.GET_WEDDING_FLOW_LIST;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("p", p);
        mapUtils.putBody("rows", rows);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<List<WeddingFlowBean>>>() {
        }, callBack));
    }

    /**
     * 新增婚礼流程
     *
     * @param title    标题
     * @param renyuan  人员
     * @param shijian  时间  eg:15:22
     * @param shixiang 事项
     * @param callBack
     */
    public static void addWeddingFlow(String title, String renyuan, String shijian, String shixiang, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.ADD_WEDDING_FLOW;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("title", title);
        mapUtils.putBody("renyuan", renyuan);
        mapUtils.putBody("shijian", shijian);
        mapUtils.putBody("shixiang", shixiang);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 修改婚礼路程
     *
     * @param id       婚礼流程id
     * @param title
     * @param renyuan
     * @param shijian
     * @param shixiang
     * @param callBack
     */
    public static void editWeddingFlow(int id, String title, String renyuan, String shijian, String shixiang, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.EDIT_WEDDING_FLOW;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("id", id);
        mapUtils.putBody("title", title);
        mapUtils.putBody("renyuan", renyuan);
        mapUtils.putBody("shijian", shijian);
        mapUtils.putBody("shixiang", shixiang);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 删除婚礼流程
     *
     * @param id       婚礼流程id
     * @param callBack
     */
    public static void delWeddingFlowList(int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.DEL_WEDDING_FLOW;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("id", id);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 添加记账
     *
     * @param aftermoney 金额
     * @param occurrence 发生日期	时间戳 如果2018-01-05日的时间戳
     * @param remarks    备注
     * @param type       1支出  2收入
     * @param callBack
     */
    public static void addBill(String aftermoney, long occurrence, String remarks, int type, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.ADD_BILL;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("aftermoney", aftermoney);
        mapUtils.putBody("occurrence", occurrence);
        mapUtils.putBody("remarks", remarks);
        mapUtils.putBody("type", type);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 修改记账
     *
     * @param id
     * @param aftermoney 金额
     * @param occurrence 时间
     * @param remarks    备注
     * @param type       类型
     * @param callBack
     */
    public static void editBill(int id, String aftermoney, long occurrence, String remarks, int type, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.EDIT_BILL;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("id", id);
        mapUtils.putBody("aftermoney", aftermoney);
        mapUtils.putBody("occurrence", occurrence);
        mapUtils.putBody("remarks", remarks);
        mapUtils.putBody("type", type);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 删除记账
     *
     * @param id
     * @param callBack
     */
    public static void delBill(int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.DEL_BILL;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("id", id);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取记账列表
     *
     * @param p
     * @param rows
     * @param shijian
     * @param callBack
     */
    public static void getBillList(int p, int rows, long shijian, OnRequestSubscribe<BaseBean<BillDataBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.GET_BILL_LIST;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("p", p);
        mapUtils.putBody("rows", rows);
        mapUtils.putBody("shijian", shijian);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<BillDataBean>>() {
        }, callBack));
    }

    /**
     * 获取婚庆首页全部分类菜单
     *
     * @param call
     */
    public static void getMenuType(OnRequestSubscribe<BaseBean<ArrayList<MenuTypeBean>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME2 + Constans.Action.GET_WEDDING_TYPE_MENU;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<MenuTypeBean>>>() {
        }, call));
    }

    /**
     * 获取商城首页全部分类菜单
     *
     * @param call
     */
    public static void getShopMenuType(OnRequestSubscribe<BaseBean<ArrayList<MenuTypeBean>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME_SHOP + Constans.Action.GET_MALL_TYPE_MENU;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<MenuTypeBean>>>() {
        }, call));
    }

    /**
     * 首页婚庆分类--点进去的列表
     *
     * @param ceilingprice  最高价
     * @param cityid        当前城市
     * @param college       是否学院认证1是 2不是
     * @param comprehensive 综合排序 值1
     * @param countyid      区域id查询
     * @param floorprice    最低价
     * @param isshopvip     是否会员商家1是2否
     * @param keyword       关键字
     * @param occupationid  全部（职业id）
     * @param p             默认第一页1
     * @param platform      是否平台认证1是 2不是
     * @param rows          默认10条
     * @param sincerity     是否诚信认证1是 2不是
     * @param call          商家类型，1个人，2团队
     */
    public static void getWeddingType(@Nullable String ceilingprice, @Nullable String cityid, @Nullable int college, @Nullable String comprehensive, @Nullable String countyid, @Nullable String floorprice, @Nullable int isshopvip, @Nullable String keyword, @Nullable String occupationid, String p, @Nullable int platform, String rows, @Nullable int sincerity, OnRequestSubscribe<BaseBean<WeddingTypeListBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME2 + Constans.Action.GET_BUSINESS;
        MapUtils mapUtils = MapUtils.create();
        if (ceilingprice != null && !ceilingprice.equals("")) {
            mapUtils.putBody("ceilingprice", ceilingprice);
        }
        if (cityid != null && !cityid.equals("")) {
            mapUtils.putBody("cityid", cityid);
        }
        if (college != -1) {
            mapUtils.putBody("college", college);
        }
        if (comprehensive != null && !comprehensive.equals("")) {
            mapUtils.putBody("comprehensive", comprehensive);
        }
        if (countyid != null && !countyid.equals("")) {
            mapUtils.putBody("isshopvip", isshopvip);
        }
        if (floorprice != null && !floorprice.equals("")) {
            mapUtils.putBody("floorprice", floorprice);
        }
        if (keyword != null && !keyword.equals("")) {
            mapUtils.putBody("keyword", keyword);
        }
        if (occupationid != null && !occupationid.equals("")) {
            mapUtils.putBody("occupationid", occupationid);
        }
        if (platform != -1) {
            mapUtils.putBody("platform", platform);
        }
        if (sincerity != -1) {
            mapUtils.putBody("sincerity", sincerity);
        }

        Api.post(url, mapUtils.putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<WeddingTypeListBean>>() {
        }, call));
        NToast.log("APPTAG", "ceilingprice:" + ceilingprice
                + "\ncityid:" + cityid
                + "\ncollege:" + college
                + "\ncomprehensive:" + comprehensive
                + "\ncountyid:" + countyid
                + "\nfloorprice:" + floorprice
                + "\nisshopvip:" + isshopvip
                + "\nkeyword:" + keyword
                + "\noccupationid:" + occupationid
                + "\nsincerity:" + sincerity
                + "\nplatform:" + platform
                + "\np:" + p
                + "\nrows:" + rows
        );
    }

    /**
     * 优惠列表
     *
     * @param p
     * @param rows
     * @param callBack
     */
    public static void messagePrefrential(String p, String rows, OnRequestSubscribe<BaseBean<MessagePrefrentialBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MESSAGE + Constans.Action.MESSAGE_PREFERENTIAL;
        MapUtils mapUtils = MapUtils.create();
        mapUtils.putBody("p", p);
        mapUtils.putBody("rows", rows);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<MessagePrefrentialBean>>() {
        }, callBack));
    }

    /**
     * 交易消息
     *
     * @param p
     * @param rows
     * @param callBack
     */
    public static void messageTrade(String p, String rows, OnRequestSubscribe<BaseBean<MessageTradeBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MESSAGE + Constans.Action.MESSAGE_TRADE;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("p", p);
        mapUtils.putBody("rows", rows);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<MessageTradeBean>>() {
        }, callBack));
    }

    /**
     * 通知消息
     *
     * @param p
     * @param rows
     * @param callBack
     */
    public static void messageNotice(String p, String rows, OnRequestSubscribe<BaseBean<MessageNoticeBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MESSAGE + Constans.Action.MESSAGE_MOTICE;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("p", p);
        mapUtils.putBody("rows", rows);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<MessageNoticeBean>>() {
        }, callBack));
    }

    /**
     * 获取广告二级数据
     *
     * @param id
     * @param call
     */
    public static void getAdSecData(int cityid, int id, OnRequestSubscribe<BaseBean<ArrayList<SpecialRecommendBean>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM2 + Constans.Action.GET_AD_SEC;
        Api.post(url, MapUtils.create().putBody("id", id).putBody("cityid", cityid), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<SpecialRecommendBean>>>() {
        }, call));
    }

    /**
     * 获取广告二级数据
     *
     * @param id
     * @param call
     */
    public static void getAdSecData(int id, OnRequestSubscribe<BaseBean<ArrayList<SpecialRecommendBean>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM2 + Constans.Action.GET_AD_SEC;
        Api.post(url, MapUtils.create().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<SpecialRecommendBean>>>() {
        }, call));
    }


    /**
     * 新增日程安排
     *
     * @param conn     日程内容
     * @param riqi     日期          eg:2018-06-09
     * @param statime  开始时间      eg:12:33
     * @param endtime  结束日时间    eg:16:53
     * @param callBack
     */
    public static void addSchedule(String conn, String riqi, String statime, String endtime, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.ADD_SCHEDULE;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("conn", conn);
        mapUtils.putBody("riqi", riqi);
        mapUtils.putBody("statime", statime);
        mapUtils.putBody("endtime", endtime);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 修改日程安排
     *
     * @param id       日程安排id， 其他见新增日程
     * @param conn
     * @param riqi
     * @param statime
     * @param endtime
     * @param callBack
     */
    public static void editSchedule(int id, String conn, String riqi, String statime, String endtime, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.EDIT_SCHEDULE;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("id", id);
        mapUtils.putBody("conn", conn);
        mapUtils.putBody("riqi", riqi);
        mapUtils.putBody("statime", statime);
        mapUtils.putBody("endtime", endtime);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 改变日程状态
     *
     * @param id
     * @param status   1完成 2取消完成
     * @param callBack
     */
    public static void richengUpdatae(int id, int status, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.EDIT_TYPE;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("id", id);
        mapUtils.putBody("status", status);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 删除日程
     *
     * @param id
     * @param callBack
     */
    public static void delSchedule(int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.DEL_SCHEDULE;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取日程安排列表
     *
     * @param riqi     日期 格式如： 2018-09-06
     * @param callBack
     */
    public static void getScheduleList(String riqi, OnRequestSubscribe<BaseBean<List<MyScheduleBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.GET_SCHEDULE_LIST;
        Api.post(url, MapUtils.createToken().putBody("riqi", riqi), new BaseCallBack<>(new TypeToken<BaseBean<List<MyScheduleBean>>>() {
        }, callBack));
    }

    //日程小红点
    public static void getScheduleLDot(String times, OnRequestSubscribe<BaseBean<List<String>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.GET_SCHEDULE_DOT;
        Api.post(url, MapUtils.createToken().putBody("times", times), new BaseCallBack<>(new TypeToken<BaseBean<List<String>>>() {
        }, callBack));
    }

    /**
     * 获取我的首页信息
     *
     * @param call
     */
    public static void getUserInfo(OnRequestSubscribe<BaseBean<UserInfoBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.INDEX;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<UserInfoBean>>() {
        }, call));
    }

    /**
     * 获取商品详情
     *
     * @param id   商品id
     * @param call
     */
    public static void getGoodsDetails(int id, OnRequestSubscribe<BaseBean<NewGoodsDetailsBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.USER + Constans.Action.GET_GOODS_DETAILS;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<NewGoodsDetailsBean>>() {
        }, call));
    }

    /**
     * 获取商城商家详情-新品
     *
     * @param id
     * @param p
     * @param rows
     * @param salesvolume   销量排序
     * @param price         价格排序
     * @param comprehensive 综合排序
     * @param call
     */
    public static void getMallShopDetails(int id, int p, int rows, @Nullable int salesvolume, @Nullable String price, @Nullable int comprehensive, OnRequestSubscribe<BaseBean<ShopMallDetailsBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHOPPINGMALL + Constans.Action.GET_INDEX_HOT;
        MapUtils mapUtils = MapUtils.createToken();
        if (salesvolume != -1) {
            mapUtils.putBody("salesvolume", salesvolume);
        }
        if (price != null && !price.equals("")) {
            mapUtils.putBody("price", price);
        }
        if (comprehensive != -1) {
            mapUtils.putBody("comprehensive", comprehensive);
        }
        Api.post(url, mapUtils.putBody("id", id).putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<ShopMallDetailsBean>>() {
        }, call));
    }

    /**
     * 获取商城商家详情-热门
     *
     * @param id
     * @param p
     * @param rows
     * @param salesvolume   销量排序
     * @param price         价格排序
     * @param comprehensive 综合排序
     * @param call
     */
    public static void getAllGoods(int id, int p, int rows, @Nullable int salesvolume, @Nullable String price, @Nullable int comprehensive, OnRequestSubscribe<BaseBean<ShopMallDetailsBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHOPPINGMALL + Constans.Action.GET_HOT_GOODS;
        MapUtils mapUtils = MapUtils.createToken();
        if (salesvolume != -1) {
            mapUtils.putBody("salesvolume", salesvolume);
        }
        if (price != null && !price.equals("")) {
            mapUtils.putBody("price", price);
        }
        if (comprehensive != -1) {
            mapUtils.putBody("comprehensive", comprehensive);
        }
        Api.post(url, mapUtils.putBody("id", id).putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<ShopMallDetailsBean>>() {
        }, call));
    }

    /**
     * 获取商城商家详情-全部
     *
     * @param id
     * @param p
     * @param rows
     * @param salesvolume   销量排序
     * @param price         价格排序
     * @param comprehensive 综合排序
     * @param call
     */
    public static void getHotGoods(int id, int p, int rows, @Nullable int salesvolume, @Nullable String price, @Nullable int comprehensive, OnRequestSubscribe<BaseBean<ShopMallDetailsBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHOPPINGMALL + Constans.Action.GET_ALL_GOODS;
        MapUtils mapUtils = MapUtils.createToken();
        if (salesvolume != -1) {
            mapUtils.putBody("salesvolume", salesvolume);
        }
        if (price != null && !price.equals("")) {
            mapUtils.putBody("price", price);
        }
        if (comprehensive != -1) {
            mapUtils.putBody("comprehensive", comprehensive);
        }
        Api.post(url, mapUtils.putBody("id", id).putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<ShopMallDetailsBean>>() {
        }, call));
    }

    /**
     * 获取商城商家-动态
     *
     * @param id
     * @param p
     * @param rows
     * @param call
     */
    public static void getShopMallDongTai(int id, int p, int rows, OnRequestSubscribe<BaseBean<com.linzi.xiguwen.fragment.shopmall.bean.DongTaiBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHOPPINGMALL + Constans.Action.GET_SHOP_MALL_DONGTAI;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<com.linzi.xiguwen.fragment.shopmall.bean.DongTaiBean>>() {
        }, call));
    }

    /**
     * 获取商城商家-评论
     *
     * @param id
     * @param p
     * @param rows
     * @param call
     */
    public static void getShopMallPingLun(int id, int p, int rows, OnRequestSubscribe<BaseBean<com.linzi.xiguwen.fragment.shopmall.bean.PingJiaBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHOPPINGMALL + Constans.Action.GET_SHOP_MALL_PINGJIA;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<com.linzi.xiguwen.fragment.shopmall.bean.PingJiaBean>>() {
        }, call));
    }


    /**
     * 获取宾客祝福列表
     *
     * @param p
     * @param rows
     * @param callBack
     */
    public static void getBinKeZhuFu(int id, int p, int rows, OnRequestFinish<BaseBean<ZhuFuBean>> callBack) {
        // 1为祝福
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.GET_BINGKE_ZHUFU;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("id", id);
        mapUtils.putBody("p", p);
        mapUtils.putBody("rows", rows);
        mapUtils.putBody("type", 1);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<ZhuFuBean>>() {
        }, callBack));
    }

    /**
     * 获取是否赴宴列表
     *
     * @param p
     * @param rows
     * @param callBack
     */
    public static void getBinKeFuYan(int id, int p, int rows, OnRequestFinish<BaseBean<FuYanBean>> callBack) {
        // 2为赴宴
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.GET_BINGKE_ZHUFU;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("id", id);
        mapUtils.putBody("p", p);
        mapUtils.putBody("rows", rows);
        mapUtils.putBody("type", 2);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<FuYanBean>>() {
        }, callBack));
    }

    /**
     * 获取待定列表
     *
     * @param p
     * @param rows
     * @param callBack
     */
    public static void getBinKeDaiDing(int id, int p, int rows, OnRequestFinish<BaseBean<FuYanBean>> callBack) {
        // 3为待定
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.GET_BINGKE_ZHUFU;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("id", id);
        mapUtils.putBody("p", p);
        mapUtils.putBody("rows", rows);
        mapUtils.putBody("type", 3);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<FuYanBean>>() {
        }, callBack));
    }

    /**
     * 获取请柬模板类型列表
     *
     * @param callBack
     */
    public static void getInvitationsTemplateTypeList(OnRequestSubscribe<BaseBean<List<InvitationsTemplateTypeBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.GET_INVITATIONS_TEMPLATE_TYPE_LIST;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<List<InvitationsTemplateTypeBean>>>() {
        }, callBack));
    }

    /**
     * 获取请柬模板列表
     *
     * @param leibieid 类别id
     * @param p        页
     * @param rows     记录条数
     * @param callBack
     */
    public static void getInvitationsTemplateList(int leibieid, int p, int rows, OnRequestSubscribe<BaseBean<InvitationsTemplateBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.GET_INVITATIONS_TEMPLATE_LIST;
        Api.post(url, MapUtils.createToken().putBody("leibieid", leibieid).putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<InvitationsTemplateBean>>() {
        }, callBack));
    }

    /**
     * 获取制作请柬预览url
     *
     * @param id
     * @param callBack
     */
    public static void getMakeInvitationsShow(int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.GET_MAKE_INVITATIONS_TEMPLATE_URL;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 设置制作请柬信息
     *
     * @param templateId 模板id
     * @param xinlang    新郎名称
     * @param xinniang   新娘名称
     * @param hunlitime  婚礼时间
     * @param hotel      酒店
     * @param hunlidizhi 婚礼地址
     * @param callBack
     */
    public static void submitMakeInvitationInfo(int templateId, String xinlang, String xinniang, int hunlitime, String hotel, String hunlidizhi, Callback.CommonCallback<String> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.SET_MAKE_INVITATIONS_INFOS;
        RequestParams requestParams = new RequestParams(url);
        requestParams.addBodyParameter("id", templateId + "");
        requestParams.addBodyParameter("xinlang", xinlang);
        requestParams.addBodyParameter("xinniang", xinniang);
        requestParams.addBodyParameter("hunlitime", hunlitime + "");
        requestParams.addBodyParameter("hotel", hotel);
        requestParams.addBodyParameter("hunlidizhi", hunlidizhi);
        requestParams.addBodyParameter("token", SPUtil.get("token", SPUtil.Type.STR).toString());
        requestParams.addBodyParameter("userid", SPUtil.get("userid", SPUtil.Type.INT) + "");
        OkHttpRequest.post(requestParams, callBack);
    }


    /**
     * 修改请柬信息
     *
     * @param id         请柬id
     * @param xinlang    新郎
     * @param xinniang   新娘
     * @param hunlitime  婚礼时间
     * @param hotel      酒店
     * @param hunlidizhi 婚礼地址
     * @param callBack
     */
    public static void editInvitationInfo(int id, String xinlang, String xinniang, int hunlitime, String hotel, String hunlidizhi, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.SET_MAKE_INVITATIONS_INFOS2;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("id", id);
        mapUtils.putBody("xinlang", xinlang);
        mapUtils.putBody("xinniang", xinniang);
        mapUtils.putBody("hunlitime", hunlitime + "");
        mapUtils.putBody("hotel", hotel);
        mapUtils.putBody("hunlidizhi", hunlidizhi);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取商城购物车
     *
     * @param call
     */
    public static void getMallCart(OnRequestSubscribe<BaseBean<MallCartBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.CART + Constans.Action.GET_CART;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<MallCartBean>>() {
        }, call));
    }

    /**
     * 获取婚庆购物车
     *
     * @param call
     */
    public static void getWeddingCart(OnRequestSubscribe<BaseBean<WeddingCartBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.WEDDINGCART + Constans.Action.GET_CART;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<WeddingCartBean>>() {
        }, call));
    }

    /**
     * 获取音乐类别
     *
     * @param callBack
     */
    public static void getMusicTypeList(OnRequestSubscribe<BaseBean<List<InvitationsTemplateTypeBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.GET_MUSIC_TYPE_LIST;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<List<InvitationsTemplateTypeBean>>>() {
        }, callBack));
    }

    /**
     * 获取音乐列表
     *
     * @param tid
     * @param p
     * @param rows
     * @param callBack
     */
    public static void getMusicList(int tid, int p, int rows, OnRequestSubscribe<BaseBean<MusicBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.GET_MUSIC_LIST;
        Api.post(url, MapUtils.createToken().putBody("tid", tid).putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<MusicBean>>() {
        }, callBack));
    }

    /**
     * 设置模板音乐
     *
     * @param mid      请柬id
     * @param yid      音乐id
     * @param callBack
     */
    public static void setTemplateMusic(int mid, int yid, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.SET_TEMPLATE_MUSIC;
        Api.post(url, MapUtils.createToken().putBody("mid", mid).putBody("yid", yid), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取我的请柬URL
     *
     * @param id       请柬id
     * @param isEdit   是否是编辑状态， true(2): 编辑   false(1):预览
     * @param callBack
     */
    public static void getInvitationUrl(int id, boolean isEdit, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.GET_INVITATION_URL;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("type", isEdit ? 2 : 1), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 删除请柬
     *
     * @param id       请柬id
     * @param callBack
     */
    public static void delInvitation(int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.DEL_INVITATIONS;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取我的请柬列表
     *
     * @param p
     * @param rows
     * @param callBack
     */
    public static void getMineInvitationList(int p, int rows, OnRequestSubscribe<BaseBean<List<MineInvitationBean.DataBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.MINE_INVITATION;
        Api.post(url, MapUtils.createToken().putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<List<MineInvitationBean.DataBean>>>() {
        }, callBack));
    }

    /**
     * 获取我的请柬列表 新版
     *
     * @param p
     * @param rows
     * @param callBack
     */
    public static void getbNewMineInvitationList(int p, int rows, OnRequestSubscribe<BaseBean<NewMineInvitationBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.MINE_INVITATION;
        Api.post(url, MapUtils.createToken().putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<NewMineInvitationBean>>() {
        }, callBack));
    }

    /**
     * 提交个人实名认证
     *
     * @param name        姓名
     * @param identitynum 身份证号码
     * @param identitya   身份证A面
     * @param identityb   身份证b面
     */
    public static void submitPersonCertification(String name, String identitynum, String identitya, String identityb, String shou_chi_SFZ, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.SUBMIT_PERSON_CERTIFICATION;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("name", name);
        mapUtils.putBody("identitynum", identitynum);
        mapUtils.putBody("identitya", identitya);
        mapUtils.putBody("identityb", identityb);
        mapUtils.putBody("shou_chi_SFZ", shou_chi_SFZ);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取个人实名认证状态
     *
     * @param callBack
     */
    public static void getPersonCertificationStatus(OnRequestSubscribe<BaseBean<CertificationsBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.GET_PERSON_CERTIFICATION;
        MapUtils mapUtils = MapUtils.createToken();
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<CertificationsBean>>() {
        }, callBack));
    }

    /**
     * 获取企业实名认证状态
     *
     * @param callBack
     */
    public static void getCompanyCertificationStatus(OnRequestSubscribe<BaseBean<CertificationsBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.GET_COMPANY_CERTIFICATION;
        MapUtils mapUtils = MapUtils.createToken();
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<CertificationsBean>>() {
        }, callBack));
    }

    /**
     * 提交企业实名认证
     *
     * @param name        姓名
     * @param identitynum 身份证号码
     * @param identitya   身份证A面
     * @param identityb   身份证b面
     */
    public static void submitCompanyCertification(String name, String identitynum, String identitya, String identityb, String imga, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.SUBMIT_COMPANY_CERTIFICATION;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("name", name);
        mapUtils.putBody("identitynum", identitynum);
        mapUtils.putBody("identitya", identitya);
        mapUtils.putBody("identityb", identityb);
        mapUtils.putBody("imga", imga);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取需求列表
     *
     * @param type         类型            1婚庆 2商城
     * @param cityId       当前城市id      不传就是全国，传了就是同城
     * @param countyid     区id
     * @param browsingsort 浏览排序        从低到高传asc，从高到底传desc
     * @param pricesorting 价格排序        从低到高传asc，从高到底传desc
     * @param timesorting  时间排序        从低到高传asc，从高到底传desc
     * @param p
     * @param rows
     * @param callBack
     */
    public static void getNeedList(String type, String cityId, String countyid, String browsingsort, String pricesorting, String timesorting, int p, int rows, OnRequestSubscribe<BaseBean<List<MineNeedBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NEED + Constans.Action.GET_OTHER_NEED_LIST;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("type", type);
        mapUtils.putBody("cityId", cityId);
        mapUtils.putBody("countyid", countyid);
        mapUtils.putBody("browsingsort", browsingsort);
        mapUtils.putBody("pricesorting", pricesorting);
        mapUtils.putBody("timesorting", timesorting);
        mapUtils.putBody("p", p);
        mapUtils.putBody("rows", rows);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<List<MineNeedBean>>>() {
        }, callBack));
    }

    /**
     * 获取我的需求列表
     *
     * @param status   需求状态 0 全部， 1进行中 2已结束
     * @param p        页
     * @param rows     条数
     * @param callBack
     */
    public static void getMineNeedList(int status, int p, int rows, OnRequestSubscribe<BaseBean<List<MineNeedBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NEED + Constans.Action.GET_MYNEED_LIST;
        Api.post(url, MapUtils.createToken().putBody("status", status).putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<List<MineNeedBean>>>() {
        }, callBack));
    }

    /**
     * 关闭需求
     *
     * @param id 需求id
     */
    public static void closeMineNeed(int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NEED + Constans.Action.CLOSE_MYNEED;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 删除需求
     *
     * @param id       需求id
     * @param callBack
     */
    public static void delMineNeed(int id, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NEED + Constans.Action.DEL_MYNEED;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取我的需求详情
     *
     * @param id
     * @param callBack
     */
    public static void getMineNeedDetail(int id, OnRequestSubscribe<BaseBean<MineNeedDetailBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NEED + Constans.Action.GET_MYNEED_DETAIL;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<MineNeedDetailBean>>() {
        }, callBack));
    }

    /**
     * 我来接单
     *
     * @param id
     * @param cont
     * @param callBack
     */
    public static void takeNeedOrder(int id, String cont, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NEED + Constans.Action.TAKE_NEED_ORDER;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("cont", cont), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取参与详情
     *
     * @param cid      参与id
     * @param callBack
     */
    public static void getNeedJoinDetail(int cid, OnRequestSubscribe<BaseBean<NeedJoinDetailBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NEED + Constans.Action.GET_NEED_JOIN_DETAIL;
        Api.post(url, MapUtils.createToken().putBody("cid", cid), new BaseCallBack<>(new TypeToken<BaseBean<NeedJoinDetailBean>>() {
        }, callBack));
    }

    /**
     * 需求和他合作
     *
     * @param cid      参与接单id
     * @param callBack
     */
    public static void needCooperation(long cid, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NEED + Constans.Action.NEED_COOPERATION;
        Api.post(url, MapUtils.createToken().putBody("cid", cid), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取婚礼新闻
     *
     * @param type     类型 ： 1. 公告    2. 新闻
     * @param p
     * @param rows
     * @param callBack
     */
    public static void getWeddingNews(int type, int p, int rows, OnRequestSubscribe<BaseBean<List<WeddingNewsBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.GET_WEDDING_NEWS;
        Api.post(url, MapUtils.create().putBody("type", type).putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<List<WeddingNewsBean>>>() {
        }, callBack));
    }


    public static void descoverWeddingList(int type, int p, int rows, OnRequestSubscribe<BaseBean<List<WeddingNewsBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.GET_WEDDING_NEWS;
        Api.post(url, MapUtils.create().putBody("type", type).putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<List<WeddingNewsBean>>>() {
        }, callBack));
    }

    /**
     * 婚庆圈
     *
     * @param follow
     * @param hot
     * @param newest
     * @param p
     * @param rows
     * @param type
     * @param callBack
     */
    public static void getDiscover(String api, @Nullable String follow, @Nullable String hot, @Nullable String newest, String p, String rows, @Nullable String type, OnRequestSubscribe<BaseBean<ArrayList<WeddingRingBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOUND + api;
        MapUtils mapUtils = MapUtils.createToken();
        if (follow != null) {
            mapUtils.putBody("follow", follow + "");
        }
        if (hot != null) {
            mapUtils.putBody("hot", hot + "");
        }
        if (newest != null) {
            mapUtils.putBody("newest", newest + "");
        }
        if (type != null && !api.equals(Constans.Action.SHOPQUAN)) {
            mapUtils.putBody("type", type + "");
        }
        Api.post(url, mapUtils.putBody("p", p + "").putBody("rows", rows + ""), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<WeddingRingBean>>>() {
        }, callBack));
    }


    /**
     * 获取我的邀请信息
     *
     * @param time     查询日期时间戳
     * @param callBack
     */
    public static void getMineInvitationInfo(long time, OnRequestSubscribe<BaseBean<MineInvitationInfoBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITED + Constans.Action.GET_MINE_INVITATION_INFO;
        Api.post(url, MapUtils.createToken().putBody("time", time), new BaseCallBack<>(new TypeToken<BaseBean<MineInvitationInfoBean>>() {
        }, callBack));
    }

    /**
     * 获取定位城市的id
     *
     * @param cityname 城市名 如：成都市
     * @param callBack
     */
    public static void getCityId(String cityname, OnRequestSubscribe<BaseBean<GetCityBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.GET_CITY_ID;
        Api.post(url, MapUtils.create().putBody("cityname", cityname), new BaseCallBack<>(new TypeToken<BaseBean<GetCityBean>>() {
        }, callBack));
    }

    public static void getCityIdNew(String cityname, OnRequestSubscribe<BaseBean<CityEntity>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.GET_CITY_ID;
        Api.post(url, MapUtils.create().putBody("cityname", cityname), new BaseCallBack<>(new TypeToken<BaseBean<CityEntity>>() {
        }, callBack));
    }

    /**
     * 删除婚庆购物车商品
     *
     * @param rec_id
     * @param call
     */
    public static void removeWeddingCart(int rec_id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.WEDDINGCART + Constans.Action.REMOVECART;
        Api.post(url, MapUtils.createToken().putBody("rec_id", rec_id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 删除商城购物车商品
     *
     * @param rec_id
     * @param call
     */
    public static void removeCart(int rec_id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.CART + Constans.Action.REMOVECART;
        Api.post(url, MapUtils.createToken().putBody("rec_id", rec_id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 修改婚庆购物车数量
     *
     * @param rec_id
     * @param quantity
     * @param call
     */
    public static void updateWeddingCartNumber(int rec_id, String quantity, OnRequestSubscribe<BaseBean<WeddingCartBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.WEDDINGCART + Constans.Action.UPDATE;
        Api.post(url, MapUtils.createToken().putBody("rec_id", rec_id).putBody("quantity", quantity), new BaseCallBack<>(new TypeToken<BaseBean<WeddingCartBean>>() {
        }, call));
    }

    /**
     * 修改商城购物车数量
     *
     * @param rec_id
     * @param quantity
     * @param call
     */
    public static void updateCartNumber(int rec_id, String quantity, OnRequestSubscribe<BaseBean<MallCartBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.CART + Constans.Action.UPDATE;
        Api.post(url, MapUtils.createToken().putBody("rec_id", rec_id).putBody("quantity", quantity), new BaseCallBack<>(new TypeToken<BaseBean<MallCartBean>>() {
        }, call));
    }

    /**
     * 控制商家关注
     *
     * @param id       店铺id
     * @param isCare   是否关注
     * @param callBack
     */
    public static void controlShangJiaCare(long id, boolean isCare, OnRequestSubscribe<BaseBean<String>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + (isCare ? Constans.Action.ADD_SJ_FOLLOW : Constans.Action.DEL_SJ_FOLLOW);
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, callBack));
    }

    /**
     * 获取黄道吉日列表
     *
     * @param date
     * @param callBack
     */
    public static void getLuckDayList(String date, Callback.CommonCallback<String> callBack) {
        String url = "http://v.juhe.cn/calendar/day";
        RequestParams entity = new RequestParams(url);
        entity.addBodyParameter("date", date);
        entity.addBodyParameter("key", "0a164998cb748dd67a0609e4ff29ab60");
        OkHttpRequest.get(entity, callBack);
    }

    /**
     * 婚庆订单结算
     *
     * @param rec_id
     * @param call
     */
    public static void getWeddingOreder(String rec_id, OnRequestSubscribe<BaseBean<WeddingOrderBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.WEDDINGCART + Constans.Action.SUREORDER;
        Api.post(url, MapUtils.createToken().putBody("rec_id", rec_id), new BaseCallBack<>(new TypeToken<BaseBean<WeddingOrderBean>>() {
        }, call));
    }

    /**
     * 商城订单结算
     *
     * @param rec_id
     * @param call
     */
    public static void getMallOreder(String rec_id, OnRequestSubscribe<BaseBean<MallOrderBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.CART + Constans.Action.SUREORDER;
        Api.post(url, MapUtils.createToken().putBody("rec_id", rec_id), new BaseCallBack<>(new TypeToken<BaseBean<MallOrderBean>>() {
        }, call));
    }

    /**
     * 婚庆订单结算提交
     *
     * @param rec_id
     * @param call
     */
    public static void submitWeddingOreder(String rec_id, @Nullable String liuyanid, @Nullable String remark, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.WEDDINGCART + Constans.Action.SUBMITORDER;
        MapUtils mapUtils = MapUtils.createToken();
        if (remark != null && !remark.equals("")) {
            mapUtils.putBody("remark", remark);
        }
        if (liuyanid != null && !liuyanid.equals("")) {
            mapUtils.putBody("liuyanid", liuyanid);
        }
        Api.post(url, mapUtils.putBody("rec_id", rec_id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 商城订单结算提交
     *
     * @param rec_id
     * @param call
     */
    public static void submitMallOreder(String rec_id, @Nullable String content, String address, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.CART + Constans.Action.SUBMITMALLORDER;
        MapUtils mapUtils = MapUtils.createToken();
        if (content != null && !content.equals("")) {
            mapUtils.putBody("content", content);
        }
        Api.post(url, mapUtils.putBody("rec_id", rec_id).putBody("address", address), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 婚庆订单支付
     *
     * @param id
     * @param type
     * @param call
     */
    public static void payWeddingOreder(String id, String type, OnRequestSubscribe<BaseBean<PayBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.EXAMPLE + Constans.Action.PAY_WEDDING_ORDER;
        Api.post(url, MapUtils.create().putBody("id", id).putBody("type", type), new BaseCallBack<>(new TypeToken<BaseBean<PayBean>>() {
        }, call));
    }

    /**
     * 商城订单支付
     *
     * @param id
     * @param type
     * @param call
     */
    public static void payMallOreder(String id, String type, OnRequestSubscribe<BaseBean<PayBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.EXAMPLE + Constans.Action.PAY_MALL_ORDER;
        Api.post(url, MapUtils.create().putBody("id", id).putBody("type", type), new BaseCallBack<>(new TypeToken<BaseBean<PayBean>>() {
        }, call));
    }

    public static void charge(String price,String beizhu,String paytype, OnRequestSubscribe<BaseBean<PayBean>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FINANCE+ Constans.Action.INDEX;
        MapUtils mapUtils = MapUtils.createToken()
                .putBody("money",price)
                .putBody("beizhu",beizhu)
                .putBody("paytype",paytype)
                ;
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<PayBean>>() {
        }, callBack));
    }

    /**
     * 添加商品到购物车 婚庆
     *
     * @param baojiadate
     * @param baojiaid
     * @param baojiatime
     * @param paytype
     * @param quantity
     * @param call
     */
    public static void addWeddingCartGoods(String baojiadate, String baojiaid, int baojiatime, int paytype, String quantity,String agreedPrice, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.WEDDINGCART + Constans.Action.WEDDING_ADD;
        Api.post(url, MapUtils.createToken().putBody("baojiadate", baojiadate).putBody("baojiaid", baojiaid).putBody("baojiatime", baojiatime)
                .putBody("paytype", paytype)
                .putBody("quantity", quantity)
                .putBody("agreedPrice",agreedPrice)
                , new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 添加商品到购物车 商城
     *
     * @param spec_id
     * @param quantity
     * @param call
     */
    public static void addMallCartGoods(String spec_id, String quantity, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.CART + Constans.Action.WEDDING_ADD;
        Api.post(url, MapUtils.createToken().putBody("spec_id", spec_id).putBody("quantity", quantity), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 获取购物车数量
     *
     * @param type 1婚庆2商场
     * @param call
     */
    public static void getCartNum(int type, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.CART + Constans.Action.CART_NUM;
        Api.post(url, MapUtils.createToken().putBody("type", type), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 获取婚姻登记处接口
     *
     * @param province
     * @param city
     * @param callBack
     */
    public static void getRegistryOfMarriage(String province, String city, OnRequestSubscribe<BaseBean<List<RegistryOfMarriageBean>>> callBack) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SMALLTOOLS + Constans.Action.GET_REGISTRYO_OF_MARRIAGE_LIST;
        Api.post(url, MapUtils.create().putBody("province", province).putBody("city", city), new BaseCallBack<>(new TypeToken<BaseBean<List<RegistryOfMarriageBean>>>() {
        }, callBack));
    }


    /**
     * 热门搜索
     *
     * @param call
     */
    public static void getSearchHot(OnRequestSubscribe<BaseBean<SearchKeyBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.SEARCH_HOT;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<SearchKeyBean>>() {
        }, call));
    }


    /**
     * 立即购买 婚庆订单信息
     *
     * @param baojiadate
     * @param baojiaid
     * @param baojiatime
     * @param paytype
     * @param quantity
     * @param call
     */
    public static void buyNowWedding(String baojiadate, int baojiaid, int baojiatime, int paytype, String quantity,String agreedPrice, OnRequestSubscribe<BaseBean<WeddingOrderBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.BUYNOW_WEDDING;
        Api.post(url, MapUtils.createToken().putBody("baojiadate", baojiadate).putBody("baojiaid", baojiaid)
                .putBody("baojiatime", baojiatime).putBody("paytype", paytype)
                .putBody("quantity", quantity).putBody("agreedPrice", agreedPrice)

                , new BaseCallBack<>(new TypeToken<BaseBean<WeddingOrderBean>>() {
        }, call));
    }

    /**
     * 立即购买 商城订单信息
     *
     * @param skuid
     * @param number
     * @param call
     */
    public static void buyNowMall(int skuid, String number, OnRequestSubscribe<BaseBean<MallOrderBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.BUYNOW_MALL;
        Api.post(url, MapUtils.createToken().putBody("skuid", skuid).putBody("number", number), new BaseCallBack<>(new TypeToken<BaseBean<MallOrderBean>>() {
        }, call));
    }

    /**
     * 立即购买 婚庆提交订单
     *
     * @param baojiadate
     * @param baojiaid
     * @param baojiatime
     * @param paytype
     * @param quantity
     * @param remark
     * @param call
     */
    public static void submitBuyNowWedding(String baojiadate, int baojiaid, int baojiatime, int paytype, String quantity, @Nullable String remark,String agreedPrice, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.SUBMIT_BUYNOW_WEDDING;
        MapUtils mapUtils = MapUtils.createToken();
        if (remark != null && !remark.equals("")) {
            mapUtils.putBody("remark", remark);
        }
        Api.post(url, mapUtils.putBody("baojiadate", baojiadate).putBody("baojiaid", baojiaid).putBody("baojiatime", baojiatime).putBody("paytype", paytype)
                .putBody("quantity", quantity)
                .putBody("agreedPrice", agreedPrice)

                , new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 商城立即购买 提交订单
     *
     * @param content
     * @param number
     * @param siteid
     * @param call
     */
    public static void submitBuyNowMall(String content, String number, int skuid, String siteid, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.SUBMIT_BUYNOW_MALL;
        MapUtils mapUtils = MapUtils.createToken();
        if (content != null && !content.equals("")) {
            mapUtils.putBody("remark", content);
        }
        Api.post(url, mapUtils.putBody("number", number).putBody("siteid", siteid).putBody("skuid", skuid), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }


    /**
     * @param p
     * @param rows
     * @param content       搜索内容
     * @param cityId        城市id
     * @param cityType      1.同城  2.全国
     * @param searchType    搜索类型sj商家al案例fw报价sp商品
     * @param countyid      区域id
     * @param occupationid  职业id
     * @param comprehensive 综合排序1
     * @param floorprice    最低价
     * @param ceilingprice  最高价
     * @param college       是否学院认证1是 2不是
     * @param isshopvip     是否会员商家1是2否
     * @param platform      是否平台认证1是 2不是
     * @param sincerity     是否诚信认证1是 2不是
     * @param team          商家类型，1个人，2团队
     * @param call
     */
    public static void searchDetail(String p, String rows, String content, int cityId, int cityType, String searchType,
                                    int countyid, int occupationid, int comprehensive, String floorprice,
                                    String ceilingprice, int college, int isshopvip, int platform,
                                    int sincerity, int team,
                                    OnRequestSubscribe<BaseBean<SearchSJBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.SEARCH;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("p", p);
        mapUtils.putBody("rows", rows);
        mapUtils.putBody("cont", content);

        if (cityType != 2) {
            mapUtils.putBody("city", cityId);
            mapUtils.putBody("countyid", countyid);
        }
        mapUtils.putBody("types", cityType);
        mapUtils.putBody("stype", searchType);


        mapUtils.putBody("occupationid", occupationid);


        mapUtils.putBody("comprehensive", comprehensive);
        if (ceilingprice != null) {
            mapUtils.putBody("floorprice", floorprice);
        }
        if (ceilingprice != null) {
            mapUtils.putBody("ceilingprice", ceilingprice);
        }
        mapUtils.putBody("college", college);
        mapUtils.putBody("isshopvip", isshopvip);
        mapUtils.putBody("platform", platform);
        mapUtils.putBody("sincerity", sincerity);
        mapUtils.putBody("team", team);

        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<SearchSJBean>>() {
        }, call));
    }

    /**
     * @param p
     * @param rows
     * @param content
     * @param cityId
     * @param cityType
     * @param searchType
     * @param ambient       环境id
     * @param type          类型id
     * @param comprehensive
     * @param floorprice
     * @param ceilingprice
     * @param call
     */
    public static void searchCase(String p, String rows, String content, int cityId, int cityType, String searchType,
                                  int ambient, int type, int comprehensive, String floorprice, String ceilingprice,
                                  OnRequestSubscribe<BaseBean<SearchSJBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.SEARCH;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("p", p);
        mapUtils.putBody("rows", rows);
        mapUtils.putBody("cont", content);

        if (cityType != 2) {
            mapUtils.putBody("city", cityId);
        }
        mapUtils.putBody("types", cityType);
        mapUtils.putBody("stype", searchType);

        mapUtils.putBody("ambient", ambient);
        mapUtils.putBody("type", type);


        mapUtils.putBody("orderby", comprehensive);
        if (ceilingprice != null) {
            mapUtils.putBody("floorprice", floorprice);
        }
        if (ceilingprice != null) {
            mapUtils.putBody("ceilingprice", ceilingprice);
        }

        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<SearchSJBean>>() {
        }, call));
    }

    public static void searchShop(String p, String rows, String content, int cityId, int cityType, String searchType,
                                  int comprehensive, String price, int salesvolume, OnRequestSubscribe<BaseBean<SearchSJBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.SEARCH;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("p", p);
        mapUtils.putBody("rows", rows);
        mapUtils.putBody("cont", content);
        if (cityType != 2) {
            mapUtils.putBody("city", cityId);
        }
        mapUtils.putBody("types", cityType);
        mapUtils.putBody("stype", searchType);

        mapUtils.putBody("comprehensive", comprehensive);
        if (price != null) {
            mapUtils.putBody("price", price);
        }
        mapUtils.putBody("salesvolume", salesvolume);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<SearchSJBean>>() {
        }, call));
    }

    public static void searchGoodsByType(int comprehensive, int id, String keyword, String p, String rows, String price, int salesvolume, OnRequestSubscribe<BaseBean<SearchSJBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.HOME_SHOP + Constans.Action.GET_MY_COMMODITY_LIST;
        MapUtils mapUtils = MapUtils.create();
        if (price != null) {
            mapUtils.putBody("price", price);
        }
        Api.post(url, MapUtils.create().putBody("comprehensive", comprehensive).putBody("id", id).putBody("keyword", keyword).putBody("p", p).putBody("rows", rows).putBody("salesvolume", salesvolume), new BaseCallBack<>(new TypeToken<BaseBean<SearchSJBean>>() {
        }, call));
    }


    /**
     * 婚庆余额支付
     *
     * @param id
     * @param pwd
     * @param call
     */
    public static void weddingBlancePay(String id, String pwd, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.WEDDINGCART + Constans.Action.WEDDINGBLANCE;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("pwd", pwd), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 商城余额支付
     *
     * @param id
     * @param pwd
     * @param call
     */
    public static void mallBlancePay(String id, String pwd, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.CART + Constans.Action.SHOPBLANCE;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("pwd", pwd), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 动态关注
     *
     * @param id
     * @param call
     */
    public static void discoverAttention(String id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.DISCOVIER_ATTENTION;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /***
     * 动态取消关注
     * @param id
     * @param call
     */
    public static void discoverAttentionCancel(String id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOLLOW + Constans.Action.DISCOVIER_ATTENTION_CANCEL;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 粉丝
     *
     * @param call
     */
    public static void fens(OnRequestSubscribe<BaseBean<List<FensEntity>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.MY_FENSI;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<List<FensEntity>>>() {
        }, call));
    }


    /**
     * 我的关注
     *
     * @param p
     * @param rows
     * @param type 1商家 2用户 3案例 4商品
     * @param call
     */
    public static void myAttentionList(String p, String rows, int type, OnRequestSubscribe<BaseBean<AttentionData>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.ATTENTION_LIST;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("p", p);
        mapUtils.putBody("rows", rows);
        mapUtils.putBody("type", type);

        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<AttentionData>>() {
        }, call));
    }

    /**
     * 余额
     *
     * @param call
     */
    public static void bankBalance(OnRequestSubscribe<BaseBean<String>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.BANKROLL + Constans.Action.BANK_BALANCE;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, call));
    }

    /**
     * 收支明细
     *
     * @param p
     * @param rows
     * @param call
     */
    public static void bankMoneyDetail(String p, String rows, OnRequestSubscribe<BaseBean<List<YuEDetailEntity>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.BANKROLL + Constans.Action.BANK_SCHEDULE;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("p", p);
        mapUtils.putBody("rows", rows);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<List<YuEDetailEntity>>>() {
        }, call));
    }

    /**
     * 提现详情
     *
     * @param call
     */
    public static void bankTixianDetail(OnRequestSubscribe<BaseBean<TixianData>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.BANKROLL + Constans.Action.BANK_TIXIAN_DETAIL;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<TixianData>>() {
        }, call));
    }

    /**
     * 提交提现
     *
     * @param call
     */
    public static void bankTixianSubmit(String bankid, String paypassword, String jine, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.BANKROLL + Constans.Action.BANK_TIXIAN_SUBMIT;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("bankid", bankid);
        mapUtils.putBody("jine", jine);
        mapUtils.putBody("paypassword", paypassword);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 支付宝提交提现
     *
     * @param call
     */
    public static void aliPayTixianSubmit(String yid, String pwd, String money, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.BANKROLL + Constans.Action.ALIPAY_TIXIAN_SUBMIT;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("yid", yid);
        mapUtils.putBody("money", money);
        mapUtils.putBody("pwd", pwd);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    //删除银行卡
    public static void bankDelete(String id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.BANKROLL + Constans.Action.BANK_CARDS_DELETE;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    //删除支付宝账户
    public static void aliPayDelete(String id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.BANKROLL + Constans.Action.ALIPAY_DELETE;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 银行卡列表
     *
     * @param call
     */
    public static void bankCardList(OnRequestSubscribe<BaseBean<List<BankCardEntity>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.BANKROLL + Constans.Action.BANK_CARDS_LIST;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<List<BankCardEntity>>>() {
        }, call));
    }

    /**
     * 支付宝账户列表
     *
     * @param call
     */
    public static void aliPayList(OnRequestSubscribe<BaseBean<BankCardEntity>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.BANKROLL + Constans.Action.ALIPAY_LIST;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<BankCardEntity>>() {
        }, call));
    }

    /**
     * 添加银行卡第一步
     *
     * @param card
     * @param name
     * @param call
     */
    public static void bankAddCard1(String card, String name, OnRequestSubscribe<BaseBean<BankCard1Entity>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.BANKROLL + Constans.Action.BANK_CARD_ADD1;
        Api.post(url, MapUtils.createToken().putBody("bankcard", card).putBody("name", name), new BaseCallBack<>(new TypeToken<BaseBean<BankCard1Entity>>() {
        }, call));
    }

    /**
     * 添加支付宝账户
     *
     * @param ali_name
     * @param name
     * @param call
     */
    public static void aliPayAdd(String ali_name, String name, String mobile, String verifycode, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.BANKROLL + Constans.Action.ALI_PAY_ADD;
        Api.post(url, MapUtils.createToken().putBody("ali_name", ali_name).putBody("name", name).putBody("mobile", mobile).putBody("verifycode", verifycode), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }


    /**
     * 提交银行卡
     *
     * @param bandname
     * @param bandnumber
     * @param name
     * @param mobile
     * @param site       分行名称
     * @param verifycode
     * @param call
     */
    public static void bankAddCard3(String bandname, String bandnumber, String province, String city, String name, String mobile, String site, String verifycode, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.BANKROLL + Constans.Action.BANK_CARD_ADD3;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("bandname", bandname);
        mapUtils.putBody("bandnumber", bandnumber);
        mapUtils.putBody("mobile", mobile);
        mapUtils.putBody("name", name);
        mapUtils.putBody("site", site);
        mapUtils.putBody("province", province);
        mapUtils.putBody("city", city);
        mapUtils.putBody("verifycode", verifycode);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 查询婚期订单列表
     *
     * @param status
     * @param call
     */
    public static void getWeddingOrderList(@Nullable String status,@Nullable String title,int p, int rows, OnRequestSubscribe<BaseBean<WeddingOrderListBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.INDEX;
        MapUtils mapUtils = MapUtils.createToken();
        if (status != null && !status.equals("")) {
            mapUtils.putBody("status", status);
        }
        if (title != null && !title.equals("")) {
            mapUtils.putBody("title", title);
        }
        Api.post(url, mapUtils.putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<WeddingOrderListBean>>() {
        }, call));
    }

    /**
     * 查询商城订单列表
     *
     * @param status
     * @param call
     */
    public static void getMallOrderList(@Nullable String status, int p, int rows, OnRequestSubscribe<BaseBean<MallOrderListBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.INDEX;
        MapUtils mapUtils = MapUtils.createToken();
        if (status != null && !status.equals("")) {
            mapUtils.putBody("status", status);
        }
        Api.post(url, mapUtils.putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<MallOrderListBean>>() {
        }, call));
    }

    /**
     * 查询婚期接单列表
     *
     * @param status
     * @param call
     */
    public static void getWeddingJieDanOrderList(@Nullable String status,@Nullable String title, int p, int rows, OnRequestSubscribe<BaseBean<WeddingJieDanOrderList>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.JIEDAN;
        MapUtils mapUtils = MapUtils.createToken();
        if (status != null && !status.equals("")) {
            mapUtils.putBody("status", status);
        }
        if (title != null && !title.equals("")) {
            mapUtils.putBody("title", title);
        }
        Api.post(url, mapUtils.putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<WeddingJieDanOrderList>>() {
        }, call));
    }

    /**
     * 查询商城接单列表
     *
     * @param status
     * @param call
     */
    public static void getMallJieDanOrderList(@Nullable String status, int p, int rows, OnRequestSubscribe<BaseBean<MallJieDanOrderList>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.MALLJIEDAN;
        MapUtils mapUtils = MapUtils.createToken();
        if (status != null && !status.equals("")) {
            mapUtils.putBody("status", status);
        }
        Api.post(url, mapUtils.putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<MallJieDanOrderList>>() {
        }, call));
    }

    /**
     * 个人信息
     *
     * @param call
     */
    public static void userInfo(OnRequestSubscribe<BaseBean<UserEntity>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.USER_INFO;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<UserEntity>>() {
        }, call));
    }

    /**
     * 修改个人信息
     *
     * @param userEntity
     * @param call
     */
    public static void userInfoUpdate(UserEntity userEntity, OnRequestSubscribe<BaseBean<UserEntity>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.USER_INFO_UPDATE;
        MapUtils mapUtils = MapUtils.createToken();
        if (userEntity.getAge() != null) {
            mapUtils.putBody("age", userEntity.getAge());
        }
        if (userEntity.getBirthday() != null) {
            mapUtils.putBody("birthday", userEntity.getBirthday());
        }
        if (userEntity.getCityid() != null) {
            mapUtils.putBody("cityid", userEntity.getCityid());
        }
        if (userEntity.getCountyid() != null) {
            mapUtils.putBody("countyid", userEntity.getCountyid());
        }
        if (userEntity.getHead() != null) {
            mapUtils.putBody("head", userEntity.getHead());
        }
        if (userEntity.getHeight() != null) {
            mapUtils.putBody("height", userEntity.getHeight());
        }
        if (userEntity.getWeight() != null) {
            mapUtils.putBody("weight", userEntity.getWeight());
        }
        if (userEntity.getNickname() != null) {
            mapUtils.putBody("nickname", userEntity.getNickname());
        }
        if (userEntity.getSex() != null) {
            mapUtils.putBody("sex", userEntity.getSex());
        }
        if (userEntity.getProvinceid() != null) {
            mapUtils.putBody("provinceid", userEntity.getProvinceid());
        }

        if (userEntity.getAddress() != null) {
            mapUtils.putBody("address", userEntity.getAddress());
        }
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<UserEntity>>() {
        }, call));
    }

    //上传图片
    public static void uploadImg(File image, int type, OnRequestSubscribe<BaseBean<String>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.UPLOAD_FILE;
        List<KeyValue> list = new ArrayList<>();
        list.add(new KeyValue("img", image));
        list.add(new KeyValue("type", type));
        RequestParams params = new RequestParams(url);
        MultipartBody body = new MultipartBody(list, "UTF-8");
        params.setRequestBody(body);
        params.setMultipart(true);
        OkHttpRequest.post(params, new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, call));
    }

    //收货地址列表
    public static void addressList(OnRequestSubscribe<BaseBean<List<AddressEntity>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ADDRESS + Constans.Action.ADDRESS_LIST;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<List<AddressEntity>>>() {
        }, call));
    }

    /**
     * 获取婚庆订单详情
     *
     * @param id
     * @param call
     */
    public static void getWeddingOrderDetails(int id, OnRequestSubscribe<BaseBean<WeddingOrderDetailsBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.DETAILS;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<WeddingOrderDetailsBean>>() {
        }, call));
    }

    /**
     * 获取商城订单详情
     *
     * @param id
     * @param status
     * @param call
     */
    public static void getMallOrderDetails(int id, @Nullable int status, OnRequestSubscribe<BaseBean<MallOrderDetailsBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.MALL_DETAILS;
        MapUtils mapUtils = MapUtils.createToken();
        if (status != -1) {
            mapUtils.putBody("status", status);
        }
        Api.post(url, mapUtils.putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<MallOrderDetailsBean>>() {
        }, call));
    }

    /**
     * 取消婚庆订单
     *
     * @param id
     * @param call
     */
    public static void cancelWeddingOrder(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.CANCEL_ORDER;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    //收货地址新增
    public static void addressAdd(String cityid, String countyid, String hot, String mobile, String provinceid, String site, String username,
                                  OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ADDRESS + Constans.Action.ADDRESS_ADD;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("cityid", cityid);
        mapUtils.putBody("countyid", countyid);
        mapUtils.putBody("hot", hot);
        mapUtils.putBody("mobile", mobile);
        mapUtils.putBody("provinceid", provinceid);
        mapUtils.putBody("site", site);
        mapUtils.putBody("username", username);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }


    //收货地址修改
    public static void addressUpdate(String id, String cityid, String countyid, String hot, String mobile, String provinceid, String site, String username,
                                     OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ADDRESS + Constans.Action.ADDRESS_UPDATE;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("cityid", cityid);
        mapUtils.putBody("id", id);
        mapUtils.putBody("countyid", countyid);
        mapUtils.putBody("hot", hot);
        mapUtils.putBody("mobile", mobile);
        mapUtils.putBody("provinceid", provinceid);
        mapUtils.putBody("site", site);
        mapUtils.putBody("username", username);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 删除地址
     *
     * @param id
     * @param call
     */
    public static void addressDelete(String id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ADDRESS + Constans.Action.ADDRESS_DELETE;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 设置默认地址
     *
     * @param id
     * @param call
     */
    public static void addressDefault(String id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ADDRESS + Constans.Action.ADDRESS_DEFAULT;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    //修改的密码第一步
    public static void passwordOne(String code, String phone, String api, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + api;
        Api.post(url, MapUtils.createToken().putBody("code", code).putBody("mobile", phone), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    //修改的登录密码第一步
    public static void passwordOne(String code, String phone, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.PASSWORD_UPDATE_ONE;
        Api.post(url, MapUtils.createToken().putBody("code", code).putBody("mobile", phone), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    //修改登录密码第二步
    public static void passwordTwo(String code, String phone, String password, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.PASSWORD_UPDATE_TWO;
        Api.post(url, MapUtils.createToken().putBody("code", code).putBody("mobile", phone).putBody("password", password), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    //修改的支付密码第一步
    public static void passwordPayOne(String code, String phone, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.PASSWORD_UPDATE_ONE_PAY;
        Api.post(url, MapUtils.createToken().putBody("code", code).putBody("mobile", phone), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    //修改支付密码第二步
    public static void passwordPayTwo(String code, String phone, String password, String repassword, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.PASSWORD_UPDATE_TWO_PAY;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("code", code);
        mapUtils.putBody("mobile", phone);
        mapUtils.putBody("password", password);
        mapUtils.putBody("repassword", repassword);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }


    //修改绑定手机第一步
    public static void bindpassOne(String code, String phone, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.PHONE_UPDATE_ONE;
        Api.post(url, MapUtils.createToken().putBody("code", code).putBody("mobile", phone), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 修改绑定手机第二步
     *
     * @param code   旧
     * @param phone  旧
     * @param xcode  新
     * @param xphone 新
     * @param call
     */
    public static void bindpassTwo(String code, String phone, String xcode, String xphone, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.PHONE_UPDATE_TWO;
        Api.post(url, MapUtils.createToken().putBody("code", code).putBody("mobile", phone).putBody("xcode", xcode).putBody("xmobile", xphone), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    //用户协议
    public static void agreement(OnRequestSubscribe<BaseBean<AgreementEntity>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.AGREEMENT;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<AgreementEntity>>() {
        }, call));
    }

    //绑定第三方账号
    public static void bindOther(String openid, String type, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.BIND_OTHER;
        Api.post(url, MapUtils.createToken().putBody("thirdSystemId", openid).putBody("type", type), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }


    /**
     * 婚庆订单退款详情
     *
     * @param id
     * @param call
     */
    public static void getWeddingRefund(int id, OnRequestSubscribe<BaseBean<WeddingRefundBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.WEDDING_REFUND;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<WeddingRefundBean>>() {
        }, call));
    }

    /**
     * 商城订单退款详情
     *
     * @param call
     */
    public static void getMallRefund(int rec_id, OnRequestSubscribe<BaseBean<MallRefundBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.MALL_JIEDAN_REFUND;
        Api.post(url, MapUtils.createToken().putBody("rec_id", rec_id), new BaseCallBack<>(new TypeToken<BaseBean<MallRefundBean>>() {
        }, call));
    }

    /**
     * 婚庆接单退款详情
     *
     * @param id
     * @param call
     */
    public static void getWeddingJieDanRefund(int id, OnRequestSubscribe<BaseBean<WeddingJieDanRefundBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.WEDDING_JIEDAN_REFUND;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<WeddingJieDanRefundBean>>() {
        }, call));
    }

    /**
     * 商城接单退款详情
     *
     * @param rec_id
     * @param call
     */
    public static void getMallJieDanRefund(int rec_id, OnRequestSubscribe<BaseBean<MallJieDanRefundBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.MALL_JIEDAN_REFUND;
        Api.post(url, MapUtils.createToken().putBody("rec_id", rec_id), new BaseCallBack<>(new TypeToken<BaseBean<MallJieDanRefundBean>>() {
        }, call));
    }


    /**
     * 婚庆协商历史
     *
     * @param fundid
     * @param call
     */
    public static void getWeddingXieShang(int fundid, OnRequestSubscribe<BaseBean<WeddingXieShangHistoryBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.WEDDING_XIESHANG_HISTORY;
        Api.post(url, MapUtils.createToken().putBody("fundid", fundid), new BaseCallBack<>(new TypeToken<BaseBean<WeddingXieShangHistoryBean>>() {
        }, call));
    }

    /**
     * 商场协商历史
     *
     * @param fundid
     * @param call
     */
    public static void getMallXieShang(int fundid, OnRequestSubscribe<BaseBean<MallXieShangHistoryBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.MALL_XIESHANG_HISTORY;
        Api.post(url, MapUtils.createToken().putBody("fundid", fundid), new BaseCallBack<>(new TypeToken<BaseBean<MallXieShangHistoryBean>>() {
        }, call));
    }

    /**
     * 婚庆用户撤销退款
     *
     * @param id
     * @param call
     */
    public static void canelWeddingTuiKuan(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.WEDDING_CANLE_TUIKUAN;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 商城用户撤销退款
     *
     * @param fundid
     * @param call
     */
    public static void canelMallTuiKuan(int fundid, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.MALL_CANLE_TUIKUAN;
        Api.post(url, MapUtils.createToken().putBody("fundid", fundid), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 婚庆申请退款
     *
     * @param orderid
     * @param reason
     * @param call
     */
    public static void weddingShenQingTuiKuan(int orderid, String reason, String price, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.WEDDING_SHENQINGTUIKUAN;
        Api.post(url, MapUtils.createToken().putBody("orderid", orderid).putBody("reason", reason).putBody("price", price), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }


    /**
     * 创建社团
     *
     * @param logourl
     * @param appphotourl app背景图
     * @param provinceid
     * @param cityid
     * @param countyid
     * @param address
     * @param name
     * @param profile     社团简介
     * @param type        社团类别
     * @param call
     */
    public static void communityCreate(String logourl, String appphotourl, String provinceid, String cityid,
                                       String countyid, String address, String name, String profile,
                                       String type, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.COMMUNITY_CREATE;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("logourl", logourl);
        mapUtils.putBody("appphotourl", appphotourl);
        mapUtils.putBody("provinceid", provinceid);
        mapUtils.putBody("cityid", cityid);
        mapUtils.putBody("countyid", countyid);
        mapUtils.putBody("address", address);
        mapUtils.putBody("name", name);
        mapUtils.putBody("profile", profile);
        mapUtils.putBody("type", type);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 加入社团列表
     *
     * @param name
     * @param page
     * @param rows
     * @param call
     */
    public static void communityAddList(String name, String page, String rows, OnRequestSubscribe<BaseBean<List<communityAddEntity>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MYHOME + Constans.Action.COMMUNITY_ADD_LIST;
        MapUtils mapUtils = MapUtils.createToken();
        if (!AppUtil.isEmpty(name)) {
            mapUtils.putBody("name", name);
        }
        mapUtils.putBody("p", page);
        mapUtils.putBody("rows", rows);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<List<communityAddEntity>>>() {
        }, call));
    }

    //申请加入社团

    /**
     * 加入社团列表>>申请 拒绝 同意  退出  社团
     *
     * @param id
     * @param api
     * @param call
     */
    public static void communityAddApplyDeal(String id, String api, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ASSOCIATION + api;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    //团队中心
    public static void communityCenter(OnRequestSubscribe<BaseBean<CommunityCenterEntity>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ASSOCIATION + Constans.Action.COMMUNITY_CENTER;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<CommunityCenterEntity>>() {
        }, call));
    }


    //成员管理列表
    public static void communityUserManagerList(String id, String name, OnRequestSubscribe<BaseBean<List<CommunityUserEntity>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ASSOCIATION + Constans.Action.COMMUNITY_USER_MAMAGER_LIST;
        MapUtils mapUtils = MapUtils.createToken();
        if (!AppUtil.isEmpty(name)) {
            mapUtils.putBody("name", name);
        }
        mapUtils.putBody("id", id);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<List<CommunityUserEntity>>>() {
        }, call));
    }

    /**
     * 成员管理 设置管理员  取消管理员 删除成员
     *
     * @param id
     * @param api
     * @param call
     */
    public static void communityUserManager(String id, String api, OnRequestSubscribe<BaseBean<CommunityCenterEntity>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ASSOCIATION + api;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<CommunityCenterEntity>>() {
        }, call));
    }


    //待通过成员列表
    public static void communityUserWaitingList(String id, String name, OnRequestSubscribe<BaseBean<List<CommunityUserEntity>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ASSOCIATION + Constans.Action.COMMUNITY_USER_WAITING_LIST;
        MapUtils mapUtils = MapUtils.createToken();
        if (!AppUtil.isEmpty(name)) {
            mapUtils.putBody("name", name);
        }
        mapUtils.putBody("id", id);
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<List<CommunityUserEntity>>>() {
        }, call));
    }

    //待通过成员同意 、拒绝
    public static void communityUserWaiting(String id, String api, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ASSOCIATION + api;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    //成员档期
    public static void communityScheduleList(String id, OnRequestSubscribe<BaseBean<List<CommunityScheduleEntity>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ASSOCIATION + Constans.Action.COMMUNITY_SCHEDULE;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<List<CommunityScheduleEntity>>>() {
        }, call));
    }

    //今日新增 、今日有单
    public static void communityDan(String id, String date, String api, OnRequestSubscribe<BaseBean<List<CommunityDanEntity>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ASSOCIATION + api;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("datea", date), new BaseCallBack<>(new TypeToken<BaseBean<List<CommunityDanEntity>>>() {
        }, call));
    }

    //邀请信成员列表
    public static void communityInvitationList(String id, String name, OnRequestSubscribe<BaseBean<List<CommuntiyInvitationEntity>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ASSOCIATION + Constans.Action.COMMUNITY_INVITATION_LIST;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("id", id);
        if (!AppUtil.isEmpty(name)) {
            mapUtils.putBody("name", name);
        }
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<List<CommuntiyInvitationEntity>>>() {
        }, call));
    }

    //确认邀请
    public static void communityInvitationSend(String id, String yid, OnRequestSubscribe<BaseBean<List<CommunityDanEntity>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ASSOCIATION + Constans.Action.COMMUNITY_INVITATION_SEND;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("yid", yid), new BaseCallBack<>(new TypeToken<BaseBean<List<CommunityDanEntity>>>() {
        }, call));
    }

    //获取邀请信息
    public static void invitationFriend(OnRequestSubscribe<BaseBean<ShareEntity>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITED + Constans.Action.INVITATION_FRIEND;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<ShareEntity>>() {
        }, call));
    }

    //获取邀请商家信息
    public static void invitationShop(OnRequestSubscribe<BaseBean<ShareEntity>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITED + Constans.Action.YAOQINGSJ;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<ShareEntity>>() {
        }, call));
    }


    /**
     * 支付尾款 三方支付
     *
     * @param id
     * @param type
     * @param call
     */
    public static void payWeiKuan(String id, String type,String lastamount, OnRequestSubscribe<BaseBean<PayBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.EXAMPLE + Constans.Action.WEIKUAN_PAY;
        Api.post(url, MapUtils.create().putBody("id", id).putBody("type", type).putBody("lastamount", lastamount), new BaseCallBack<>(new TypeToken<BaseBean<PayBean>>() {
        }, call));
    }

    /**
     * 支付尾款 余额
     *
     * @param orderid
     * @param pwd
     * @param call
     */
    public static void payWeiKuanByBlance(int orderid, String pwd, String lastamount,OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.WEDDINGCART + Constans.Action.WEIKUAN_PAY_YUE;
        Api.post(url, MapUtils.createToken().putBody("orderid", orderid).putBody("pwd", pwd).putBody("lastamount",lastamount), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 婚庆用户确认完成订单
     *
     * @param id
     * @param call
     */
    public static void finishWeddingOrder(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.FINISH_WEDDING_ORDER;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 婚庆商户接单
     *
     * @param id
     * @param call
     */
    public static void agreeWeddingOrder(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.AGREE_WEDDING_ORDER;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 婚庆商户拒绝接单
     *
     * @param id
     * @param call
     */
    public static void refusedWeddingOrder(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.CANEL_WEDDING_ORDER;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 婚庆商户完成订单
     *
     * @param id
     * @param paymethod
     * @param call
     */
    public static void finishWeddingOrderShop(int id, @Nullable int paymethod, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.FINISH_WEDDING_ORDER_SHOP;
        MapUtils mapUtils = MapUtils.createToken();
        if (paymethod != -1) {
            mapUtils.putBody("paymethod", paymethod);
        }
        Api.post(url, mapUtils.putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 婚庆商户完成订单
     *
     * @param id
     * @param call
     */
    public static void finishWeddingOrderShop(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.FINISH_WEDDING_ORDER_SHOP2;
        MapUtils mapUtils = MapUtils.createToken();
        Api.post(url, mapUtils.putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 婚庆用户选择线下支付
     *
     * @param id
     * @param call
     */
    public static void weedingUserUserUnderLine(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.FINISH_WEDDING_ORDER_SHOP3;
        MapUtils mapUtils = MapUtils.createToken();
        Api.post(url, mapUtils.putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 婚庆商户同意退款
     *
     * @param id
     * @param call
     */
    public static void agreeWeddingOrderTuiKuan(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.AGREE_WEDDING_ORDER_TUIKUAN;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 婚庆商户拒绝退款
     *
     * @param id
     * @param text
     * @param call
     */
    public static void refusedWeddingOrderTuiKuan(int id, String text, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.CANEL_WEDDING_ORDER_TUIKUAN;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("text", text), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 商城用户取消订单
     *
     * @param id
     * @param call
     */
    public static void canelMallOrder(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.CANEL_MALL_ORDER;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 商城用户确认收货
     *
     * @param id
     * @param call
     */
    public static void sureGetMallGoods(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.SURE_GET_MALL_GOODS;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 商城商户确认发货
     *
     * @param order_id
     * @param kuaidicode
     * @param kuaidinum
     * @param call
     */
    public static void postMallGoods(int order_id, String kuaidicode, String kuaidinum, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.POST_MALL_GOODS;
        Api.post(url, MapUtils.create().putBody("order_id", order_id).putBody("kuaidicode", kuaidicode).putBody("kuaidinum", kuaidinum), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 用户退货确认发货
     *
     * @param fund_id
     * @param kuaidicode
     * @param kuaidinum
     * @param call
     */
    public static void postMallGoodsByUser(int fund_id, String kuaidicode, String kuaidinum, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.POST_MALL_GOODS;
        Api.post(url, MapUtils.create().putBody("fund_id", fund_id).putBody("kuaidicode", kuaidicode).putBody("kuaidinum", kuaidinum), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 查看物流
     *
     * @param id
     * @param call
     */
    public static void chaKanWuLiu(int id, OnRequestSubscribe<BaseBean<ChaKanWuLiuBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.CHAKANWULIU;
        Api.post(url, MapUtils.create().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<ChaKanWuLiuBean>>() {
        }, call));
    }

    /**
     * 获取快递列表
     *
     * @param call
     */
    public static void getKuaiDiList(OnRequestSubscribe<BaseBean<ArrayList<KuaiDiBean>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.GET_KUAIDI_LIST;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<ArrayList<KuaiDiBean>>>() {
        }, call));
    }

    /**
     * 婚庆添加评价
     *
     * @param anonymous
     * @param content
     * @param id
     * @param pictures
     * @param score
     * @param call
     */
    public static void addWeddingPingJia(@Nullable int anonymous, String content, int id, @Nullable String pictures, float score, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.ADD_PINGJIA;
        MapUtils mapUtils = MapUtils.createToken();
        if (anonymous != -1) {
            mapUtils.putBody("anonymous", anonymous);
        }
        if (pictures != null && !pictures.equals("")) {
            mapUtils.putBody("pictures", pictures);
        }
        Api.post(url, mapUtils.putBody("content", content).putBody("id", id).putBody("score", score), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 商城添加评价
     *
     * @param anonymous
     * @param content
     * @param id
     * @param pictures
     * @param score
     * @param call
     */
    public static void addMallPingJia(@Nullable int anonymous, String content, int id, @Nullable String pictures, float score, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.ADD_PINGJIA;
        MapUtils mapUtils = MapUtils.createToken();
        if (anonymous != -1) {
            mapUtils.putBody("anonymous", anonymous);
        }
        if (pictures != null && !pictures.equals("")) {
            mapUtils.putBody("pictures", pictures);
        }
        Api.post(url, mapUtils.putBody("content", content).putBody("id", id).putBody("score", score), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 修改婚庆订单价格
     *
     * @param id
     * @param price
     * @param weikuanprice
     * @param call
     */
    public static void modiWeddingPrice(int id, String price, @Nullable String weikuanprice, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.MODIWEDDINGPRICE;
        MapUtils mapUtils = MapUtils.createToken();
        if (weikuanprice != null && !weikuanprice.equals("")) {
            mapUtils.putBody("weikuanprice", weikuanprice);
        }
        Api.post(url, mapUtils.putBody("id", id).putBody("price", price), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 修改商城订单价格
     *
     * @param id
     * @param newprice
     * @param call
     */
    public static void modiMallPrice(int id, String newprice, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.MODIMALLPRICE;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("newprice", newprice), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 获取分享内容
     *
     * @param id
     * @param type
     * @param types
     * @param call
     */
    public static void getShareContent(@Nullable int id, @Nullable int type, @Nullable int types, OnRequestSubscribe<BaseBean<ShareContentBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHARE + Constans.Action.SHARECONTENT;
        MapUtils mapUtils = MapUtils.createToken();
        if (id != -1) {
            mapUtils.putBody("id", id);
        }
        if (type != -1) {
            mapUtils.putBody("type", type);
        }
        if (types != -1) {
            mapUtils.putBody("types", types);
        }
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<ShareContentBean>>() {
        }, call));
    }

    public static void getActivityShareContent(@Nullable String str, @Nullable int type, OnRequestSubscribe<BaseBean<ShareContentBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SHARE + Constans.Action.SHARECONTENT;
        MapUtils mapUtils = MapUtils.createToken();
        mapUtils.putBody("str", str);
        if (type != -1) {
            mapUtils.putBody("type", type);
        }
        Api.post(url, mapUtils, new BaseCallBack<>(new TypeToken<BaseBean<ShareContentBean>>() {
        }, call));
    }

    /**
     * 店铺认证 支付
     *
     * @param id
     * @param pay
     * @param call
     */
    public static void payDianPuRenZheng(String id, String pay, @Nullable String pwd, OnRequestSubscribe<BaseBean<PayBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.AUTHENTICATION + Constans.Action.DIANPURENZHENG_PAY;
        MapUtils mapUtils = MapUtils.createToken();
        if (pwd != null && !pwd.equals("")) {
            mapUtils.putBody("pwd", pwd);
        }
        Api.post(url, mapUtils.putBody("id", id).putBody("pay", pay), new BaseCallBack<>(new TypeToken<BaseBean<PayBean>>() {
        }, call));
    }

    /**
     * 用户开通VIP
     *
     * @param call
     */
    public static void openUserVip(OnRequestSubscribe<BaseBean<UserVipBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MEMBER + Constans.Action.OPEN_VIP;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<UserVipBean>>() {
        }, call));
    }

    /**
     * 商家开通VIP
     *
     * @param call
     */
    public static void openShopVip(OnRequestSubscribe<BaseBean<ShopVipBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MEMBER + Constans.Action.OPEN_MALL_VIP;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<ShopVipBean>>() {
        }, call));
    }

    /**
     * 支付开通用户VIP
     */
    public static void payOpenUserVip(String money, String type, @Nullable String pwd, OnRequestSubscribe<BaseBean<PayBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MEMBER + Constans.Action.ROB_POPULARIZE_PAY;
        MapUtils mapUtils = MapUtils.createToken();
        if (pwd != null && !pwd.equals("")) {
            mapUtils.putBody("pwd", pwd);
        }

        Api.post(url, mapUtils.putBody("money", money).putBody("type", type), new BaseCallBack<>(new TypeToken<BaseBean<PayBean>>() {
        }, call));
    }

    /**
     * 支付开通商户VIP
     */
    public static void payOpenShopVip(String money, String shopivipstat, String type, @Nullable String pwd, OnRequestSubscribe<BaseBean<PayBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MEMBER + Constans.Action.ROB_POPULARIZE_MALL_PAY;
        MapUtils mapUtils = MapUtils.createToken();
        if (pwd != null && !pwd.equals("")) {
            mapUtils.putBody("pwd", pwd);
        }

        Api.post(url, mapUtils.putBody("money", money).putBody("type", type).putBody("shopivipstat", shopivipstat), new BaseCallBack<>(new TypeToken<BaseBean<PayBean>>() {
        }, call));
    }

    /**
     * 邀请朋友
     *
     * @param call
     */
    public static void invitedFriend(OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITED + Constans.Action.COMMUNITY_INVITATION_SEND;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 获取商城订单 申请退款信息 未发货
     *
     * @param rec_id
     * @param call
     */
    public static void getMallTuiKuanInfo(int rec_id, OnRequestSubscribe<BaseBean<MallTuiKuanInfoBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.MALL_JIEDAN_REFUND;
        Api.post(url, MapUtils.createToken().putBody("rec_id", rec_id), new BaseCallBack<>(new TypeToken<BaseBean<MallTuiKuanInfoBean>>() {
        }, call));
    }

    /**
     * 获取商城订单 申请退款信息 已发货
     *
     * @param rec_id
     * @param call
     */
    public static void getMallTuiKuanYiFaHuoInfo(int rec_id, OnRequestSubscribe<BaseBean<MallTuiKuanInfoBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.YIFAHUOTUIHUOKUAN;
        Api.post(url, MapUtils.createToken().putBody("rec_id", rec_id), new BaseCallBack<>(new TypeToken<BaseBean<MallTuiKuanInfoBean>>() {
        }, call));
    }

    /**
     * 商城提交退款申请 未发货
     *
     * @param photu
     * @param reason
     * @param rec_id
     * @param refund_price
     * @param refund_type
     * @param call
     */
    public static void postMallTuiKuan(@Nullable String photu, String reason, int rec_id, String refund_price, int refund_type, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.TUIHUOKUAN;
        MapUtils mapUtils = MapUtils.createToken();
        if (photu != null && !photu.equals("")) {
            mapUtils.putBody("photu", photu);
        }
        Api.post(url, mapUtils.putBody("rec_id", rec_id).putBody("reason", reason).putBody("refund_price", refund_price).putBody("refund_type", refund_type), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 商城提交退款申请 已发货
     *
     * @param photu
     * @param reason
     * @param rec_id
     * @param refund_price
     * @param refund_type
     * @param call
     */
    public static void postMallTuiKuanYiFaHuo(@Nullable String photu, String reason, int rec_id, String refund_price, int refund_type, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.TUIHUOKUANFAHUO;
        MapUtils mapUtils = MapUtils.createToken();
        if (photu != null && !photu.equals("")) {
            mapUtils.putBody("photu", photu);
        }
        Api.post(url, mapUtils.putBody("rec_id", rec_id).putBody("reason", reason).putBody("refund_price", refund_price).putBody("refund_type", refund_type), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 申请成为商家
     *
     * @param userid
     * @param call
     */
    public static void shenQingBeShop(int type, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.MEMBER + Constans.Action.SHENQINGBESHOP;
        Api.post(url, MapUtils.createToken().putBody("type", type), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 检测APP更新
     *
     * @param code
     * @param call
     */
    public static void checkVersion(int code, OnRequestSubscribe<BaseBean<UpdateBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.SYSTEM + Constans.Action.ISEDITION;
        Api.post(url, MapUtils.create().putBody("code", code), new BaseCallBack<>(new TypeToken<BaseBean<UpdateBean>>() {
        }, call));
    }

    /**
     * 同意未发货退款
     *
     * @param fundid
     * @param call
     */
    public static void agreeweifahuotuikuan(int fundid, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.TONGYITUIKUAN;
        Api.post(url, MapUtils.createToken().putBody("fundid", fundid), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 拒绝未发货退款
     *
     * @param fundid
     * @param text
     * @param call
     */
    public static void canlefahuotuikuan(int fundid, String text, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.JUJUETUIKUAN;
        Api.post(url, MapUtils.createToken().putBody("fundid", fundid).putBody("text", text), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 同意已发货退款
     *
     * @param fundid
     * @param call
     */
    public static void agreeyifahuotuikuan(int fundid, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.TONGYYITUIHUIKUAN;
        Api.post(url, MapUtils.createToken().putBody("fundid", fundid), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 拒绝已发货退款
     *
     * @param fundid
     * @param text
     * @param call
     */
    public static void canleyifahuotuikuan(int fundid, String text, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.REFUSERTURNGOODSSH;
        Api.post(url, MapUtils.createToken().putBody("fundid", fundid).putBody("text", text), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 同意收货退款
     *
     * @param fundid
     * @param call
     */
    public static void agreeshouhuotuikuan(int fundid, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.FAHUOQUERENSHOUHUO;
        Api.post(url, MapUtils.createToken().putBody("fundid", fundid), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 拒绝收货退款
     *
     * @param fundid
     * @param call
     */
    public static void canleshouhuotuikuan(int fundid, String text, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWMALLORDER + Constans.Action.FAHUOJUJUESHOU;
        Api.post(url, MapUtils.createToken().putBody("fundid", fundid).putBody("text", text), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 删除动态
     *
     * @param id
     * @param call
     */
    public static void delDontTai(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.FOUND + Constans.Action.DELDYNAMICS;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 获取积分商城首页
     *
     * @param call
     */
    public static void getJiFenIndex(OnRequestSubscribe<BaseBean<JiFenIndexBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.INTEGRALINDEX;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<JiFenIndexBean>>() {
        }, call));
    }

    /**
     * 积分商城签到
     *
     * @param call
     */
    public static void signIn(OnRequestSubscribe<BaseBean<SignInBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.SIGNIN;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<SignInBean>>() {
        }, call));
    }

    /**
     * 积分商城获取全部商品
     *
     * @param p
     * @param rows
     * @param call
     */
    public static void getJiFenGoods(int p, int rows, OnRequestSubscribe<BaseBean<JiFenGoodsBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.SEEINTEGRALSHOP;
        Api.post(url, MapUtils.create().putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<JiFenGoodsBean>>() {
        }, call));
    }

    /**
     * 积分商城获取全部红包
     *
     * @param p
     * @param rows
     * @param call
     */
    public static void getJiFenHongBao(int p, int rows, OnRequestSubscribe<BaseBean<JiFenHongBaoBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.CHAKANHONGBAO;
        Api.post(url, MapUtils.create().putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<JiFenHongBaoBean>>() {
        }, call));
    }

    /**
     * 积分明细
     *
     * @param p
     * @param rows
     * @param call
     */
    public static void getJiFenMingXi(int p, int rows, OnRequestSubscribe<BaseBean<JiFenDetailsBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.INTEGRALDETAIL;
        Api.post(url, MapUtils.createToken().putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<JiFenDetailsBean>>() {
        }, call));
    }

    /**
     * 获取兑换记录
     *
     * @param p
     * @param rows
     * @param type
     * @param call
     */
    public static void getDuiHuanJiLu(int p, int rows, int type, OnRequestSubscribe<BaseBean<ExchangeJiFenBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.DUIHUANJILU;
        Api.post(url, MapUtils.createToken().putBody("p", p).putBody("rows", rows).putBody("type", type), new BaseCallBack<>(new TypeToken<BaseBean<ExchangeJiFenBean>>() {
        }, call));
    }

    /**
     * 积分商城商品详情
     *
     * @param id
     * @param call
     */
    public static void getJiFenGoodsDetail(int id, OnRequestSubscribe<BaseBean<JiFenGoodsDetailBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.JIFENXIANGQING;
        Api.post(url, MapUtils.create().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<JiFenGoodsDetailBean>>() {
        }, call));
    }

    /**
     * 积分商城红包详情
     *
     * @param id
     * @param call
     */
    public static void getJiFenHongBaoDetail(int id, OnRequestSubscribe<BaseBean<JiFenHongBaoDetailBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.HONGBAOXIANGQING;
        Api.post(url, MapUtils.create().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<JiFenHongBaoDetailBean>>() {
        }, call));
    }

    /**
     * 积分商城确认订单
     *
     * @param id
     * @param call
     */
    public static void getJiFenOrder(int id, OnRequestSubscribe<BaseBean<JiFenOrderBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.QUERENDINGDAN;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<JiFenOrderBean>>() {
        }, call));
    }

    //查询是否有默认收货地址  1 是 2不是
    public static void deaftaddressList(int hot, OnRequestSubscribe<BaseBean<List<AddressEntity>>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ADDRESS + Constans.Action.ADDRESS_LIST;
        Api.post(url, MapUtils.createToken().putBody("hot", hot), new BaseCallBack<>(new TypeToken<BaseBean<List<AddressEntity>>>() {
        }, call));
    }

    /**
     * 提交积分商城订单
     *
     * @param id
     * @param liuyan
     * @param postid
     * @param call
     */
    public static void postJiFenOrder(int id, @Nullable String liuyan, String postid, OnRequestSubscribe<BaseBean<JiFenPostOrderBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.JIFENDINGDANZHIFU;
        MapUtils mapUtils = MapUtils.createToken();
        if (liuyan != null && !liuyan.equals("")) {
            mapUtils.putBody("liuyan", liuyan);
        }
        Api.post(url, mapUtils.putBody("id", id).putBody("postid", postid), new BaseCallBack<>(new TypeToken<BaseBean<JiFenPostOrderBean>>() {
        }, call));
    }

    /**
     * 兑换红包支付
     *
     * @param id
     * @param pwd
     * @param call
     */
    public static void getJiFenHongBaoPay(int id, String pwd, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.HONGBAODUIHUAN;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("pwd", pwd), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 积分商城三方支付
     *
     * @param ordersn
     * @param type
     * @param call
     */
    public static void payJiFenOreder(String ordersn, String type, OnRequestSubscribe<BaseBean<PayBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.XUXIANJINZHIFU;
        Api.post(url, MapUtils.createToken().putBody("ordersn", ordersn).putBody("type", type), new BaseCallBack<>(new TypeToken<BaseBean<PayBean>>() {
        }, call));
    }

    /**
     * 积分商城余额支付
     *
     * @param ordersn
     * @param pwd
     * @param call
     */
    public static void payJiFenOrederByYue(String ordersn, String pwd, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.YUEZHIFU;
        Api.post(url, MapUtils.createToken().putBody("ordersn", ordersn).putBody("pwd", pwd), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 积分商城 单积分支付
     *
     * @param ordersn
     * @param pwd
     * @param call
     */
    public static void payJiFenOrederByJiFen(String ordersn, String pwd, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.DANJIFENZHIFU;
        Api.post(url, MapUtils.createToken().putBody("ordersn", ordersn).putBody("pwd", pwd), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 积分商城 订单详情
     *
     * @param id
     * @param call
     */
    public static void getJiFenOrderDetails(int id, OnRequestSubscribe<BaseBean<JiFenOrderDetailsBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.JIFENDINGDANXQ;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<JiFenOrderDetailsBean>>() {
        }, call));
    }

    /**
     * 积分商城取消订单
     *
     * @param id
     * @param call
     */
    public static void canalJiFenOrder(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.QUXIAODINGDAN;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 积分商城确认收货
     *
     * @param id
     * @param call
     */
    public static void suerGetGoodsJiFen(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.CONFIRMRECEIPT;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 查看物流 积分商城
     *
     * @param id
     * @param call
     */
    public static void chaKanWuLiuByJiFEN(int id, OnRequestSubscribe<BaseBean<ChaKanWuLiuBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INTEGRAL + Constans.Action.CHAKANWULIUJIFEN;
        Api.post(url, MapUtils.create().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<ChaKanWuLiuBean>>() {
        }, call));
    }

    /**
     * 校验档期是否满足
     *
     * @param baojiaid
     * @param baojiatime
     * @param baojiadate
     * @param call
     */
    public static void chaDangQi(int baojiaid, int baojiatime, String baojiadate, int userid, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.NOWWEDDINGORDER + Constans.Action.CHADANGQI;
        Api.post(url, MapUtils.createToken().putBody("baojiaid", baojiaid).putBody("baojiatime", baojiatime).putBody("baojiadate", baojiadate), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 删除宾客祝福，赴宴，待定
     *
     * @param id
     * @param call
     */
    public static void delZhuFu(int id, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.DELZHUFU;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }

    /**
     * 获取礼金列表
     *
     * @param id
     * @param p
     * @param rows
     * @param call
     */
    public static void getLiJing(int id, int p, int rows, OnRequestSubscribe<BaseBean<LiJingBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.LIJING;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("p", p).putBody("rows", rows), new BaseCallBack<>(new TypeToken<BaseBean<LiJingBean>>() {
        }, call));
    }

    /**
     * 从模板获取模板信息
     *
     * @param id
     * @param call
     */
    public static void getQingJianInfoByMuBan(int id, OnRequestSubscribe<BaseBean<QingJianInfoBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.INVITATIONSCREATEYI;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<QingJianInfoBean>>() {
        }, call));
    }

    /**
     * 从我的获取模板信息
     *
     * @param id
     * @param call
     */
    public static void getQingJianInfoByMine(int id, OnRequestSubscribe<BaseBean<QingJianInfoBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.EDITINVITATION;
        Api.post(url, MapUtils.createToken().putBody("id", id), new BaseCallBack<>(new TypeToken<BaseBean<QingJianInfoBean>>() {
        }, call));
    }


    /**
     * 保存电子请柬信息
     *
     * @param umid
     * @param appdata
     * @param call
     */
    public static void saveQingJianInfo(int umid, String appdata, int type, OnRequestSubscribe<BaseBean<String>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.INVITATIONSCREATEER;
        Api.post(url, MapUtils.createToken().putBody("umid", umid).putBody("appdata", appdata).putBody("type", type), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, call));
    }

    public static void saveQingJianShareInfo(int id, String sharecover, String sharedescribe, String sharetitle, OnRequestSubscribe<BaseBean<String>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.INVITATION + Constans.Action.SAVESHARE;
        Api.post(url, MapUtils.createToken().putBody("id", id).putBody("sharecover", sharecover).putBody("sharedescribe", sharedescribe).putBody("sharetitle", sharetitle), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, call));
    }

    /**
     * 获取活动投票地址
     *
     * @param call
     */
    public static void getTouPiaoUrl(OnRequestSubscribe<BaseBean<String>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.ACTIVITY + Constans.Action.HUODONG;
        Api.post(url, MapUtils.create(), new BaseCallBack<>(new TypeToken<BaseBean<String>>() {
        }, call));
    }

    /**
     * 店铺是否上下线
     *
     * @param call
     */
    public static void shopIsOnLine(OnRequestSubscribe<BaseBean<OnLineBean>> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.SHOPONLINESTATUS;
        Api.post(url, MapUtils.createToken(), new BaseCallBack<>(new TypeToken<BaseBean<OnLineBean>>() {
        }, call));
    }

    /**
     * 店铺上线
     *
     * @param on
     * @param call
     */
    public static void shopOnLine(int on, OnRequestSubscribe<BaseBean> call) {
        String url = Constans.SERVER_HOST2 + Constans.Type.LOGIN + Constans.Action.SHOPONLINE;
        Api.post(url, MapUtils.createToken().putBody("on", on), new BaseCallBack<>(new TypeToken<BaseBean>() {
        }, call));
    }
}
