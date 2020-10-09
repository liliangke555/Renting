//
//  LDRCheckUserRealPeopleRequest.h
//  LDRenting
//
//  Created by MAC on 2020/8/25.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRCheckUserRealPeopleRequest : BaseRequest

@end

@interface LDRCheckRealModel : JsonBaseObject
CopyStringProperty idCardNum;
AssignProperty BOOL isRealPeople;
CopyStringProperty name;
CopyStringProperty phone;
@end

NS_ASSUME_NONNULL_END
