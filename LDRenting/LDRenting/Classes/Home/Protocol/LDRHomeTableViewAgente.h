//
//  LDRHomeTableViewAgente.h
//  LDRenting
//
//  Created by MAC on 2020/7/15.
//  Copyright © 2020 LD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDRCashbookIndexCountModel.h"
NS_ASSUME_NONNULL_BEGIN

@class LDRHomeNavigationBar;

@protocol LDRHomeTableDelegate <NSObject>

- (void)didClickHouse;
- (void)didClickTenant;
- (void)toNoticeView;

@end
@interface LDRHomeTableViewAgente : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign,getter=isLogin) BOOL login;
@property (nonatomic, weak) id form;
@property (nonatomic, strong) LDRCashbookIndexCountModel *model;
@property (nonatomic, weak) LDRHomeNavigationBar * navForm;
@property (nonatomic, strong) NSArray *messageArray;

@end

NS_ASSUME_NONNULL_END
