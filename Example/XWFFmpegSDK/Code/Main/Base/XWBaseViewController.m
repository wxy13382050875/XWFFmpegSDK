//
//  XWBaseViewController.m
//  PlayFC
//
//  Created by 武新义 on 2019/5/13.
//  Copyright © 2019 Davis. All rights reserved.
//

#import "XWBaseViewController.h"

@interface XWBaseViewController ()
@end

@implementation XWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    [self xw_setupUI];
    [self xw_layoutNavigation];
    [self xw_loadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)xw_setupUI{
    
}
-(void)xw_loadData{
    
}
-(void)xw_layoutNavigation{
    
}





@end
