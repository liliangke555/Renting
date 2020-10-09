//
//  LDRSliderAlertView.h
//  LDRenting
//
//  Created by MAC on 2020/8/17.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRPopupView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRSliderAlertView : LDRPopupView
@property (nonatomic, copy) void(^didSuccessCallBack)(NSDictionary *dic);
@end

NS_ASSUME_NONNULL_END
