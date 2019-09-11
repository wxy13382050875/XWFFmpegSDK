//
//  XWPhotoSelectorCell.h
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/3.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import "XWBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DeleteButtonClickBlock)();

@interface XWPhotoSelectorCell : XWBaseCollectionViewCell
@property(nonatomic,strong)id photo;
@property (nonatomic, copy) DeleteButtonClickBlock deleteButtonClickBlock;
@property (nonatomic, assign) BOOL showDeleteButton;
@end

NS_ASSUME_NONNULL_END
