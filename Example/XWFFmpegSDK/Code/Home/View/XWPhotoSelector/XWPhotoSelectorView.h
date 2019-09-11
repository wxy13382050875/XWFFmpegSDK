//
//  XWPhotoSelectorView.h
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/3.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import "XWBaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    XWPhotoScrollDirectionVertical,
    XWPhotoScrollDirectionHorizontal
} XWPhotoScrollDirection;

@protocol XWPhotoSelectorDelegate <NSObject>

@optional




/**
 添加图片
 
 @param index 预留
 */
- (void)addPhotoImage:(NSUInteger)index;

/**
 删除某个图片
 
 @param index 删除的位置
 */
- (void)deletedPhotoAtIndex:(NSUInteger)index;


/**
 删除某个图片
 
 @param index 删除位置
 @param dataSource 删除之前的数据源
 */
- (void)deletedPhotoAtIndex:(NSUInteger)index withCurrentDataSource:(NSMutableArray *)dataSource;

/**
 显示某个图片
 
 @param index 删除位置
 @param dataSource 删除之前的数据源
 */
- (void)showPhotoAtIndex:(NSUInteger)index withCurrentDataSource:(NSMutableArray *)dataSource;

@end




@interface XWPhotoSelectorView : XWBaseView

@property (nonatomic, weak) id <XWPhotoSelectorDelegate> delegate;

/**
 设置滚动方向
 
 default is DPPhotoScrollDirectionVertical
 */
@property (nonatomic, assign) XWPhotoScrollDirection photoScrollDirection;
/**
 每行cell个数
 
 default is 3
 */
@property (nonatomic, assign) NSUInteger lineNumber;
/**
 列间距
 
 default is 5
 */
@property (nonatomic, assign) CGFloat lineSpacing;

/**
 显示添加图片按钮
 
 default is NO
 */
@property (nonatomic, assign) BOOL showAddImagesButton;

/**
 是否显示删除按钮
 
 default is NO
 */
@property (nonatomic, assign) BOOL showingDeleteButton; //


/**
 是否允许长按编辑图片
 
 default is NO
 */
@property (nonatomic, assign) BOOL allowLongPressEditPhoto;
/**
 最大图片数
 
 default is 0
 */
@property (nonatomic, assign) NSInteger maxImagesCount;

-(void)reloadData:(NSArray*)array;


/**
 自动判断当前编辑状态,如果是未编辑就开启编辑,如果已开启编辑就结束编辑
 */
- (void)autoEditPhoto;

/**
 开始编辑
 */
- (void)startEditPhoto;


/**
 结束编辑
 */
- (void)endEditPhoto;
@end

NS_ASSUME_NONNULL_END
