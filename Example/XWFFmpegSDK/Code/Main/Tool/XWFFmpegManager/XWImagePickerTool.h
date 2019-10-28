//
//  XWImagePicker.h
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/10.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XWImagePickerModel : NSObject

@property (nonatomic, copy) NSURL* url;

@property (nonatomic, copy) UIImage *image;

@end


typedef NS_ENUM(NSInteger, XWImagePickerType) {
    XWImagePickerType_SingleVideo ,//单个视频
    XWImagePickerType_MultipleVideo ,//多个视频
    XWImagePickerType_Photo ,//图片
    XWImagePickerType_GifImage //Gif图片
};

NS_ASSUME_NONNULL_BEGIN

@interface XWImagePickerTool : NSObject

+(instancetype)getInstance;


-(void)openImagePicker:(XWImagePickerType)pickerType maxCount:(NSInteger)maxCount viewController:(UIViewController*) viewcontroller doneBlock:(void(^)(NSArray* items))doneBlock;


//打开相机
-(void)openCamera :(UIViewController*) viewcontroller isRecord:(BOOL)isRecord isCamear:(BOOL)isCamear doneBlock:(void(^)(NSArray* items))doneBlock;
@end

NS_ASSUME_NONNULL_END
