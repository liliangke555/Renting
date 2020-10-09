//
//  UIBarButtonItem+LDRBarButtonItem.m
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "UIBarButtonItem+LDRBarButtonItem.h"

@implementation UIBarButtonItem (LDRBarButtonItem)

+(UIBarButtonItem *)ldr_BackItemWithImage:(UIImage *)image WithHighlightedImage:(UIImage *)HighlightedImage Target:(id)target action:(SEL)action title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button sizeToFit];
    button.frame = CGRectMake(0, 0, 80, 40);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:HighlightedImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, -20);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
+(UIBarButtonItem *)ldr_ItemWithImage:(UIImage *)image WithHighlighted:(UIImage *)HighlightedImage Target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:HighlightedImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *StockNewspaperscontentView = [[UIView alloc]initWithFrame:button.frame];
    [StockNewspaperscontentView addSubview:button];
    
    return [[UIBarButtonItem alloc]initWithCustomView:StockNewspaperscontentView];
}

+(UIBarButtonItem *)ldr_ItemWithImage:(UIImage *)image WithSelected:(UIImage *)SelectedImage Target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:SelectedImage forState:UIControlStateSelected];
    [button sizeToFit];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc]initWithFrame:button.frame];
    [view addSubview:button];
    
    return [[UIBarButtonItem alloc]initWithCustomView:view];
}


@end
