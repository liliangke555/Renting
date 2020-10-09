//
//  LDROneKeyLoginRequest.h
//  LDRenting
//
//  Created by MAC on 2020/8/19.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"
#import "LDRPhoneCodeLoginRequest.h"
NS_ASSUME_NONNULL_BEGIN

@interface LDROneKeyLoginRequest : BaseRequest
CopyStringProperty aliAccessToken;
CopyStringProperty loginSource;
@end

NS_ASSUME_NONNULL_END
