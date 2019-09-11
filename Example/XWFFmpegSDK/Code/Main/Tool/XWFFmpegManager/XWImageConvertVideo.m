//
//  XWImageConvertVideo.m
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/9.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import "XWImageConvertVideo.h"

@implementation XWImageConvertVideo

+ (NSString*)xw_imageTurnVideoForFile:(NSString*)inputPath outputFile:(NSString*)outputPath{
    
    return [NSString stringWithFormat:@"-f concat -safe 0 -i %@ -vsync vfr -pix_fmt yuv420p -y %@",inputPath,outputPath];
    
}
@end
