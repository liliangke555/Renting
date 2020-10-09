//
//  LDRAddAuthByBTRequest.h
//  LDRenting
//
//  Created by MAC on 2020/8/25.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRAddAuthByBTRequest : BaseRequest
CopyStringProperty authId;
CopyStringProperty authName;
CopyStringProperty blueBrdInfo;
CopyStringProperty expiredTime;
//CopyStringProperty id;

CopyStringProperty mac;
AssignProperty NSInteger openType;
CopyStringProperty phoneNumber;
AssignProperty NSInteger remainCount;
CopyStringProperty remoteSeq;

AssignProperty NSInteger remoteType;
CopyStringProperty startTime;
AssignProperty NSInteger superAdminAuth;
CopyStringProperty userHouseRelationId;
AssignProperty NSInteger validFlag;
@end

@interface LDRAddAuthByBTModel : JsonBaseObject
CopyStringProperty key;
CopyStringProperty openTypeId;
@end

NS_ASSUME_NONNULL_END
