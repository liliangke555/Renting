//
//  LDRSendCodeViewCell.h
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRSendCodeViewCell : LDRBaseTableViewCell
@property (nonatomic, copy) void(^didEndEditing)(NSString *string);
@end

NS_ASSUME_NONNULL_END
