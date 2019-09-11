//
//  XWImageConvertVideo.h
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/9.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWImageConvertVideo : NSObject

+ (NSString*)xw_imageTurnVideoForFile:(NSString*)inputPath outputFile:(NSString*)outputPath;
@end

NS_ASSUME_NONNULL_END
