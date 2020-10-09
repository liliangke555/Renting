//
//  UIScrollView+LDRScrollView.m
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import "UIScrollView+LDRScrollView.h"

@implementation UIScrollView (LDRScrollView)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([self isPanBackAction:gestureRecognizer]) {
        return YES;
    }
    return NO;
}

/// 判断是否是全屏的返回手势
- (BOOL)isPanBackAction:(UIGestureRecognizer *)gestureRecognizer
{
    // 在最左边时候 && 是pan手势 && 手势往右拖
    if (self.contentOffset.x == 0) {
        if (gestureRecognizer == self.panGestureRecognizer) {
            // 根据速度获取拖动方向
            CGPoint velocity = [self.panGestureRecognizer velocityInView:self.panGestureRecognizer.view];
            if(velocity.x>0){
                //手势向右滑动
                return YES;
            }
        }
    }
    return NO;
}
//// 如果是全屏的左滑返回,那么ScrollView的左滑就没用了,返回NO,让ScrollView的左滑失效
//// 不写此方法的话,左滑时,那个ScrollView上的子视图也会跟着左滑的
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self isPanBackAction:gestureRecognizer]) {
        return NO;
    }
    return YES;
}
@end
