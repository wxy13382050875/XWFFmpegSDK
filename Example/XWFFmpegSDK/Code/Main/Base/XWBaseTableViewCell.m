//
//  XWBaseTableViewCell.m
//  PlayFC
//
//  Created by 武新义 on 2019/5/13.
//  Copyright © 2019 Davis. All rights reserved.
//

#import "XWBaseTableViewCell.h"

@implementation XWBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self xw_setupUI];
    }
    return self;
}

-(void)xw_setupUI{
    
}
//-(void)updateConstraints{
//    [self xw_updateConstraints];
//    [super updateConstraints];
//}
@end
