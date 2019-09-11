//
//  XWFfmpegUtil.h
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/4.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mobileffmpeg/mobileffmpeg.h>
#import <mobileffmpeg/MobileFFmpegConfig.h>
NS_ASSUME_NONNULL_BEGIN



typedef NS_ENUM(NSInteger, XWLogLevel) {
    XWLogLevel_LOG_QUIET = -8,//没有打印输出
    XWLogLevel_LOG_PANIC = 0,//出了严重的问题，崩溃信息。
    XWLogLevel_LOG_FATAL = 8,//致命信息
    XWLogLevel_LOG_ERROR = 16,//错误信息
    XWLogLevel_LOG_WARNING = 24,//警告信息
    XWLogLevel_LOG_INFO = 32,//标准信息。
    XWLogLevel_LOG_VERBOSE = 40,//详细的信息。
    XWLogLevel_LOG_DEBUG = 48,//只对libav开发人员有用的东西。
};

@interface XWFfmpegUtil : NSObject

+(instancetype)getInstance;
//设置日志级别
- (void)setLogLevel: (XWLogLevel)level;

-(void)executeFFmpeg:(NSString *)ffmpegCommand
         logCallback:(void (^)(int level, NSString * _Nonnull message))logBlock
            progress:(void (^)(Statistics * _Nonnull statistics))progressBlock
             success:(void (^)(NSString * _Nonnull output))successBlock
             failure:(void (^)(NSString * _Nonnull error))failureBlock;


@end

NS_ASSUME_NONNULL_END
