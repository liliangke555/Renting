//
//  LDRIdCardVerificationRequest.h
//  LDRenting
//
//  Created by MAC on 2020/8/25.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRIdCardVerificationRequest : BaseRequest
CopyStringProperty houseId; //!< 房屋id(替租客登记时需要传递该参数)
CopyStringProperty idCard; //!< 身份证号码
CopyStringProperty name; //!< 姓名
CopyStringProperty phoneNum; //!< 手机号码(替租客登记时需要传递该参数)
CopyStringProperty userHouseRelationId; //!< 用户房屋关联关系id，userHouseRelationId为空：房东实名认证；不为空：租客实名认证必传；房东替租客登记不用传
@end

NS_ASSUME_NONNULL_END
