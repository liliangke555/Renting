//
//  LDRBottomPoliceView.h
//  LDRenting
//
//  Created by MAC on 2020/7/29.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRBottomPoliceView : UIView
@property (nonatomic, assign,getter=isEnable) BOOL enable;
- (instancetype)initWithButtonTitle:(NSString *)title action:(void(^)(void))action;
@end

NS_ASSUME_NONNULL_END
