package com.linzi.xiguwen.utils.location;

import android.app.Application;

import com.baidu.location.BDAbstractLocationListener;
import com.baidu.location.BDLocation;
import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/22  13:13
 *
 * @author luyongjiang
 * @version 1.0
 */
public class LocationHelper implements CustomLocationListener.ReceiveLocation {

    private boolean isConfig = false;
    private Application mApplication;
    public LocationClient mLocationClient = null;
    private BDAbstractLocationListener myListener = new CustomLocationListener();
    private static Boolean LOCATION_ING = false;

    //BDAbstractLocationListener为7.2版本新增的Abstract类型的监听接口
//原有BDLocationListener接口暂时同步保留。具体介绍请参考后文中的说明
    private LocationHelper() {
        if (myListener instanceof CustomLocationListener) {
            ((CustomLocationListener) myListener).injectReceive(this);
        }
    }

    private void injectApplication(Application application) {
        isConfig = true;
        mApplication = application;
        init(application);

    }

    private void init(Application application) {

        mLocationClient = new LocationClient(application);
        //声明LocationClient类
        mLocationClient.registerLocationListener(myListener);
        //注册监听函数
        LocationClientOption option = new LocationClientOption();
        option.setIsNeedAddress(true);
        //可选，是否需要地址信息，默认为不需要，即参数为false
        //如果开发者需要获得当前点的地址信息，此处必须为true
        mLocationClient.setLocOption(option);
        //mLocationClient为第二步初始化过的LocationClient对象
        //需将配置好的LocationClientOption对象，通过setLocOption方法传递给LocationClient对象使用
        //更多LocationClientOption的配置，请参照类参考中LocationClientOption类的详细说明
    }


    private static class SingleHolder {
        private static LocationHelper INSTANCE = new LocationHelper();
    }

    public static LocationHelper initHelper(Application application) {
        if (!SingleHolder.INSTANCE.isConfig) {
            SingleHolder.INSTANCE.injectApplication(application);
        }
        return SingleHolder.INSTANCE;
    }

    public static LocationHelper getInstance() {
        if (!SingleHolder.INSTANCE.isConfig) {
            throw new RuntimeException("请在application里面配置helper");
        }
        return SingleHolder.INSTANCE;
    }

    public void scheduleLocation() {
        mLocationClient.start();
    }

    public static void requestLocation(CustomLocationListener.ReceiveLocation receiveLocation) {
        LocationHelper.getInstance().putSubscribe(receiveLocation);
        if (!LOCATION_ING) {
            synchronized (LocationHelper.class) {
                if (!LOCATION_ING) {
                    //---------------------------用来标记是否正在定位的---------------------------------
                    LOCATION_ING = true;
                    synchronized (LocationHelper.class) {
                        LocationHelper.getInstance().scheduleLocation();
                    }
                }
            }
        }

    }

    private Set<CustomLocationListener.ReceiveLocation> mReceiveLocations = new HashSet<>();


    private void putSubscribe(CustomLocationListener.ReceiveLocation receiveLocation) {
        LocationHelper.getInstance().mReceiveLocations.add(receiveLocation);
    }

    //---------------------------这里可以得到定位信息,得到了之后停止,避免重复定位---------------------------------
    @Override
    public void onLocation(BDLocation bdLocation) {
        mLocationClient.stop();
        //--------------------------给请求定位的标记---------------------------------
        LOCATION_ING = false;
        Iterator<CustomLocationListener.ReceiveLocation> iterator = mReceiveLocations.iterator();
        while (iterator.hasNext()) {
            //这里每次定位回调之后都自动释放回调,避免内存溢出
            CustomLocationListener.ReceiveLocation next = iterator.next();
            //注意定位信息可能会存在空的时候,如果存在空就自己判断下
            next.onLocation(bdLocation);
            iterator.remove();
        }
    }
}
