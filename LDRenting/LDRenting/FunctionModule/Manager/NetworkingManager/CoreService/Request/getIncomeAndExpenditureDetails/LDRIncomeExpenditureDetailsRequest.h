//
//  LDRIncomeExpenditureDetailsRequest.h
//  LDRenting
//
//  Created by MAC on 2020/8/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"
#import "LDRMybillModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LDRIncomeExpenditureDetailsRequest : BaseRequest
CopyStringProperty houseId;
CopyStringProperty month;
@end

NS_ASSUME_NONNULL_END
