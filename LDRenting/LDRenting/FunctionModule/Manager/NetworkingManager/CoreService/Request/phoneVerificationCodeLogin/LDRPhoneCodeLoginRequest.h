//
//  LDRPhoneCodeLoginRequest.h
//  LDRenting
//
//  Created by MAC on 2020/8/18.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"
#import "JsonBaseObject.h"
NS_ASSUME_NONNULL_BEGIN

@interface LDRPhoneCodeLoginRequest : BaseRequest
CopyStringProperty loginSource;
CopyStringProperty phoneNumber;
CopyStringProperty verificationCode;
@end

@interface LDRLoginSuccessModel : JsonBaseObject
CopyStringProperty accessToken;
CopyStringProperty accessTokenRefresh;
CopyStringProperty expiredTimestamp;
@end

NS_ASSUME_NONNULL_END
