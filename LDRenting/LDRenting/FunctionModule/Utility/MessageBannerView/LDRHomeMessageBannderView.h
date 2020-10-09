//
//  LDRHomeMessageBannderView.h
//  LDRenting
//
//  Created by MAC on 2020/7/20.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRHomeMessageBannderView : UIView

/**
 滑动间隔
 */
@property (nonatomic, assign) CGFloat timeInterval;
@property (nonatomic, strong) NSArray *dataSource;

@end

NS_ASSUME_NONNULL_END
