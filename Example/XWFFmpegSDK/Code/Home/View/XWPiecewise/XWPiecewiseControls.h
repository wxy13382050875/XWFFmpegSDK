//
//  XWPiecewiseControls.h
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/11.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import "XWBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWPiecewiseControls : XWBaseView
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) void(^openPhotoAlbumBlock)(NSIndexPath* indexPath);
@end

NS_ASSUME_NONNULL_END
