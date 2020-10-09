//
//  LDRSliderVerifyRequest.h
//  LDRenting
//
//  Created by MAC on 2020/8/18.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRSliderVerifyRequest : BaseRequest
CopyStringProperty appKey;
CopyStringProperty phoneNumber;
CopyStringProperty scene;
CopyStringProperty sessionId;
CopyStringProperty sig;
AssignProperty NSInteger slideUsage;
CopyStringProperty token;
@end

NS_ASSUME_NONNULL_END
