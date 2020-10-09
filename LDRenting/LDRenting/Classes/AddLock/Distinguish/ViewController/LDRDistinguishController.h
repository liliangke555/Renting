//
//  LDRDistinguishController.h
//  LDRenting
//
//  Created by MAC on 2020/7/23.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewController.h"
#import "LDROrganizationRequest.h"
NS_ASSUME_NONNULL_BEGIN

@protocol LDRDistingguishDelegate <NSObject>

- (void)distinguishResultWithName:(NSString *)name idCardNo:(NSString *)idCardNo;

@end

@interface LDRDistinguishController : LDRBaseTableViewController
@property (nonatomic, weak) id <LDRDistingguishDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
