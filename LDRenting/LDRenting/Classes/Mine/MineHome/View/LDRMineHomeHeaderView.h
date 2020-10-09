//
//  LDRMineHomeHeaderView.h
//  LDRenting
//
//  Created by MAC on 2020/8/7.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRMineHomeHeaderView : UIView
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, assign,getter=isAuthentication) BOOL authentication;
@property (nonatomic, assign,getter=isLogin) BOOL login;
@end

NS_ASSUME_NONNULL_END
