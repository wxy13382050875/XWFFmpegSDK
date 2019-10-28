//
//  XWPiecewiseControls.m
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/11.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import "XWPiecewiseControls.h"
#import "XWPicewiseCell.h"
#import "XWPiecewiseReusableView.h"
#import "XWDragCellCollectionView.h"
@interface XWPiecewiseControls ()<XWDragCellCollectionViewDataSource, XWDragCellCollectionViewDelegate>
@property (nonatomic, strong) XWDragCellCollectionView  *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end
@implementation XWPiecewiseControls
- (void)layoutSubviews {
    // 一定要调用super的方法
    [super layoutSubviews];
    //布局
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)xw_setupUI{
    [self addSubview:self.collectionView];
    [self xw_updateConstraints];
}
-(void)xw_updateConstraints{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
-(void)xw_initData{
    
}
-(void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
    
    
}
#pragma mark - <XWDragCellCollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    NSArray *sec = self.dataSource[section];
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XWPicewiseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XWPicewiseCell class]) forIndexPath:indexPath];
    
    cell.model = self.dataSource[indexPath.section];
    return cell;
}

- (NSArray *)dataSourceArrayOfCollectionView:(XWDragCellCollectionView *)collectionView{
    return self.dataSource;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    XWPiecewiseReusableView *View = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([XWPiecewiseReusableView class]) forIndexPath:indexPath];
    
    View.addMaterialBlock = ^{
        if (self.openPhotoAlbumBlock) {
            
            NSLog(@"section = %ld row = %ld kind = %@" ,indexPath.section,indexPath.row,kind);
            self.openPhotoAlbumBlock(indexPath);
        }
    };
    return View;

    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.bounds.size.height * 16 / 9, self.bounds.size.height);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.frame.size.height, self.frame.size.height);
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == self.dataSource.count) {
        return CGSizeMake(self.frame.size.height, self.frame.size.height);
    } else {
        return CGSizeZero;
    }
    
}
#pragma mark - <XWDragCellCollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    XWImagePickerModel *model = self.dataSource[indexPath.section][indexPath.item];
//    NSLog(@"点击了%@",model.title);
}

- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray{
    self.dataSource = newDataArray.mutableCopy;
}

- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView cellWillBeginMoveAtIndexPath:(NSIndexPath *)indexPath{
    //拖动时候最后禁用掉编辑按钮的点击
//    _editButton.enabled = NO;
//    [collectionView xw_enterEditingModel];
}

- (void)dragCellCollectionViewCellEndMoving:(XWDragCellCollectionView *)collectionView{
//    _editButton.enabled = YES;
//    [collectionView xw_stopEditingModel];
}
- (NSArray<NSIndexPath *> *)excludeIndexPathsWhenMoveDragCellCollectionView:(XWDragCellCollectionView *)collectionView{
    //每个section的最后一个cell都不能交换
//    NSMutableArray * excluedeIndexPaths = [NSMutableArray arrayWithCapacity:self.data.count];
//    [self.data enumerateObjectsUsingBlock:^(NSArray*  _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
//        [excluedeIndexPaths addObject:[NSIndexPath indexPathForItem:0 inSection:idx]];
//    }];
    return nil;
}

#pragma make 懒加载
- (XWDragCellCollectionView *)collectionView {
    if (!_collectionView) {
        
        _collectionView = [[XWDragCellCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        //顶部四个按钮
        [_collectionView registerClass:[XWPicewiseCell class] forCellWithReuseIdentifier:NSStringFromClass([XWPicewiseCell class])];
        [_collectionView registerClass:[XWPiecewiseReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([XWPiecewiseReusableView class])];
        [_collectionView registerClass:[XWPiecewiseReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([XWPiecewiseReusableView class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.shakeLevel = 3.0f;
        _collectionView.isDragSection = YES;
//        _collectionView.edgeScrollEable = NO;
        
    }
    return _collectionView;
}
-(UICollectionViewFlowLayout*)layout{
    if(!_layout){
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        NSLog(@"CGSize = %@",NSStringFromCGSize(self.bounds.size));
        
    }
    return _layout;
}
@end
