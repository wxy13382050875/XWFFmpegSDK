//
//  XWPicewiseCell.m
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/11.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import "XWPicewiseCell.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>

@interface XWPicewiseCell ()
@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,strong)UIButton* delBtn;
@end
@implementation XWPicewiseCell
- (void)layoutSubviews {
    // 一定要调用super的方法
    [super layoutSubviews];
    //布局
}
-(void)xw_setupUI{
    [self addSubview:self.imageView];
    [self addSubview:self.delBtn];
    [self xw_updateConstraints];
}
-(void)xw_updateConstraints{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
        make.left.top.equalTo(self).offset(10);
        make.right.bottom.equalTo(self).offset(-10);
    }];
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}
-(void)setIsBegin:(BOOL)isBegin{
    self.delBtn.hidden = !isBegin;
}

-(void)setModel:(XWImagePickerModel *)model{
    self.imageView.image = model.image;
}

#pragma make 懒加载
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
//        _imageView.backgroundColor = [UIColor blackColor];
        
    }
    return _imageView;
}
-(UIButton*)delBtn{
    if (!_delBtn) {
        _delBtn = [UIButton new];
        [_delBtn setImage:IMG(@"white_close") forState:UIControlStateNormal];
        [_delBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _delBtn.hidden = YES;
    }
    return _delBtn;
}
-(void)buttonClick:(UIButton*)sender{
    
    
}

@end
