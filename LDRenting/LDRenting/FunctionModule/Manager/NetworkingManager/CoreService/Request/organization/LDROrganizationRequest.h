//
//  LDROrganizationRequest.h
//  LDRenting
//
//  Created by MAC on 2020/8/25.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDROrganizationRequest : BaseRequest
CopyStringProperty base64;
CopyStringProperty idCardSide;
@end


@interface LDROrganizationLocationModel : JsonBaseObject
AssignProperty NSInteger height;
AssignProperty NSInteger left;
AssignProperty NSInteger top;
AssignProperty NSInteger width;
@end

@interface LDROrganizationAddressModel : JsonBaseObject
CopyStringProperty words;
StrongProperty LDROrganizationLocationModel *location;
@end

@interface LDROrganizationResultModel : JsonBaseObject
StrongProperty LDROrganizationAddressModel *address;
StrongProperty LDROrganizationAddressModel *birhtday;
StrongProperty LDROrganizationAddressModel *certificateNo;
StrongProperty LDROrganizationAddressModel *identificationEdDate;
StrongProperty LDROrganizationAddressModel *identificationStDate;
StrongProperty LDROrganizationAddressModel *issuingAuthority;
StrongProperty LDROrganizationAddressModel *name;
StrongProperty LDROrganizationAddressModel *nation;
StrongProperty LDROrganizationAddressModel *sex;
@end


@interface LDROrganizationModel : JsonBaseObject
AssignProperty NSInteger direction;
CopyStringProperty image_status;
AssignProperty NSInteger log_id;
AssignProperty NSInteger words_result_num;
StrongProperty LDROrganizationResultModel *words_result;
@end

NS_ASSUME_NONNULL_END
