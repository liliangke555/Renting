//
//  Header.h
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#ifndef LDRScreen_h
#define LDRScreen_h

/**屏幕宽度*/
#define LDR_WIDTH  [UIScreen mainScreen].bounds.size.width
/**屏幕高度*/
#define LDR_HEIGHT [UIScreen mainScreen].bounds.size.height

/**以6s为标准，定义一个宽度比例，用于计算动态高度*/
#define LDR_Sales  DEVICE_WIDTH/375
///状态栏高度
#define KStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define KIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define KIs_iPhoneX LDR_WIDTH >=375.0f && LDR_HEIGHT >=812.0f&& KIs_iphone

/*状态栏高度*/
#define KStatusBarHeight (CGFloat)(KIs_iPhoneX?(44.0):(20.0))
/*导航栏高度*/
#define KNavBarHeight (44)
/*状态栏和导航栏总高度*/
#define KNavBarAndStatusBarHeight (CGFloat)(KIs_iPhoneX?(88.0):(64.0))
/*TabBar高度*/
#define KTabBarHeight (CGFloat)(KIs_iPhoneX?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define KTopBarSafeHeight (CGFloat)(KIs_iPhoneX?(44.0):(0))
/*底部安全区域远离高度*/
#define KBottomSafeHeight (CGFloat)(KIs_iPhoneX?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define KTopBarDifHeight (CGFloat)(KIs_iPhoneX?(24.0):(0))
/*导航条和Tabbar总高度*/
#define KNavAndTabHeight (KNavBarAndStatusBarHeight + KTabBarHeight)


#define LDR_Window [UIApplication sharedApplication].keyWindow
/**通用单例类*/
#define LDR_interface(className) \
+ (className *)shared##className;

#define SEC_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToKen; \
dispatch_once(&onceToKen, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToKen; \
dispatch_once(&onceToKen, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

#define KIS_IPHONE_4 ([[UIScreen mainScreen] bounds].size.height == 480.0f)
#define KIS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == 568.0f)
#define KIS_IPHONE_6 ([[UIScreen mainScreen] bounds].size.height == 667.0f)
#define KIS_IPHONE_6_PLUS ([[UIScreen mainScreen] bounds].size.height == 736.0f)


#define LDRWeakify(o)        __weak   typeof(self) weakSelf = o;
#define LDRStrongify(o)      __strong typeof(self) o = strongSelf;


//替换NSL
#ifdef DEBUG
#define LDRLog(format, ...)   NSLog(format, ## __VA_ARGS__)
#else
#define LDRLog(format, ...)
#endif

#define CopyStringProperty  @property (copy, nonatomic) NSString *
#define StrongNumberProperty @property (strong, nonatomic) NSNumber *
#define AssignProperty @property (assign, nonatomic)
#define StrongProperty @property (strong, nonatomic)


#endif /* LDRScreen_h */
