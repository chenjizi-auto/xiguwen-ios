platform :ios, '16.4'

nim_sdk_version = '= 10.9.71'
nim_uikit_version = '~> 10.9.11'

target 'xiguwen' do

#pod 'XLJScreenMatchings'

  # 平台
  
  pod 'UMShare/UI', '6.11.1'
  pod 'UMShare/Social/ReducedWeChat', '6.11.1'
  pod 'UMShare/Social/QQ', '6.11.1'
  pod 'UMShare/Social/Sina', '6.11.1'

  pod 'NIMSDK_LITE', nim_sdk_version
  pod 'NECommonUIKit'
  pod 'NEChatKit', nim_uikit_version
  pod 'NEConversationUIKit', nim_uikit_version
  pod 'NEContactUIKit', nim_uikit_version
  pod 'NEChatUIKit', nim_uikit_version
  pod 'AMapLocation', '~> 2.4.0'
  pod 'AMapSearch', '~> 5.2.1'
  pod 'AMap2DMap', '~> 5.6.0'
  pod 'BmobSDK', '~> 2.4.1'
  pod 'WechatOpenSDK', '2.0.5'
  pod 'JPush', '6.0.0'
  pod 'AlipaySDK-iOS', '15.8.30'
  pod 'UPPaymentControl', '3.3.15'
  pod 'YXAlog', '1.0.7'

  # 三方库
  
  pod 'AFNetworking', '~> 3.1.0'
  pod 'TTTAttributedLabel', '~> 2.0.0'
  pod 'MJRefresh', '~> 3.7.5'
  pod 'IQKeyboardManager', '~> 4.0.9'
  pod 'Reachability', '~> 3.1.1'
  pod 'CocoaLumberjack', '~> 3.0'
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
  pod 'SDWebImage', '~> 5.5'
  pod 'TZImagePickerController'
  pod 'QMUIKit', '~> 4.8'
  pod 'RDVTabBarController'
  pod 'BMPlayer', '~> 1.3.0'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.4'
        config.build_settings['CLANG_ENABLE_EXPLICIT_MODULES'] = 'NO'
        config.build_settings['SWIFT_ENABLE_EXPLICIT_MODULES'] = 'NO'
      end
    end

    installer.aggregate_targets.each do |aggregate_target|
      aggregate_target.user_project.native_targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['CLANG_ENABLE_EXPLICIT_MODULES'] = 'NO'
          config.build_settings['SWIFT_ENABLE_EXPLICIT_MODULES'] = 'NO'
        end
      end
    end

    frameworks_script = installer.sandbox.root + 'Target Support Files/Pods-xiguwen/Pods-xiguwen-frameworks.sh'
    if File.exist?(frameworks_script)
      script = File.read(frameworks_script)

      unless script.include?('strip_bitcode()')
        strip_bitcode_function = <<~'SCRIPT'
          BITCODE_STRIP="$(xcrun --find bitcode_strip)"

          strip_bitcode() {
            local binary="$1"
            if ! [ -f "$binary" ]; then
              return
            fi
            if otool -l "$binary" | grep -q "__LLVM"; then
              echo "Stripping bitcode from $binary"
              "$BITCODE_STRIP" "$binary" -r -o "$binary"
            fi
          }

        SCRIPT

        script.sub!(/BCSYMBOLMAP_DIR="BCSymbolMaps"\n\n/, "BCSYMBOLMAP_DIR=\"BCSymbolMaps\"\n\n#{strip_bitcode_function}")
        script.sub!(/strip_invalid_archs "\$binary"\n  fi\n\n  # Resign the code/m, "strip_invalid_archs \"$binary\"\n  fi\n\n  strip_bitcode \"$binary\"\n\n  # Resign the code")

        File.write(frameworks_script, script)
      end
    end

  end
  
end
