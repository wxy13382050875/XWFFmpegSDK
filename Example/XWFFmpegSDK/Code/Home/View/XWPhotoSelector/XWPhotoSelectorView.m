//
//  XWPhotoSelectorView.m
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/3.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import "XWPhotoSelectorView.h"
#import "XWPhotoSelectorCell.h"
#import "TZImagePickerController.h"
@interface XWPhotoSelectorView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@end
@implementation XWPhotoSelectorView
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
-(void)xw_initData{
    self.dataSource = @[].mutableCopy;
    self.lineNumber = 3;
    self.lineSpacing = 5;
    self.photoScrollDirection = XWPhotoScrollDirectionHorizontal;
    self.showAddImagesButton = YES;
    self.showingDeleteButton = NO;
    self.allowLongPressEditPhoto = NO;
    self.maxImagesCount = 0;
}
-(void)xw_setupUI{
    [self addSubview:self.collectionView];
    [self xw_updateConstraints];
}
-(void)xw_updateConstraints{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

//设置滚动方式
- (void)setPhotoScrollDirection:(XWPhotoScrollDirection)photoScrollDirection
{
    //水平滚动
    if (photoScrollDirection == XWPhotoScrollDirectionHorizontal) {
        self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.layout.itemSize = CGSizeMake(self.bounds.size.height, self.bounds.size.height);
        [self.collectionView setCollectionViewLayout:self.layout];
        
        //竖直滚动
    } else if (photoScrollDirection == XWPhotoScrollDirectionVertical) {
        self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.layout.minimumLineSpacing = _lineSpacing;
        self.layout.minimumInteritemSpacing = 0;
        self.layout.sectionInset = UIEdgeInsetsMake(0, _lineSpacing, _lineSpacing, _lineSpacing);
        self.layout.itemSize =
        CGSizeMake((self.bounds.size.width - (_lineNumber + 1) * _lineSpacing) / _lineNumber, (self.bounds.size.width - (_lineNumber + 1) * _lineSpacing) / _lineNumber);
        NSLog(@"%@",NSStringFromCGSize(self.layout.itemSize));
        [self.collectionView setCollectionViewLayout:self.layout];
    }
}
//显示增加按钮
- (void)setShowAddImagesButton:(BOOL)showAddImagesButton
{
    if (showAddImagesButton ) {
        //增加最后一张“添加”图片
        [_dataSource addObject:@"DPPhoto_library_more"];
    }
    _showAddImagesButton = showAddImagesButton;
}
#pragma mark - collection view
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XWPhotoSelectorCell __weak *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XWPhotoSelectorCell class]) forIndexPath:indexPath];
    cell.photo =self.dataSource[indexPath.row];
    
    if (_showingDeleteButton) {
        cell.showDeleteButton = YES;
        if (indexPath.row == _dataSource.count - 1 && _showAddImagesButton) {
            cell.showDeleteButton = NO;
        }
    } else {
        cell.showDeleteButton = NO;
    }
    //长按编辑
    if (_allowLongPressEditPhoto) {
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration = 1.0;
        [cell addGestureRecognizer:longPress];
    }
    //点击删除回调
    cell.deleteButtonClickBlock = ^{
        if ([self.delegate respondsToSelector:@selector(deletedPhotoAtIndex:)]) {
            [self.delegate deletedPhotoAtIndex:indexPath.row];
        }
        
        if ([self.delegate respondsToSelector:@selector(deletedPhotoAtIndex:withCurrentDataSource:)]) {
            [self.delegate deletedPhotoAtIndex:indexPath.row withCurrentDataSource:_dataSource];
        }
        
        NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
        [_dataSource removeObjectAtIndex:indexPath.row];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
        if (self.dataSource.count  < self.maxImagesCount) {
            if (!self.showAddImagesButton) {
                self.showAddImagesButton = YES;
            }
            
            
        }
        [_collectionView reloadData];
        
    };
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataSource.count - 1 && self.showAddImagesButton) {
        
        if ([self.delegate respondsToSelector:@selector(addPhotoImage:)]) {
            [self.delegate addPhotoImage:indexPath.row];
        }
        
    } else {
        if ([self.delegate respondsToSelector:@selector(showPhotoAtIndex:withCurrentDataSource:)]) {
            [self.delegate showPhotoAtIndex:indexPath.row withCurrentDataSource:_dataSource];
        }
    }
        
        
}

- (void)longPress:(UILongPressGestureRecognizer *)gesture
{
    if (!_showingDeleteButton) {
        [self startEditPhoto];
    }
}

- (void)autoEditPhoto
{
    if (_showingDeleteButton) {
        _showingDeleteButton = NO;
    } else {
        _showingDeleteButton = YES;
    }
    [self.collectionView reloadData];
}
//开启编辑图片
- (void)startEditPhoto
{
    _showingDeleteButton = YES;
    [_collectionView reloadData];
}

//结束编辑
- (void)endEditPhoto
{
    _showingDeleteButton = NO;
    [_collectionView reloadData];
}

-(void)reloadData:(NSArray *)array{

    
    self.dataSource = array.mutableCopy;
    if (self.maxImagesCount == 0) {
        self.showAddImagesButton = YES;
    } else {
     
        if (self.dataSource.count  < self.maxImagesCount) {
            self.showAddImagesButton = YES;
            
        } else {
            self.showAddImagesButton = NO;
        }
    }
    [self.collectionView reloadData];
}

#pragma make 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];

        _collectionView.backgroundColor = [UIColor whiteColor];
        //顶部四个按钮
        [_collectionView registerClass:[XWPhotoSelectorCell class] forCellWithReuseIdentifier:NSStringFromClass([XWPhotoSelectorCell class])];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        
        
    }
    return _collectionView;
}
-(UICollectionViewFlowLayout*)layout{
    if(!_layout){
        _layout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _layout;
}
@end
