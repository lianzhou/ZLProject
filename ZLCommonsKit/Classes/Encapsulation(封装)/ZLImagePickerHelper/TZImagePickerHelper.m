//
//  TZImagePickerHelper.m
//  TZImagePickerControllerDemoZH
//
//  Created by ios on 2017/11/8.
//  Copyright © 2017年 zhoulian. All rights reserved.
//

#import "TZImagePickerHelper.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "TZImagePickerController.h"

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

#import "UIView+Alert.h"

#import "AppDelegate.h"

#import "VideoEditVC.h"

@interface TZImagePickerHelper()<UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *imagesURL;

@property (nonatomic, strong) NSMutableArray *selectedPhotos;

@property (nonatomic, strong) NSMutableArray *selectedAssets;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@property (nonatomic, assign) NSInteger tag;

/**
 是否裁剪框
 */
@property (nonatomic, assign) BOOL isCrop;

@property (nonatomic, weak) UIViewController *superViewController;

@property (nonatomic, assign) CGFloat compressionQuality;

@property (assign, nonatomic) BOOL showTakePhotoBtnSwitch;  ///< 允许拍照
@property (assign, nonatomic) BOOL showTakeVideoBtnSwitch;  ///< 允许拍视频
@property (assign, nonatomic) BOOL sortAscendingSwitch;     ///< 照片排列按修改时间升序
@property (assign, nonatomic) BOOL allowPickingVideoSwitch; ///< 允许选择视频
@property (assign, nonatomic) BOOL allowPickingImageSwitch; ///< 允许选择图片
@property (assign, nonatomic) BOOL allowPickingGifSwitch; //允许选择Gif
@property (assign, nonatomic) BOOL allowPickingOriginalPhotoSwitch; ///< 允许选择原图
@property (assign, nonatomic) BOOL showSheetSwitch; ///< 显示一个sheet,把拍照/拍视频按钮放在外面
@property (assign, nonatomic) NSInteger maxCount;  ///< 照片最大可选张数，设置为1即为单选模式
@property (assign, nonatomic) NSInteger columnNumber;
@property (assign, nonatomic) BOOL allowCropSwitch; //允许裁剪的时候，不能选原图和GIF
@property (assign, nonatomic) BOOL needCircleCropSwitch; //允许需要圆形裁剪框
@property (assign, nonatomic) BOOL allowPickingMuitlpleVideoSwitch; // 是否可以多选视频
@property (assign, nonatomic) BOOL showSelectedIndexSwitch;

@end

@implementation TZImagePickerHelper

/**
 打开手机图片库
 
 @param maxCount 张数
 @param isCrop 剪切
 @param isTakeVideo 视频
 @param superController UIViewController
 @param tag 标签
 */
- (void)showImagePickerControllerWithMaxCount:(NSInteger )maxCount
                                       isCrop:(BOOL)isCrop
                                  isTakeVideo:(BOOL)isTakeVideo
                       initWithViewController: (UIViewController *)superController
                                    selectTag:(NSInteger)tag {
    
    self.tag=tag;
    self.maxCount = maxCount;
    self.superViewController = superController;
    self.isCrop=isCrop;
    self.columnNumber=4;
    
    _showTakePhotoBtnSwitch = NO ;  ///< 允许拍照
    _showTakeVideoBtnSwitch = isTakeVideo ;  ///< 允许拍视频
    _allowPickingVideoSwitch = isTakeVideo ; ///< 允许选择视频
    _allowPickingImageSwitch  = !isTakeVideo ; ///< 允许选择图片
    
    _sortAscendingSwitch = YES ;     ///< 照片排列按修改时间升序
    _allowPickingGifSwitch  = NO ; //允许选择Gif
    _allowPickingOriginalPhotoSwitch = NO ; ///< 允许选择原图
    _showSheetSwitch = NO ; ///< 显示一个sheet,把拍照/拍视频按钮放在外面
    
    _allowCropSwitch = NO ; //允许裁剪的时候，不能选原图和GIF
    _needCircleCropSwitch = NO ; //允许需要圆形裁剪框
    _allowPickingMuitlpleVideoSwitch  = NO ; // 是否可以多选视频
    _showSelectedIndexSwitch = YES ;
    
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSString *takePhotoTitle = @"拍照";
    if (_showTakeVideoBtnSwitch) {
        takePhotoTitle = @"拍摄";
    }
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:takePhotoTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushTZImagePickerController];
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertCtrl addAction:albumAction];
    [alertCtrl addAction:photoAction];
    [alertCtrl addAction:cancleAction];
    [self.superViewController presentViewController:alertCtrl animated:YES completion:nil];
}


- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCount   columnNumber:self.columnNumber
                                                                                            delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = YES;
    
    if (self.maxCount > 1) {
        // 1.设置目前已经选中的图片数组
        //imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = self.showTakePhotoBtnSwitch; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = self.showTakeVideoBtnSwitch;   // 在内部显示拍视频按
    imagePickerVc.videoMaximumDuration = 59; // 视频最大拍摄时间
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    
    // imagePickerVc.photoWidth = 1000;
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    
    imagePickerVc.navigationBar.tintColor= [UIColor blackColor];
    imagePickerVc.navigationBar.barTintColor = [UIColor whiteColor];
    
    imagePickerVc.oKButtonTitleColorDisabled = [UIColor whiteColor];
    imagePickerVc.oKButtonTitleColorNormal = [UIColor whiteColor];
    imagePickerVc.naviTitleColor=[UIColor blackColor];
    imagePickerVc.barItemTextColor=[UIColor blackColor];
    
    
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    /*
     [imagePickerVc setAssetCellDidSetModelBlock:^(TZAssetCell *cell, UIImageView *imageView, UIImageView *selectImageView, UILabel *indexLabel, UIView *bottomView, UILabel *timeLength, UIImageView *videoImgView) {
     cell.contentView.clipsToBounds = YES;
     cell.contentView.layer.cornerRadius = cell.contentView.tz_width * 0.5;
     }];
     */
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = self.allowPickingVideoSwitch;
    imagePickerVc.allowPickingImage = self.allowPickingImageSwitch;
    imagePickerVc.allowPickingOriginalPhoto = self.allowPickingOriginalPhotoSwitch;
    imagePickerVc.allowPickingGif = self.allowPickingGifSwitch;
    imagePickerVc.allowPickingMultipleVideo = self.allowPickingMuitlpleVideoSwitch; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = self.sortAscendingSwitch;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = self.allowCropSwitch;
    imagePickerVc.needCircleCrop = self.needCircleCropSwitch;
    // 设置竖屏下的裁剪尺寸
    //    NSInteger left = 30;
    //    NSInteger widthHeight = SCREEN_WIDTH - 2 * left;
    //    NSInteger top = (SCREEN_WIDTH - widthHeight) / 2;
    //    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    // 设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake((self.view.tz_height - widthHeight) / 2, left, widthHeight, widthHeight);
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
    // 自定义导航栏上的返回按钮
    /*
     [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
     [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
     [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
     }];
     imagePickerVc.delegate = self;
     */
    
    // Deprecated, Use statusBarStyle
    // imagePickerVc.isStatusBarDefault = NO;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = self.showSelectedIndexSwitch;
    
    // 设置首选语言 / Set preferred language
    imagePickerVc.preferredLanguage = @"zh-Hans";
    
    // 设置languageBundle以使用其它语言 / Set languageBundle to use other language
    // imagePickerVc.languageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"tz-ru" ofType:@"lproj"]];
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
    }];
    [self.superViewController presentViewController:imagePickerVc animated:YES completion:nil];
}

/**
 拍照
 */
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        [self showAlertWithTitle:@"提示" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机"];
        
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else {
        [self takeCamera];
    }
}

// 调用相机
- (void)takeCamera{
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        if (self.showTakeVideoBtnSwitch) {
            ipc.mediaTypes = @[( NSString *)kUTTypeMovie];
            ipc.videoMaximumDuration = 59;
        }
        
        [ipc setSourceType:UIImagePickerControllerSourceTypeCamera];
        ipc.delegate = self;
        ipc.allowsEditing = YES;
        ipc.modalPresentationStyle=UIModalPresentationOverCurrentContext; 
        
        AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        appdelegate.window.rootViewController.definesPresentationContext = YES;
        [appdelegate.window.rootViewController presentViewController:ipc  animated:YES completion:nil];
        
        // [self.superViewController presentViewController:ipc animated:YES completion:nil];
        
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alerCtrl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:alerCtrl.message];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentLeft;
    [alertControllerMessageStr setAttributes:@{NSParagraphStyleAttributeName:paragraph,NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(0, alertControllerMessageStr.length)];
    [alerCtrl setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alerCtrl addAction:action];
    [alerCtrl addAction:action2];
    [self.superViewController presentViewController:alerCtrl animated:YES completion:nil];
}
#pragma mark - TZImagePickerControllerDelegate

// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.superViewController.view showHUDWithText:@"处理中..."];
        });
        
        for (int i = 0; i<photos.count; i++) {
            UIImage *image = photos[i];
            // 1. 处理图片
            image = [self imageProcessing:image];
            // 2. 写入缓存
            NSString *filePath = [self imageDataWriteToFile:image];
            // 3. 加入数组、返回数组、重置数组
            [self.imagesURL addObject:filePath];
        }
        
        self.finish(self.tag,self.imagesURL);
        self.imagesURL = nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.superViewController.view hideHUD];
        });
        
    });
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

//选择本地视频
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset{
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.superViewController.view showHUDWithText:@"处理中..."];
        });
        
        [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPreset640x480 success:^(NSString *outputPath) {
            NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
            // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
            [self videoOutput:[NSURL URLWithString: [NSString stringWithFormat:@"file:///private/%@",outputPath]]  show:NO];
            
        } failure:^(NSString *errorMessage, NSError *error) {
            NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.superViewController.view hideHUD];
                [self.superViewController.view showHubMsg:@"请重新选择视频"];
            });
        }];
    });
}

#pragma mark -- UIImagePickerControllerDelegate 拍摄完成处理

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    if ([picker.mediaTypes containsObject:(NSString *)kUTTypeImage]){
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.superViewController.view showHUDWithText:@"处理中..."];
            });
            // 原图/编辑后的图片
            // UIImagePickerControllerOriginalImage/UIImagePickerControllerEditedImage
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            // 1. 处理图片
            image = [self imageProcessing:image];
            // 2. 写入缓存
            NSString *filePath = [self imageDataWriteToFile:image];
            // 3. 加入数组、返回数组、重置数组
            [self.imagesURL addObject:filePath];
            self.finish(self.tag,self.imagesURL);
            self.imagesURL = nil;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.superViewController.view hideHUD];
            });
        });
    }
    
    if ([picker.mediaTypes containsObject:(NSString *)kUTTypeMovie]) {
        
        NSURL *pathUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        [self videoOutput:pathUrl show:YES] ;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 内部方法
//处理小视频59秒
-(void)videoOutput:(NSURL *)pathUrl show:(BOOL)show{
    NSLog(@"%@",pathUrl);
    AVURLAsset * asset = [AVURLAsset assetWithURL:pathUrl];
    double lenght = CMTimeGetSeconds(asset.duration);
   
    if (lenght > 59.0) {
        lenght = 59.0;
//        VideoEditVC *vc=VideoEditVC.new;
//        vc.videoUrl=pathUrl;
//        [self.superViewController presentViewController:vc animated:YES completion:^{   }];
//        return;
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if(show){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.superViewController.view showHUDWithText:@"处理中..."];
                });
            } 
            
            [self cutVideoWithAsset:asset captureVideoWithRange:[self getTimeRange:0 lenght:lenght scale:asset.duration.timescale] completion:^(NSURL * _Nonnull outputUrl, long long fileSize, NSError * _Nonnull error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.superViewController.view hideHUD];
                });
                if (!error) {
                    NSData *data = [NSData dataWithContentsOfURL:outputUrl];
                    if (self.finishVoide) {
                        self.finishVoide(fileSize,[self getVideoImage:[outputUrl absoluteString]], data);
                    }
                }
                else{
                    NSLog(@"%@", error);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.superViewController.view hideHUD];
                        [self.superViewController.view showHubMsg:@"请重新选择视频"];
                    });
                }
            }];
        });
    }
    else {
        
        if(!show){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.superViewController.view hideHUD];
            });
        }
        
        NSData *data = [NSData dataWithContentsOfURL:pathUrl];
        if(self.finishVoide){
            self.finishVoide(lenght,[self getVideoImage:[pathUrl absoluteString]], data);
        }
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self.superViewController dismissViewControllerAnimated:YES completion:nil];
}



