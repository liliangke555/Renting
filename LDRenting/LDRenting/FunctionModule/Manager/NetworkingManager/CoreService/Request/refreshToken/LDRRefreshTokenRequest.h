//
//  LDRRefreshTokenRequest.h
//  LDRenting
//
//  Created by MAC on 2020/8/18.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRRefreshTokenRequest : BaseRequest
CopyStringProperty grantType;
CopyStringProperty refreshToken;
@end

NS_ASSUME_NONNULL_END
