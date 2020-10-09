//
//  LDRHouseInfosModel.h
//  LDRenting
//
//  Created by MAC on 2020/8/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "JsonBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRAllRentHouseModel : JsonBaseObject
AssignProperty NSInteger current;
AssignProperty BOOL hitCount;
AssignProperty NSInteger pages;
AssignProperty BOOL searchCount;
AssignProperty NSInteger total;
AssignProperty NSInteger size;
StrongProperty NSArray *records;
@end

@interface LDRRentHouseModel : JsonBaseObject
CopyStringProperty address;
AssignProperty NSInteger bathroomNum;
CopyStringProperty blockName;
AssignProperty NSInteger checkStatus;
CopyStringProperty expTime;
AssignProperty NSInteger hallNum;
CopyStringProperty houseId;
CopyStringProperty houseLayout;
CopyStringProperty houseName;
CopyStringProperty uid;
CopyStringProperty lockType;
CopyStringProperty mac;
CopyStringProperty path1;
AssignProperty NSInteger publishStatus;
CopyStringProperty rentPayInfo;
AssignProperty NSInteger rentPayType;
AssignProperty NSInteger rentedCount;
AssignProperty NSInteger rentedHouseState;
AssignProperty NSInteger roomNum;
@end

NS_ASSUME_NONNULL_END
