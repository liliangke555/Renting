//
//  LDRAllRentHouseRequest.h
//  LDRenting
//
//  Created by MAC on 2020/8/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import "BaseRequest.h"
#import "LDRAllRentHouseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LDRAllRentHouseRequest : BaseRequest
AssignProperty NSInteger current;
AssignProperty NSInteger publishStatus;
AssignProperty NSInteger size;
@end

NS_ASSUME_NONNULL_END
