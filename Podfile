platform :ios, '16.4'

target 'BoYi' do

#pod 'XLJScreenMatchings'

  # 平台
  
  pod 'UMShare/UI'
  pod 'UMShare/Social/ReducedWeChat'
  pod 'UMShare/Social/QQ'
  pod 'UMShare/Social/Sina'

  pod 'NIMSDK_LITE', '~> 8.7.0'
  pod 'NIMKit', '~> 3.7.0'
  pod 'AMapLocation', '~> 2.4.0'
  pod 'AMapSearch', '~> 5.2.1'
  pod 'AMap2DMap', '~> 5.6.0'
  pod 'BmobSDK', '~> 2.4.1'
  pod 'WechatOpenSDK'

  # 三方库
  
  pod 'AFNetworking', '~> 3.1.0'
  pod 'TTTAttributedLabel', '~> 2.0.0'
  pod 'MJRefresh', '~> 3.1.12'
  pod 'IQKeyboardManager', '~> 4.0.9'
  pod 'Reachability', '~> 3.1.1'
  pod 'CocoaLumberjack', '~> 2.0.0-rc2'
  pod 'FMDB'
  pod 'SSZipArchive', '~> 1.2'
  pod 'MBProgressHUD', '~> 1.1.0'
  pod 'MJExtension', '~> 3.0.13'
  pod 'ReactiveObjC', '~> 3.0.0'
  pod 'SDAutoLayout', '~> 2.1.8'
  pod 'DZNEmptyDataSet', '~> 1.8.1'
  pod 'SGNavigationProgress', '~> 1.2'
  pod 'DOPDropDownMenu-Enhanced', '~> 1.0.0'
  pod 'WMPageController', '~> 2.4.0'
  pod 'FSCalendar', '~> 2.7.9'
  pod 'HCSStarRatingView', '~> 1.5'
  pod 'PPGetAddressBook', '~> 0.2.8'
  pod 'HMQRCodeScanner', '~> 1.0.6'
  pod 'SDWebImage', '~> 5.0.6'
  pod 'QMUIKit', '~> 4.8'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.4'
      end
    end
  end
  
end
