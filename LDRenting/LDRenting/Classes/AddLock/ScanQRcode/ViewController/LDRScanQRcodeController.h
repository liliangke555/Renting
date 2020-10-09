//
//  LDRScanQRcodeController.h
//  LDRenting
//
//  Created by MAC on 2020/7/20.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LDRScanQRDelegate <NSObject>

- (void)didScanQRCompletion:(NSString *)string isMac:(BOOL)isMac;
- (void)didClickNoQRCode;

@end

@interface LDRScanQRcodeController : LDRBaseViewController
@property (nonatomic, weak) id <LDRScanQRDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
