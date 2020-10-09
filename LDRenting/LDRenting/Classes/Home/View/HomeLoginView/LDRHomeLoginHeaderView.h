//
//  LDRHomeLoginHeaderView.h
//  LDRenting
//
//  Created by MAC on 2020/7/16.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LDRCollectionIndexCountModel;
NS_ASSUME_NONNULL_BEGIN

@protocol LDRHomeHeaderDelegate <NSObject>

- (void)didClickMyBill;
- (void)didClickProfit;

@end

@interface LDRHomeLoginHeaderView : UIView
@property (nonatomic, weak) id <LDRHomeHeaderDelegate> delegate;
@property (nonatomic, strong) LDRCollectionIndexCountModel *model;
@property (nonatomic, assign) CGFloat moneyCount;
@end

NS_ASSUME_NONNULL_END
