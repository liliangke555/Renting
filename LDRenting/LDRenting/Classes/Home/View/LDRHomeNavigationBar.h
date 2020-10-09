//
//  LDRHomeNavigationBar.h
//  LDRenting
//
//  Created by MAC on 2020/7/17.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LDRHomeNavigationDelegate <NSObject>

- (void)leftButtonDidClick;
- (void)rightButtonDidClick;
@end

@interface LDRHomeNavigationBar : UIView

@property (nonatomic, weak) id <LDRHomeNavigationDelegate> delegate;
@property (nonatomic, assign, getter=isLogin) BOOL login;
@property (nonatomic, copy) NSString *nameString;

- (void)changeBackgroundColorWithContentoff:(CGPoint)content;
- (instancetype)initWithLogin:(BOOL)isLogin;

@end

NS_ASSUME_NONNULL_END
