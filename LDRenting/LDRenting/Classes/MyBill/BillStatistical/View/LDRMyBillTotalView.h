//
//  LDRMyBillTotalView.h
//  LDRenting
//
//  Created by MAC on 2020/7/28.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRMyBillTotalView : UIView
@property (nonatomic, copy) NSString *totalMony;
@property (nonatomic, copy) NSString *numberString;
@property (nonatomic, copy) NSString *timeString;
@property (nonatomic, copy) void(^didClickTimeAction)(UIButton *sender);
@end

NS_ASSUME_NONNULL_END
