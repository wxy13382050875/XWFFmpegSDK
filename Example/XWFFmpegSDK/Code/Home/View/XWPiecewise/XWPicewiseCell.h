//
//  XWPicewiseCell.h
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/11.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import "XWBaseCollectionViewCell.h"
#import "XWImagePickerTool.h"
NS_ASSUME_NONNULL_BEGIN

@interface XWPicewiseCell : XWBaseCollectionViewCell
@property(nonatomic,strong)XWImagePickerModel* model;
/**是否抖动*/
@property (nonatomic,assign) BOOL isBegin;
@end

NS_ASSUME_NONNULL_END
