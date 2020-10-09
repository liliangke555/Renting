//
//  LDRAgentEarningsPageListRequest.h
//  LDRenting
//
//  Created by MAC on 2020/8/19.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRAgentEarningsPageListRequest : BaseRequest
AssignProperty NSInteger current;
AssignProperty NSInteger size;
@end

@interface LDRMyProfitList : JsonBaseObject
AssignProperty NSInteger current;
AssignProperty BOOL searchCount;
AssignProperty NSInteger size;
AssignProperty NSInteger total;
StrongProperty NSArray *records;
@end
@interface LDRMyProfit : JsonBaseObject
StrongNumberProperty agentEarnings;
CopyStringProperty generatedTime;
CopyStringProperty period;
@end
NS_ASSUME_NONNULL_END
