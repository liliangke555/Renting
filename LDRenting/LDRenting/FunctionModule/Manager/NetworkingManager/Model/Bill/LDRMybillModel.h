//
//  LDRMybillModel.h
//  LDRenting
//
//  Created by MAC on 2020/8/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "JsonBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRMybillModel : JsonBaseObject
CopyStringProperty dayName;
StrongNumberProperty expenditure;
StrongNumberProperty income;
StrongProperty NSArray *userCashbookDetailsRespVos;
@end

@interface LDRMybillDetailModel : JsonBaseObject
AssignProperty NSInteger billType;
CopyStringProperty billTypeName;
CopyStringProperty bookDate;
StrongNumberProperty bookMoney;
AssignProperty NSInteger bookingType;
CopyStringProperty bookingTypeName;
CopyStringProperty createTime;
CopyStringProperty createTimeName;
CopyStringProperty houseId;
CopyStringProperty houseName;
CopyStringProperty memo;
CopyStringProperty uid;
@end
NS_ASSUME_NONNULL_END
