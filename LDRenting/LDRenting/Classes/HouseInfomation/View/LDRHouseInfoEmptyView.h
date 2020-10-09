//
//  LDRHouseInfoEmptyView.h
//  LDRenting
//
//  Created by MAC on 2020/8/4.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRHouseInfoEmptyView : UIView
- (instancetype)initWithTitle:(NSString *)title
                     setImage:(void(^ _Nullable)(UIImageView *imageView))setImage
                  buttonTitle:(NSString * _Nullable)buttonTitle
                 buttonAction:(void(^ _Nullable)(void))buttonAction;
@end

NS_ASSUME_NONNULL_END
