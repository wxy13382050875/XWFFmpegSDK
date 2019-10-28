//
//  XWPiecewiseReusableView.m
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/11.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import "XWPiecewiseReusableView.h"
@interface XWPiecewiseReusableView ()
@property(nonatomic,strong)UIButton* addMaterialBtn;
@end
@implementation XWPiecewiseReusableView
-(void)xw_setupUI{
    [self addSubview:self.addMaterialBtn];
    [self xw_updateConstraints];
}
-(void)xw_updateConstraints{
    [self.addMaterialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width/2, self.frame.size.height/2));
    }];
}
#pragma make 懒加载

-(UIButton*)addMaterialBtn{
    if (!_addMaterialBtn) {
        _addMaterialBtn = [UIButton new];
        [_addMaterialBtn setImage:[UIImage imageNamed:@"DPPhoto_library"] forState:UIControlStateNormal];
        [_addMaterialBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addMaterialBtn;
}
-(void)buttonClick:(UIButton *)sender{
    
    if (self.addMaterialBlock) {
        self.addMaterialBlock();
    }
    
}
@end