- (NSString *)imageDataWriteToFile:(UIImage *)image{
    NSData *data;
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/tmp/img-%d.jpg", arc4random()];
    NSLog(@"imageDataWriteToFile===%@",filePath);
    
    if (UIImagePNGRepresentation(image) == nil){
        data = [self imageCompressToData:image];//UIImageJPEGRepresentation(image, self.compressionQuality);
    }
    else{
        // 将PNG转JPG
        [UIImageJPEGRepresentation(image, self.compressionQuality) writeToFile:filePath atomically:YES];
        UIImage *jpgImage = [UIImage imageWithContentsOfFile:filePath];
        data = [self imageCompressToData:jpgImage];
        // data = UIImageJPEGRepresentation(jpgImage, self.compressionQuality);
    }
    
    [data writeToFile:filePath atomically:YES];
    return filePath;
}


#pragma mark --压缩图片
- (NSData *)imageCompressToData:(UIImage *)image{
    NSData *data=UIImageJPEGRepresentation(image, 1.0);
    if (data.length>300*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(image, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(image, 0.5);
        }else if (data.length>300*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(image, 0.9);
        }
    }
    return data;
}
#pragma mark --处理图片
/**
 处理图片
 
 @param image image
 @return return 新图片
 */
- (UIImage *)imageProcessing:(UIImage *)image{
    
    UIImageOrientation imageOrientation = image.imageOrientation;
    if (imageOrientation != UIImageOrientationUp){
        // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
        // 以下为调整图片角度的部分
        UIGraphicsBeginImageContext(image.size);
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 调整图片角度完毕
    }
    
    CGSize imagesize = image.size;
    //质量压缩系数
    self.compressionQuality = 1;
    
    //如果大于两倍屏宽 或者两倍屏高
    if (image.size.width > 640 || image.size.height > 568*2){
        self.compressionQuality = 0.5;
        //宽大于高
        if (image.size.width > image.size.height){
            imagesize.width = 320*2;
            imagesize.height = image.size.height*imagesize.width/image.size.width;
        }
        else{
            imagesize.height = 568*2;
            imagesize.width = image.size.width*imagesize.height/image.size.height;
        }
    }
    else{
        self.compressionQuality = 0.6;
    }
    
    // 对图片大小进行压缩
    UIImage *newImage = [self scaleImageSimple:image scaledToSize:imagesize];
    return newImage;
}

/**
 图片自适应UIImageView
 @param image image description
 @param newSize newSize description
 @return return value description
 */
- (UIImage*)scaleImageSimple:(UIImage*)image
                scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

- (BOOL)willDealloc {
    return NO;
}


-(UIImage *)getVideoImage:(NSString *)videoURL{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoURL] options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.1, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
}


#pragma mark -- 视屏裁剪

-(CMTimeRange)getTimeRange:(float)star lenght:(float)lenght scale:(CMTimeScale)timescale{
    CMTime duration = CMTimeMakeWithSeconds(lenght, timescale);
    CMTimeRange range = CMTimeRangeMake(kCMTimeZero, duration);
    return range;
}


-(void)cutVideoWithAsset:(AVURLAsset*)asset captureVideoWithRange:(CMTimeRange)videoRange completion:(void(^)(NSURL* outputUrl , long long fileSize,NSError * error))completionHandle{

    AVAssetExportSession *e = [[AVAssetExportSession alloc] initWithAsset:[asset copy] presetName:AVAssetExportPreset640x480];

    NSString *outputURL = [NSHomeDirectory() stringByAppendingFormat:@"/tmp/movie.mp4"];
    
    NSFileManager *manager = [NSFileManager defaultManager];

    [manager removeItemAtPath:outputURL error:nil];
    
    e.timeRange = videoRange;
    e.outputURL =  [NSURL fileURLWithPath:outputURL];
    e.outputFileType = AVFileTypeQuickTimeMovie;
    e.shouldOptimizeForNetworkUse = YES;
    [e exportAsynchronouslyWithCompletionHandler:^{
        switch (e.status) {
            case AVAssetExportSessionStatusCompleted:                completionHandle(e.outputURL,CMTimeGetSeconds(videoRange.duration),nil);
                break;
            case AVAssetExportSessionStatusFailed:
                completionHandle(nil,0,e.error);
                break;
            default:
                
                break;
        }
    }];
}

#pragma mark -- 懒加载

- (NSMutableArray *)imagesURL{
    if (!_imagesURL) {
        _imagesURL = [NSMutableArray array];
    }
    return _imagesURL;
}


@end
