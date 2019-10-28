//
//  XWImagePicker.m
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/10.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import "XWImagePickerTool.h"
#import "TZImagePickerController.h"
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZLocationManager.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation XWImagePickerModel
@end

static XWImagePickerTool *xwPicker = nil;

@interface XWImagePickerTool ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
@property (nonatomic, strong) TZImagePickerController *imagePickerVc;

@property (nonatomic, strong) UIImagePickerController *imagePickerCamera;
@property (nonatomic,copy) void(^doneBlock)(NSArray* items);
@end


@implementation XWImagePickerTool

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
+ (XWImagePickerTool*)getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xwPicker = [[XWImagePickerTool alloc]init];
        
    });
    return xwPicker;
}

-(void)openImagePicker:(XWImagePickerType)pickerType maxCount:(NSInteger)maxCount viewController:(UIViewController*) viewcontroller doneBlock:(void(^)(NSArray* items))doneBlock{
    self.imagePickerVc = nil;
    self.imagePickerVc.maxImagesCount = maxCount;
    switch (pickerType) {
        case XWImagePickerType_SingleVideo:
            self.imagePickerVc.allowPickingOriginalPhoto = NO;
            self.imagePickerVc.allowPickingVideo = YES;
            self.imagePickerVc.allowPickingImage = NO;
            self.imagePickerVc.allowTakePicture = NO;
            self.imagePickerVc.allowTakeVideo = NO;
            self.imagePickerVc.allowPickingMultipleVideo = NO;
            break;
        case XWImagePickerType_MultipleVideo:
            self.imagePickerVc.allowPickingOriginalPhoto = NO;
            self.imagePickerVc.allowPickingVideo = YES;
            self.imagePickerVc.allowPickingImage = NO;
            self.imagePickerVc.allowTakePicture = NO;
            self.imagePickerVc.allowTakeVideo = NO;
            self.imagePickerVc.allowPickingMultipleVideo = YES;
            break;
        case XWImagePickerType_Photo:
            self.imagePickerVc.allowPickingOriginalPhoto = YES;
            self.imagePickerVc.allowPickingVideo = NO;
            self.imagePickerVc.allowPickingImage = YES;
            self.imagePickerVc.allowTakePicture = YES;
            self.imagePickerVc.allowTakeVideo = NO;
            self.imagePickerVc.allowPickingMultipleVideo = NO;
            break;
        case XWImagePickerType_GifImage:
            self.imagePickerVc.allowPickingOriginalPhoto = NO;
            self.imagePickerVc.allowPickingVideo = NO;
            self.imagePickerVc.allowPickingImage = NO;
            self.imagePickerVc.allowTakePicture = NO;
            self.imagePickerVc.allowTakeVideo = NO;
            self.imagePickerVc.allowPickingGif = YES;
            self.imagePickerVc.allowPickingMultipleVideo = NO;
            break;
        default:
            break;
    }
    self.doneBlock = doneBlock;
    
    [viewcontroller presentViewController:self.imagePickerVc animated:YES completion:nil];
}

//打开相机
-(void)openCamera :(UIViewController*) viewcontroller isRecord:(BOOL)isRecord isCamear:(BOOL)isCamear doneBlock:(void(^)(NSArray* items))doneBlock{
    self.doneBlock = doneBlock;
//    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {

    } failureBlock:^(NSError *error) {
        
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerCamera.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        if (isRecord) {
            [mediaTypes addObject:(NSString *)kUTTypeMovie];
        }
        if (isCamear) {
            [mediaTypes addObject:(NSString *)kUTTypeImage];
        }
        if (mediaTypes.count) {
            self.imagePickerCamera.mediaTypes = mediaTypes;
        }
        [viewcontroller presentViewController:self.imagePickerCamera animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }

}


// 如果用户选择了一个视频且allowPickingMultipleVideo是NO，下面的代理方法会被执行
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset{
    NSLog(@"didFinishPickingVideo");
    [self assetConversionImagePath:@[asset] images:@[coverImage]];
}
//如果用户选择了一个gif图片且allowPickingMultipleVideo是NO，下面的代理方法会被执行
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(PHAsset *)asset{
    NSLog(@"didFinishPickingGifImage");
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    NSLog(@"didFinishPickingPhotos infos");

    [self assetConversionImagePath:assets images:photos];
    
}
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    NSLog(@"tz_imagePickerControllerDidCancel");
}

-(void)assetConversionImagePath:(NSArray *)assets images:(NSArray<UIImage *> *)photos{
    int __block index = 0;
    NSMutableArray* urls = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < assets.count; i++) {
        // 获取一个资源（PHAsset）
        PHAsset *phAsset = assets[i];
        if (phAsset.mediaType == PHAssetMediaTypeVideo) {
            PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
            options.version = PHImageRequestOptionsVersionCurrent;
            options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
            
            [[PHImageManager defaultManager] requestAVAssetForVideo:phAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                AVURLAsset *urlAsset = (AVURLAsset *)asset;
                
                XWImagePickerModel* model = [XWImagePickerModel new];
                model.url = urlAsset.URL;
                model.image = photos[i];
                [urls addObject:model];
                
                index ++;
                
                if (index == assets.count) {
                    self.doneBlock(urls);
                }
                //                NSLog(@"%@",data);
            }];
        } else if(phAsset.mediaType == PHAssetMediaTypeImage){
            [[PHImageManager defaultManager] requestImageForAsset:phAsset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                //                1.获取照片的url
                NSURL * url = [info objectForKey:@"PHImageFileURLKey"];
                //                2.获取视频的地址
                //
                XWImagePickerModel* model = [XWImagePickerModel new];
                model.url = url;
                model.image = photos[i];
                index ++;
                
                if (index == assets.count) {
                    self.doneBlock(urls);
                }
            }];
            
        }
        
        
    }
    
}
- (TZImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[TZImagePickerController alloc] init];
        _imagePickerVc.pickerDelegate = self;
        
        
    }
    return _imagePickerVc;
}

- (UIImagePickerController *)imagePickerCamera {
    if (_imagePickerCamera == nil) {
        _imagePickerCamera = [[UIImagePickerController alloc] init];
        _imagePickerCamera.delegate = self;

        
    }
    return _imagePickerCamera;
}
@end
