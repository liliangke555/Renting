//
//  LDRBuleToothOpenAlertView.h
//  LDRenting
//
//  Created by MAC on 2020/8/11.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRPopupView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, LDRBuleToothOpenType) {
    LDRBuleToothOpening,
    LDRBuleToothOpenSuccesse,
    LDRBuleToothOpenFailure,
};
@interface LDRBuleToothOpenAlertView : LDRPopupView

@property (nonatomic) LDRBuleToothOpenType openType;
- (instancetype)initWithTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
