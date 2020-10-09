//
//  LDRMapTableView.m
//  LDRenting
//
//  Created by MAC on 2020/8/6.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMapTableView.h"

@implementation LDRMapTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
//    if (self.isCanScroll) {
//        return NO;
//    }
    return YES;
}

@end
