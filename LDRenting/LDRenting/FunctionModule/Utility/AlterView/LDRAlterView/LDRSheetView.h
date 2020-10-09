//
//  LDRSheetView.h
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "MMPopupView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRSheetView : MMPopupView
- (instancetype)initWithTitle:(NSString *)title items:(NSArray *)items;
@end

NS_ASSUME_NONNULL_END
