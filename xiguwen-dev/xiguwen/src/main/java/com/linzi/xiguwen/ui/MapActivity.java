package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import com.baidu.mapapi.map.BaiduMap;
import com.baidu.mapapi.map.BitmapDescriptor;
import com.baidu.mapapi.map.BitmapDescriptorFactory;
import com.baidu.mapapi.map.MapStatusUpdate;
import com.baidu.mapapi.map.MapStatusUpdateFactory;
import com.baidu.mapapi.map.MapView;
import com.baidu.mapapi.map.MarkerOptions;
import com.baidu.mapapi.map.OverlayOptions;
import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.core.SearchResult;
import com.baidu.mapapi.search.geocode.GeoCodeOption;
import com.baidu.mapapi.search.geocode.GeoCodeResult;
import com.baidu.mapapi.search.geocode.GeoCoder;
import com.baidu.mapapi.search.geocode.OnGetGeoCoderResultListener;
import com.baidu.mapapi.search.geocode.ReverseGeoCodeResult;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;

import butterknife.BindView;

public class MapActivity extends BaseActivity {

    private BaiduMap mBaiduMap;
    @BindView(R.id.map_view)
    MapView mMapView;
    private GeoCoder mSearch;
    
    public static void startActivity(Context context,String title, String city, String address){
        Intent intent = new Intent(context, MapActivity.class);
        intent.putExtra("title", title);
        intent.putExtra("city", city);
        intent.putExtra("address", address);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_map);
    }

    @Override
    protected void initData() {

        Intent intent = getIntent();
        String title = intent.getStringExtra("title");
        String city = intent.getStringExtra("city");
        String address = intent.getStringExtra("address");
        setTitle(title);
        setBack();
        mBaiduMap = mMapView.getMap();
        mSearch = GeoCoder.newInstance();
        mSearch.setOnGetGeoCodeResultListener(listener);

        mSearch.geocode(new GeoCodeOption()
                .city(city)
                .address(address));
        LoadDialog.showDialog(this);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        //在activity执行onDestroy时执行mMapView.onDestroy()，实现地图生命周期管理
        mSearch.destroy();
        mMapView.onDestroy();
    }

    @Override
    protected void onResume() {
        super.onResume();
        //在activity执行onResume时执行mMapView. onResume ()，实现地图生命周期管理
        mMapView.onResume();
    }

    @Override
    protected void onPause() {
        super.onPause();
        //在activity执行onPause时执行mMapView. onPause ()，实现地图生命周期管理
        mMapView.onPause();
    }


    OnGetGeoCoderResultListener listener = new OnGetGeoCoderResultListener() {

        public void onGetGeoCodeResult(GeoCodeResult result) {
            LoadDialog.CancelDialog();
            if (result == null || result.error != SearchResult.ERRORNO.NO_ERROR) {
                //没有检索到结果
                NToast.show("未搜索到结果！");
            } else {
                //定义Maker坐标点
                LatLng point = result.getLocation();
                //构建Marker图标
                BitmapDescriptor bitmap = BitmapDescriptorFactory
                        .fromResource(R.mipmap.icon_location);
                //构建MarkerOption，用于在地图上添加Marker
                OverlayOptions option = new MarkerOptions()
                        .position(point)
                        .icon(bitmap);
                //在地图上添加Marker，并显示
                mBaiduMap.addOverlay(option);
                MapStatusUpdate mapStatusUpdate = MapStatusUpdateFactory.newLatLngZoom(point, 12);
                mBaiduMap.setMapStatus(mapStatusUpdate);
            }
        }

        @Override

        public void onGetReverseGeoCodeResult(ReverseGeoCodeResult result) {

            if (result == null || result.error != SearchResult.ERRORNO.NO_ERROR) {
                //没有找到检索结果
            }

            //获取反向地理编码结果
        }
    };
}
