//
//  XWBaseView.m
//  PlayFC
//
//  Created by 武新义 on 2019/5/15.
//  Copyright © 2019 Davis. All rights reserved.
//

#import "XWBaseView.h"

@implementation XWBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self xw_initData];
        [self xw_setupUI];
    }
    return self;
}
-(void)xw_initData{
    
}
-(void)xw_setupUI{
    
}
-(void)xw_updateConstraints{
    
}
@end
