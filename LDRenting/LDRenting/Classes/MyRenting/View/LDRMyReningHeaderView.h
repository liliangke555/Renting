//
//  LDRMyReningHeaderView.h
//  LDRenting
//
//  Created by MAC on 2020/7/29.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LDRMyRentingHeaderDelegate <NSObject>

- (void)didToSearchText:(NSString *)text;

@end
@interface LDRMyReningHeaderView : UIView
@property (nonatomic, weak) id <LDRMyRentingHeaderDelegate> delegate;
- (instancetype)initWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
