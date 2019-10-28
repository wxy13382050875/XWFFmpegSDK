//
//  XWStickersViewController.h
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/11.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import "XWBaseViewController.h"
#import "JXCategoryListContainerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface XWStickersViewController : XWBaseViewController<JXCategoryListContentViewDelegate>
@property (nonatomic, strong) UINavigationController *naviController;

@end

NS_ASSUME_NONNULL_END
