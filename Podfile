workspace 'RDProject.xcworkspace'
project 'Project_OC/Project_OC.xcodeproj' 

#解决安装第三方库慢，更新第三方库慢得问题
#   pod install --verbose --no-repo-update
#   pod update --verbose --no-repo-update

platform :ios,'9.0'
#整个工程都用到了第三方库
def pods
    pod 'Aspects'
    pod 'MJRefresh'
    pod 'AFNetworking'
    pod 'YYKit'
    pod 'MBProgressHUD'
#    pod 'Masonry'  本地集成使用到了8.0 方法
    pod 'YTKNetwork'
    pod 'SDCycleScrollView' #包含 SDWebImage
    pod 'SDWebImage' 
    pod 'CocoaLumberjack'
    
    pod 'SWTableViewCell'
    # pod 'HMSegmentedControl'
    # pod 'HMQRCodeScanner' #扫一扫 二维码
    pod 'FDFullscreenPopGesture' #页面右滑动返回
    
    pod 'DZNEmptyDataSet'
    
    pod 'WechatOpenSDK'
    
    # 图片选择器
    pod 'TZImagePickerController'
    # 时间选择器
    pod 'PGDatePicker'
    
    
    #U-Push
    
    
end

target 'Project_OC' do
    pods
    # 添加本项目用使用第三方库
    project 'Project_OC/Project_OC.xcodeproj'
end




