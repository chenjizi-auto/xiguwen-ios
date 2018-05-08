//
//  HunlyinAddressViewController.m
//  BoYi
//
//  Created by 陈伟 on 2018/4/17.
//  Copyright © 2018年 hengwu. All rights reserved.
//

#import "HunlyinAddressViewController.h"
#import <AMap2DMap/MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface HunlyinAddressViewController ()<AMapSearchDelegate,MAMapViewDelegate>
@property (strong,nonatomic) AMapSearchAPI *search;
@property (strong,nonatomic) MAMapView *mapView;
@end

@implementation HunlyinAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.address;
    [self addPopBackBtn];
    
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = self.address;
    [self.search AMapGeocodeSearch:geo];
    [NavigateManager showLoadingMessage:@"加载中..."];
    
    
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:_mapView];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0)
    {
        [NavigateManager showMessage:@"没有找到该位置"];
        return;
    }
    [NavigateManager hiddenLoadingMessage];
    //解析response获取地理信息，具体解析见 Demo
     AMapGeoPoint *point = response.geocodes.firstObject.location;
    [_mapView setZoomLevel:16 animated:YES];
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(point.latitude, point.longitude) animated:YES];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude);
    pointAnnotation.title = self.address;
    pointAnnotation.subtitle = self.address;
    
    [_mapView addAnnotation:pointAnnotation];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout = YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
        annotationView.selected = YES;
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}
@end
