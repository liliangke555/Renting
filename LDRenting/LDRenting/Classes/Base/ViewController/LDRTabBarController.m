//
//  LDRTabBarController.m
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRTabBarController.h"
#import "LDRHomeViewController.h"
//#import "LDRMyHouseViewController.h"
#import "LDRMineHomeViewController.h"

static CGFloat const hn_CYLTabBarControllerHeight = 49.0f;
@interface LDRTabBarController ()
@property (nonatomic, readwrite, strong) CYLTabBarController *hn_tabBarController;

@end

@implementation LDRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
}
- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;
    UIOffset titlePositionAdjustment = UIOffsetMake(0, 0);
    CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.tabbarViewControllers
                                                                               tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                         imageInsets:imageInsets
                                                                             titlePositionAdjustment:titlePositionAdjustment
                                                                                             context:nil];
    [self hn_customizeTabBarAppearance:tabBarController];
    return (self = (LDRTabBarController *)tabBarController);
}
- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *locationAttributes = @{
        CYLTabBarItemTitle : @"首页",
        CYLTabBarItemImage : @"home_normal",
        CYLTabBarItemSelectedImage : @"home_selected",
    };
    NSDictionary *categoryAttributes = @{
        CYLTabBarItemTitle : @"我的",
        CYLTabBarItemImage : @"mine_normal",
        CYLTabBarItemSelectedImage : @"mine_selected",
    };
    
//    NSDictionary *discountAttributes = @{
//        CYLTabBarItemTitle : @"我的门锁",
//        CYLTabBarItemImage : @"tabbar_discount_normal",
//        CYLTabBarItemSelectedImage : @"tabbar_discount_selected",
//    };
    
    NSArray *hn_tabBarItemsAttributes = @[
        locationAttributes,
        categoryAttributes,
//        discountAttributes,
    ];
    return hn_tabBarItemsAttributes;
}
- (void)hn_customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? (hn_CYLTabBarControllerHeight +34) : hn_CYLTabBarControllerHeight;
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    normalAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:12.f];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = LDR_MainGreenColor;
    selectedAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:12.f];
    
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [self customizeTabBarSelectionIndicatorImage];
}
- (void)customizeTabBarSelectionIndicatorImage {
    CGFloat hn_tabBarHeight = CYL_IS_IPHONE_X?(hn_CYLTabBarControllerHeight + 34):hn_CYLTabBarControllerHeight;
    CGSize hn_selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, hn_tabBarHeight);
    UITabBar *hn_tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [hn_tabBar setSelectionIndicatorImage:
     [[self class] hn_imageWithColor:[UIColor clearColor]
                                size:hn_selectionIndicatorImageSize]];
}
+ (UIImage *)hn_scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
+ (UIImage *)hn_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - Getter
- (NSArray *)tabbarViewControllers{
    
    //
    LDRHomeViewController   *homeController = [[LDRHomeViewController alloc] init];
//    homeController.navigationItem.title = @"首页";
    LDRNavigationController *homeNav = [[LDRNavigationController alloc]
                                        initWithRootViewController:homeController];
    //
    LDRMineHomeViewController *categoryController  = [[LDRMineHomeViewController alloc] init];
//    categoryController.navigationItem.title = @"我的";
    LDRNavigationController *categoryNav = [[LDRNavigationController alloc]
                                            initWithRootViewController:categoryController];
    //
//    LDRMyDoorLockViewController *discountController = [[LDRMyDoorLockViewController alloc] init];
//    discountController.navigationItem.title = @"我的门锁";
//    LDRNavigationController *discountNav = [[LDRNavigationController alloc]
//                                                 initWithRootViewController:discountController];

    NSArray *tabbarViewControllerArr = @[
        homeNav,
        categoryNav,
//        discountNav,
    ];
    return tabbarViewControllerArr;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
