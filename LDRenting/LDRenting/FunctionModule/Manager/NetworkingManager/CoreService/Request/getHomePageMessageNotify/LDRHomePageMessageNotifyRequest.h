//
//  LDRHomePageMessageNotifyRequest.h
//  LDRenting
//
//  Created by MAC on 2020/8/19.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRHomePageMessageNotifyRequest : BaseRequest

@end
@interface LDRHomeMessageModel : JsonBaseObject
AssignProperty NSInteger messageNotifyCount;
AssignProperty NSInteger messageNotifyType;
@end
NS_ASSUME_NONNULL_END
