//
//  LDRMapScrollView.m
//  LDRenting
//
//  Created by MAC on 2020/8/20.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMapScrollView.h"

@implementation LDRMapScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{

    return YES;
}

@end
