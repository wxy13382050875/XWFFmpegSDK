//
//  XWPhotoSelectorCell.m
//  XWFFmpegSDK_Example
//
//  Created by 武新义 on 2019/9/3.
//  Copyright © 2019 ly-080208@163.com. All rights reserved.
//

#import "XWPhotoSelectorCell.h"
#import "NSData+XWBase64String.h"
#import <Photos/Photos.h>
@interface XWPhotoSelectorCell ()
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation XWPhotoSelectorCell

-(void)xw_setupUI{
//    self.backgroundColor = [UIColor blueColor];
    [self addSubview:self.photoImageView];
    [self addSubview:self.deleteButton];
    [self xw_updateConstraints];
}
-(void)xw_updateConstraints{
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

-(void)setPhoto:(id)photo{
    if ([photo isKindOfClass:[NSString class]]) {
        
        //网络图片
        if ([photo hasPrefix:@"http"]) {
            
            //识别SDWebImageView
#if __has_include(<SDWebImage/UIImageView+WebCache.h>)
            [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:Placeholder_Image];
#else
            
            //识别YYWebImageView
#if __has_include(<YYKit/UIImageView+YYWebImage.h>)
            [self.photoImageView setImageWithURL:[NSURL URLWithString:photo] placeholder:Placeholder_Image options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];
#else
            //当不存在YYWebImageView && SDWebImageView 系统默认加载方法，无缓存方案
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                //通知主线程刷新
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:photo]];
                    self.photoImageView.image = [UIImage imageWithData:data];
                });
                
            });
#endif
#endif
        }
        //base64编码格式图片
        else if ([photo hasPrefix:@"data:image"]) {
            NSData *imageData = [NSData dataWithBase64String:photo];
            self.photoImageView.image = [UIImage imageWithData:imageData];
        }
        //本地图片
        else if ([UIImage imageNamed:photo]) {
            self.photoImageView.image = [UIImage imageNamed:photo];
        }
        //data字符串
        else if ([photo dataUsingEncoding:NSUTF8StringEncoding]) {
            self.photoImageView.image = [[UIImage alloc]initWithData:[photo dataUsingEncoding:NSUTF8StringEncoding]];
        } else {
            self.photoImageView.image = Placeholder_Image;
        }
    }
    //UIImage 类型
    else if ([photo isKindOfClass:[UIImage class]]) {
        self.photoImageView.image = photo;
    }
    //NSData 类型
    else if ([photo isKindOfClass:[NSData class]]) {
        self.photoImageView.image = [[UIImage alloc]initWithData:photo];
    }
    else if([photo isKindOfClass:[PHAsset class]]){
        [[PHImageManager defaultManager] requestImageForAsset:photo targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            //                1.获取照片的url
            NSURL * url = [info objectForKey:@"PHImageFileURLKey"];
            NSData *data = [NSData dataWithContentsOfURL:url];
            self.photoImageView.image = [UIImage imageWithData:data];
            NSLog(@"url = %@",url);
            //                2.获取视频的地址
            //
        }];
    }
    //unknown
    else {
        self.photoImageView.image = Placeholder_Image;
    }
}

- (void)deleteClick
{
    if (self.deleteButtonClickBlock) {
        self.deleteButtonClickBlock();
    }
}

- (void)setShowDeleteButton:(BOOL)showDeleteButton
{
    if (showDeleteButton) {
        self.deleteButton.enabled = YES;
        self.deleteButton.hidden = NO;
    } else {
        self.deleteButton.enabled = NO;
        self.deleteButton.hidden = YES;
    }
}

-(UIImageView*)photoImageView{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc]init];
//        _photoImageView.backgroundColor = [UIColor whiteColor];
//        _photoImageView.layer.cornerRadius = 4;
//        _photoImageView.clipsToBounds = YES;
//        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _photoImageView;
}
-(UIButton*)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.backgroundColor = RGB_COLOR(0, 0, 0, 0.5);
        _deleteButton.enabled = NO;
        _deleteButton.hidden = YES;
        _deleteButton.layer.cornerRadius = 4;
        _deleteButton.clipsToBounds = YES;
        [_deleteButton setImage:[UIImage imageNamed:@"DPPhoto_library_delete"] forState:UIControlStateNormal];
        [_deleteButton setImageEdgeInsets:UIEdgeInsetsMake(self.bounds.size.width / 2 - 18, self.bounds.size.width / 2 - 18, self.bounds.size.width / 2 - 18, self.bounds.size.width / 2 - 18)];
        [_deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}
@end
