//
//  XWBaseView.h
//  PlayFC
//
//  Created by 武新义 on 2019/5/15.
//  Copyright © 2019 Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWBaseView : UIView
@property (nonatomic, copy) void (^buttonBlock)(NSInteger tag);//触摸事件
-(void)xw_initData;
-(void)xw_setupUI;
-(void)xw_updateConstraints;
@end

NS_ASSUME_NONNULL_END
