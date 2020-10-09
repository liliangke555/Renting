//
//  LDRCashbookIndexCountModel.h
//  LDRenting
//
//  Created by MAC on 2020/8/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "JsonBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRCashbookIndexCountModel : JsonBaseObject
AssignProperty NSInteger houseCount;
StrongNumberProperty moneyCount;
AssignProperty NSInteger tenantCount;
@end

NS_ASSUME_NONNULL_END
