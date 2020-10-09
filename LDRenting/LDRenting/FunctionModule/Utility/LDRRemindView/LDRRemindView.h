//
//  LDRRemindView.h
//  LDRenting
//
//  Created by MAC on 2020/7/29.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRRemindView : UIView
- (instancetype)initWithTitle:(NSString *)title setImage:(void(^)(UIImageView *imageView))setImage close:(void(^)(void))didClose;
@end

NS_ASSUME_NONNULL_END
