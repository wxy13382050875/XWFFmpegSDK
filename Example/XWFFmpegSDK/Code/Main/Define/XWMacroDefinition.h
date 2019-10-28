//
//  MacroDefinition.h
//  weather
//
//  Created by Davis on 2017/6/15.
//  Copyright © 2017年 Davis. All rights reserved.
//

#ifndef XWMacroDefinition_h
#define XWMacroDefinition_h
#import <AdSupport/AdSupport.h>


//*******************other**********************
#define IMG(name) [UIImage imageNamed:name]
#define Placeholder_Image [UIImage imageNamed:@"DPPhoto_library_holdImage"] //占位图


#define MUID    [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]

/* regist cell(xib) */
#define kRegistCell(tableView, cellName, identifier) [tableView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:identifier];

#define kRegistClassCell(tableView, cellName, identifier) [tableView registerClass:cellName forCellReuseIdentifier:identifier]

#define kRegistCollection(collectionView, cellName, identifier)  [collectionView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellWithReuseIdentifier:identifier];


//拍照之后 获取图片 压缩
#define IMAGECOMPRESS(a) UIImageJPEGRepresentation(a, 0.5)

//*************************通知信息********************
#define RegisterNotice(_name, _selector)                    \
[DefaultCenter addObserver:self  \
selector:_selector name:_name object:nil];

#define DefaultCenter [NSNotificationCenter defaultCenter]

#define UserDefault [NSUserDefaults standardUserDefaults]

//***************************color*************************

#define COLOR(a) [UIColor colorWithHexString:a]

#define RGB_COLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)] //颜色

//***************************frame*************************
//get the  size of the Screen
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width

#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

#define kTabHeight   49

#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define kIs_iPhoneX SCREEN_WIDTH >=375.0f && SCREEN_HEIGHT >=812.0f&& kIs_iphone

/*状态栏高度*/
#define kStatusBarHeight (CGFloat)(kIs_iPhoneX?(44.0):(20.0))
/*导航栏高度*/
#define kNavBarHeight (44)
/*状态栏和导航栏总高度*/
#define kNavBarAndStatusBarHeight (CGFloat)(kIs_iPhoneX?(88.0):(64.0))
/*TabBar高度*/
#define kTabBarHeight (CGFloat)(kIs_iPhoneX?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define kTopBarSafeHeight (CGFloat)(kIs_iPhoneX?(44.0):(0))
/*底部安全区域远离高度*/
#define kBottomSafeHeight (CGFloat)(kIs_iPhoneX?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define kTopBarDifHeight (CGFloat)(kIs_iPhoneX?(24.0):(0))
/*导航条和Tabbar总高度*/
#define kNavAndTabHeight (kNavBarAndStatusBarHeight + kTabBarHeight)

//  4    4S
#define Inch3_5 (SCREEN_HEIGHT == 480.0)
//  5    5S   5C
#define Inch4_0 (SCREEN_HEIGHT == 568.0)
//  6    6S
#define Inch4_7 (SCREEN_HEIGHT == 667.0)
//  6P   6SP
#define Inch5_5 (SCREEN_HEIGHT == 736.0)
//  X
#define kNavHeight (SCREEN_HEIGHT >= 812.0 ? 88 : 64)

#define SafeAreaTopHeight (SCREEN_HEIGHT >= 812.0 ? 24 : 0)
#define SafeAreaBottomHeight (SCREEN_HEIGHT >= 812.0 ? 34 : 0)

//****************************************************
#define WEAKSELF __weak __typeof(&*self)weakSelf_SC = self;

#define URLWITHSTRING(a) [NSURL URLWithString:a]

//***************************计算*************************
#define FONT(a) [UIFont systemFontOfSize:a]

//***************************app delegate*************************
#define APPD  [UIApplication sharedApplication]

#define APPDELEGATE (AppDelegate*)[[UIApplication sharedApplication] delegate]

#define rootTabBarVC (UITabBarController*)[[[[UIApplication sharedApplication] delegate] window] rootViewController]

//***************************SVProgress********************

/*************************自定义******************************/

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

/************************ chat *************************/
#define iOS7LATER ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8LATER ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9LATER ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1LATER ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)

// 弱引用
#define LHWeakSelf __weak typeof(self) weakSelf = self;

#define recourcesPath [[NSBundle mainBundle] resourcePath]


#endif /* MacroDefinition_h */
