//
//  LDRHomeHouseManagerCell.h
//  LDRenting
//
//  Created by MAC on 2020/7/15.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRShadowTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRHomeHouseManagerCell : LDRShadowTableViewCell

@property (nonatomic, copy) NSString *houseNumber;
@property (nonatomic, copy) NSString *tenantNumber;

- (void)didClickHouse:(void(^)(void))clickHouse clickTenant:(void(^)(void))clickTenant;

@end

NS_ASSUME_NONNULL_END
