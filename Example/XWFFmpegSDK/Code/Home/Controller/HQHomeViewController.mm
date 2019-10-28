//
//  HQHomeViewController.m
//  HQMVVM_RAC_Router
//
//  Created by Mr_Han on 2018/11/13.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "HQHomeViewController.h"
#import "HQHomeViewModel.h"
//#import "XWPhotoSelectorView.h"



#import "TZImagePickerController.h"

#import "XWFfmpegUtil.h"
#import "XWFileUtil.h"
#import "XWImageConvertVideo.h"
#import "XWImagePickerTool.h"
//
#import "JXCategoryTitleImageView.h"
#import "JXCategoryIndicatorLineView.h"
#import "JXCategoryListContainerView.h"

#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>

#import "JJOptionView.h"

#import "XWStickersViewController.h"
#import "XWTextViewController.h"
#import "XWPiecewiseViewController.h"
#import "XWSoundViewController.h"
#import "XWClipViewController.h"

@class UIActionSheetDelegateImpl;
static UIActionSheetDelegateImpl * delegateImpl;

@interface HQHomeViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,JXCategoryListContainerViewDelegate,JXCategoryViewDelegate>
//@property(nonatomic,strong)XWPhotoSelectorView* photoView;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, strong) UIButton  *conversionBtn;


@property (nonatomic, strong) UIImageView *containerView;
//播放器
@property (nonatomic, strong) ZFPlayerController *player;

@property (nonatomic, strong) ZFPlayerControlView *controlView;

@property (nonatomic, strong) ZFAVPlayerManager *playerManager;

@property (nonatomic, strong) NSArray *codecData;

////执行操作
//@property (nonatomic, strong) JJOptionView *optionView;
////输出格式
//@property (nonatomic, strong) JJOptionView *videoCodecView;

//执行操作选择
@property (nonatomic, assign) NSInteger optionIndex;

//
@property (nonatomic, strong) JXCategoryTitleImageView *myCategoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;


@property (nonatomic, strong) XWStickersViewController *stickersList;
@property (nonatomic, strong) XWTextViewController *TextList;
@property (nonatomic, strong) XWPiecewiseViewController *piecewiseList;
@property (nonatomic, strong) XWSoundViewController *soundList;
@property (nonatomic, strong) XWClipViewController *clipList;
@end

@implementation HQHomeViewController
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.player.viewControllerDisappear = YES;
    [super viewWillDisappear:animated];
}
- (BOOL)prefersStatusBarHidden {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.isStatusBarHidden;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.optionIndex = -1;
    self.images = @[].mutableCopy;
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(CGRectGetWidth(self.view.frame)* 9 / 16);
    }];
    
    
    [self.view addSubview:self.myCategoryView];
    [self.myCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.mas_equalTo(60);
        make.bottom.equalTo(self.view).offset(-5);
    }];
    [self.view addSubview:self.listContainerView];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.myCategoryView.mas_top);
        make.height.mas_equalTo(100);
    }];
    self.myCategoryView.contentScrollView = self.listContainerView.scrollView;
    self.myCategoryView.defaultSelectedIndex = 2;
    [self.listContainerView didClickSelectedItemAtIndex:2];

    [self pushTZImagePickerController];
   
}
#pragma mark -  UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        delegateImpl = nil;
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        actionSheet.delegate = nil;
    });
    switch (buttonIndex) {
        case 0: {
            [self pushImagePickerController];
        }
            
            break;
        case 1: {//打开相册
            //相册是可以用模拟器打开
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
                
                [self pushTZImagePickerController];
            }else{
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"Error" message:@"没有相册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alter show];
            }
        }
            break;
            
        default:
            break;
    }
}


#pragma make XWPhotoSelectorDelegate
-(void)addPhotoImage:(NSUInteger)index{
    NSLog(@"添加图片");
    if (self.optionIndex != -1) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"照片审核\n清晰/美观/本人/生活照\n严禁盗图/涉及色情违规等直接封号" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        actionSheet.tag = 0;
        [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    } else {
        
    }
    
    
}
-(void)deletedPhotoAtIndex:(NSUInteger)index withCurrentDataSource:(NSMutableArray *)dataSource{
    NSLog(@"删除了第%lu个图片",(unsigned long)index);
//    [self.photoView endEditPhoto];
//    [self.photoView reloadData:dataSource.copy];
}
-(void)showPhotoAtIndex:(NSUInteger)index withCurrentDataSource:(NSMutableArray *)dataSource{
    NSLog(@"显示第%lu个图片",(unsigned long)index);
}

