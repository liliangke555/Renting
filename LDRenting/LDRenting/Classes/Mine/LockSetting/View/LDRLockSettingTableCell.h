//
//  LDRLockSettingTableCell.h
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRShadowTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRLockSettingTableCell : LDRShadowTableViewCell
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *imageString;
@property (nonatomic, assign,getter=isOpen) BOOL open;
@end

NS_ASSUME_NONNULL_END
