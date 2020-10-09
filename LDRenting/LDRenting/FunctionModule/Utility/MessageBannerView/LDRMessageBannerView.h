//
//  LDRMessageBannerView.h
//  LDRenting
//
//  Created by MAC on 2020/7/19.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRMessageBannerView : UIView

/**
 滑动间隔
 */
@property (nonatomic, assign) CGFloat timeInterval;
@property (nonatomic, strong) NSArray *bannerArray;

@end

NS_ASSUME_NONNULL_END