-(void)conversionClick{
    
    NSString* path = [NSString stringWithFormat:@"%@input.txt",[XWFileUtil getTmpPath] ];
    NSString* outputPath = [NSString stringWithFormat:@"%@output.mp4",[XWFileUtil getTmpPath] ];
   
    NSMutableString* input = [[NSMutableString alloc] init];
    
    for (int i = 0 ; i < self.images.count; i ++) {
        NSString* strUrl = [NSString stringWithFormat:@"file '%@'\nduration %d\n",self.images[i],3];
        [input appendString:strUrl];
    }
    
    [XWFileUtil writeToFileString:path string:input.copy];
    NSString* ffmpegCommand = [XWImageConvertVideo xw_imageTurnVideoForFile:path outputFile:outputPath];
    
    [[XWFfmpegUtil getInstance] executeFFmpeg:ffmpegCommand logCallback:^(int level, NSString * _Nonnull message) {
        NSLog(@"message = %@",message);
        
    } progress:^(Statistics * _Nonnull statistics) {
        
        NSLog(@"size = %ld\nTime = %d",[statistics getSize],[statistics getTime]);
        
    } success:^(NSString * _Nonnull output) {
        
//        [self playVideo:outputPath];
        
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}

-(void)playVideo:(NSURL*)url{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.player.assetURL = url;
        [self.controlView showTitle:@"Apple" coverURLString:@"" fullScreenMode:ZFFullScreenModeAutomatic];
    });
    
}
-(void)playVideoForArray:(NSArray*)urls{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray* items = [[NSMutableArray alloc] init];
        for (XWImagePickerModel* model in urls) {
            [items addObject:model.url];
        }
        self.player.assetURLs = items;
        [self.player playTheIndex:0];
        [self.controlView showTitle:@"Apple" coverURLString:@"" fullScreenMode:ZFFullScreenModeAutomatic];
    });
    
}
- (void)pushTZImagePickerController {
   
    [[XWImagePickerTool getInstance] openImagePicker:XWImagePickerType_MultipleVideo maxCount:5 viewController:self doneBlock:^(NSArray * _Nonnull urls) {
        
        NSLog(@"urls = %@",urls);
//        NSMutableArray *temp = @[].mutableCopy;
//
//        for (XWImagePickerModel* model in urls) {
//            [temp addObject:@[model]];
//        }
        self.piecewiseList.dataSource = urls.mutableCopy;
        [self playVideoForArray:urls];
        
    }];
    
}


// 调用相机
- (void)pushImagePickerController {
    // 提前定位

    [[XWImagePickerTool getInstance] openCamera:self isRecord:YES isCamear:YES doneBlock:^(NSArray * _Nonnull images) {
        
    }];
}

