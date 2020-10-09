//
//  LDRAddHouseAddRequest.h
//  LDRenting
//
//  Created by MAC on 2020/8/20.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRAddHouseAddRequest : BaseRequest
CopyStringProperty address;
CopyStringProperty houseName;
AssignProperty NSInteger houseType;
StrongNumberProperty latitude;
StrongNumberProperty longitude;
CopyStringProperty mac;
CopyStringProperty region;
@end

@interface LDRAddHouseModel : JsonBaseObject
CopyStringProperty houseId;
CopyStringProperty userHouseRelationId;
CopyStringProperty userId;
@end

NS_ASSUME_NONNULL_END
