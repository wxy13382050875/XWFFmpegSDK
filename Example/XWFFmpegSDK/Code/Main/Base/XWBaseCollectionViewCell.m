//
//  XWBaseCollectionViewCell.m
//  PlayFC
//
//  Created by 武新义 on 2019/5/13.
//  Copyright © 2019 Davis. All rights reserved.
//

#import "XWBaseCollectionViewCell.h"

@implementation XWBaseCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self xw_setupUI];
    }
    return self;
}

-(void)xw_setupUI{
    
}
-(void)xw_updateConstraints{
    
}

@end