-(ZFAVPlayerManager*)playerManager{
    if (!_playerManager) {
         _playerManager = [[ZFAVPlayerManager alloc] init];
    }
    return _playerManager;
}
-(ZFPlayerController*)player{
    if (!_player) {
        _player = [ZFPlayerController playerWithPlayerManager:self.playerManager containerView:self.containerView];
        _player.controlView = self.controlView;
        /// 设置退到后台继续播放
        _player.pauseWhenAppResignActive = NO;
        
        @weakify(self)
        _player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
            @strongify(self)
            [self setNeedsStatusBarAppearanceUpdate];
        };
        
        /// 播放完成
        _player.playerDidToEnd = ^(id  _Nonnull asset) {
            @strongify(self)
            [self.player playTheNext];

        };
        
    }
    return _player;
}
- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
        _controlView.prepareShowLoading = YES;
        _controlView.prepareShowControlView = YES;
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        
    }
    return _containerView;
}
//-(JJOptionView*)videoCodecView{
//    if (!_videoCodecView) {
//        _videoCodecView = [JJOptionView new];
//        _videoCodecView.titleFontSize = 10;
//        _videoCodecView.dataSource = @[@"libx264",@"h264_videotoolbox",@"libx265",@"libxvid",@"libvpx-vp9",@"libaom-av1",@"libkvazaar",@"libtheora"];
//        _videoCodecView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex) {
//            NSLog(@"%@",optionView);
//            NSLog(@"%ld",selectedIndex);
//        };
//    }
//    return _videoCodecView;
//}
//-(JJOptionView*)optionView{
//    if (!_optionView) {
//        _optionView = [JJOptionView new];
//        _optionView.dataSource = @[@"sign",@"multiple",@"image",@"gif"];
//        _optionView.titleFontSize = 10;
//        @weakify(self)
//        _optionView.selectedBlock = ^(JJOptionView * _Nonnull optionView, NSInteger selectedIndex) {
//            @strongify(self)
//            NSLog(@"%@",optionView);
//            self.optionIndex = selectedIndex;
//        };
//    }
//    return _optionView;
//}
-(JXCategoryTitleImageView*)myCategoryView{
    if (!_myCategoryView) {
        _myCategoryView = [JXCategoryTitleImageView new];
        NSArray* titles = @[@"贴纸", @"文字", @"分段", @"剪辑", @"音乐"];
        NSArray *imageNames = @[@"crab.png", @"lobster.png", @"apple.png", @"carrot.png", @"grape.png"];
        NSArray *selectedImageNames = @[@"crab_selected.png", @"lobster_selected.png", @"apple_selected.png", @"carrot_selected.png", @"grape_selected.png" ];
        _myCategoryView.averageCellSpacingEnabled = YES;
        _myCategoryView.titles = titles;
        _myCategoryView.imageNames = imageNames;
        _myCategoryView.selectedImageNames = selectedImageNames;
        _myCategoryView.imageZoomEnabled = YES;
        _myCategoryView.imageZoomScale = 1;
        _myCategoryView.delegate = self;
        _myCategoryView.imageTypes = @[@(JXCategoryTitleImageType_TopImage), @(JXCategoryTitleImageType_TopImage), @(JXCategoryTitleImageType_TopImage), @(JXCategoryTitleImageType_TopImage), @(JXCategoryTitleImageType_TopImage)];
//        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
//        lineView.indicatorWidth = 20;
//        self.myCategoryView.indicators = @[lineView];
    }
    return _myCategoryView;
}
-(JXCategoryListContainerView*)listContainerView{
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
        _listContainerView.didAppearPercent = 0.01; //滚动一点就触发加载
        _listContainerView.defaultSelectedIndex = 0;
    }
    return _listContainerView;
}
#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0) {
        
        return self.stickersList;
    } else if (index == 1) {
        
        return self.TextList;
    } else if (index == 2) {
        
        return self.piecewiseList;
    } else if (index == 3) {
        
        return self.clipList;
    } else if (index == 4) {
        
        return self.soundList;
    }
    
    return nil;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 5;
}
-(XWStickersViewController*)stickersList{
    if(!_stickersList){
        _stickersList = [[XWStickersViewController alloc] init];
        _stickersList.naviController = self.navigationController;
    }
    return _stickersList;
}
-(XWTextViewController*)TextList{
    if(!_stickersList){
        _TextList = [[XWTextViewController alloc] init];
        _TextList.naviController = self.navigationController;
    }
    return _TextList;
}
-(XWPiecewiseViewController*)piecewiseList{
    if(!_piecewiseList){
        _piecewiseList = [[XWPiecewiseViewController alloc] init];
        _piecewiseList.naviController = self.navigationController;
    }
    return _piecewiseList;
}
-(XWClipViewController*)clipList{
    if(!_clipList){
        _clipList = [[XWClipViewController alloc] init];
        _clipList.naviController = self.navigationController;
    }
    return _clipList;
}
-(XWSoundViewController*)soundList{
    if(!_soundList){
        _soundList = [[XWSoundViewController alloc] init];
        _soundList.naviController = self.navigationController;
    }
    return _soundList;
}
 @end

