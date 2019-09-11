//
//  XWFfmpegUtil.m
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/4.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import "XWFfmpegUtil.h"

static XWFfmpegUtil *xwManager = nil;

@interface XWFfmpegUtil ()<LogDelegate,StatisticsDelegate>
@property (nonatomic,copy) void(^logBlock)(int, NSString * _Nonnull);
@property (nonatomic,copy) void(^progressBlock)(Statistics * _Nonnull);
@end
@implementation XWFfmpegUtil

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
+ (XWFfmpegUtil*)getInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xwManager = [[XWFfmpegUtil alloc]init];
        
    });
    return xwManager;
}
-(void)setLogLevel:(XWLogLevel)level{
    
    [MobileFFmpegConfig setLogLevel:level];
}


-(void)executeFFmpeg:(NSString *)ffmpegCommand
         logCallback:(void (^)(int level, NSString * _Nonnull message))logBlock
            progress:(void (^)(Statistics * _Nonnull statistics))progressBlock
             success:(void (^)(NSString * _Nonnull output))successBlock
             failure:(void (^)(NSString * _Nonnull error))failureBlock{
    
    [MobileFFmpegConfig setLogDelegate:(id<LogDelegate>)self];
    [MobileFFmpegConfig setStatisticsDelegate:(id<StatisticsDelegate>)self];
    
    self.logBlock = logBlock;
    self.progressBlock = progressBlock;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"FFmpeg 开始执行\n\'%@\'\n", ffmpegCommand);
        
        // EXECUTE
        int result = [MobileFFmpeg execute: ffmpegCommand];
        
        NSLog(@"FFmpeg 结束执行 %d\n", result);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result == RETURN_CODE_SUCCESS) {
                //                            [self dismissProgressDialog];
                NSLog(@"FFmpeg 执行成功; playing video.\n");
                successBlock([MobileFFmpeg getBuildDate]);
            } else {
                NSLog(@"FFmpeg 执行失败=%d\n", result);
                
                failureBlock([NSString stringWithFormat:@"FFmpeg 执行失败=%d\n", [MobileFFmpeg getLastReturnCode]]);
            }
        });
    });
}
-(void)logCallback:(int)level :(NSString *)message{
    self.logBlock(level, message);
}
-(void)statisticsCallback:(Statistics *)statistics{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressBlock(statistics);
    });
}

@end
