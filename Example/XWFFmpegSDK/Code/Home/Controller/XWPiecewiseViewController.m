//
//  XWPiecewiseViewController.m
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/11.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import "XWPiecewiseViewController.h"
#import "XWPiecewiseControls.h"

#import "XWImagePickerTool.h"
#import "TZImagePickerController.h"

@interface XWPiecewiseViewController ()<TZImagePickerControllerDelegate>
@property(nonatomic,strong)XWPiecewiseControls* controls;
@end

@implementation XWPiecewiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor yellowColor];
}
-(void)xw_setupUI{
    [self.view addSubview:self.controls];
    [self xw_updateConstraints];
}
-(void)xw_updateConstraints{
    [self.controls mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 60));
    }];
}
- (UIView *)listView {
    return self.view;
}
#pragma make 懒加载
-(XWPiecewiseControls*)controls{
 
    if (!_controls) {
        _controls = [XWPiecewiseControls new];
        WEAKSELF
        _controls.openPhotoAlbumBlock = ^(NSIndexPath * _Nonnull indexPath) {
            [[XWImagePickerTool getInstance] openImagePicker:XWImagePickerType_SingleVideo maxCount:1 viewController:weakSelf_SC.naviController doneBlock:^(NSArray * _Nonnull items) {
                [weakSelf_SC.dataSource insertObject:items[0] atIndex:indexPath.section];
                weakSelf_SC.controls.dataSource = weakSelf_SC.dataSource;
            }];
        };
    }
    return _controls;
}


- (void)listDidAppear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    //    kSetMJRefresh(self.tableView);
}

- (void)listDidDisappear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    self.controls.dataSource = _dataSource;
}
@end
