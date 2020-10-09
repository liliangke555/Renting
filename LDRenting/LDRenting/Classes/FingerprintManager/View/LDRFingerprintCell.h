//
//  LDRFingerprintCell.h
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRShadowTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRFingerprintCell : LDRShadowTableViewCell
@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) void(^didClickDelete)(void);
@end

NS_ASSUME_NONNULL_END
