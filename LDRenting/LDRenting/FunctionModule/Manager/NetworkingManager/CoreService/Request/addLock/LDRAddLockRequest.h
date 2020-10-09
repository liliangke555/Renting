//
//  LDRAddLockRequest.h
//  LDRenting
//
//  Created by MAC on 2020/8/24.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRAddLockRequest : BaseRequest
CopyStringProperty deviceName;
CopyStringProperty electric;
CopyStringProperty hardVersion;
//CopyStringProperty iccid;
//CopyStringProperty lock_id;
CopyStringProperty imei;
CopyStringProperty imsi;
CopyStringProperty mac;
CopyStringProperty model;
CopyStringProperty nbModelType;
CopyStringProperty signal;
CopyStringProperty softVersion;
@end

NS_ASSUME_NONNULL_END
