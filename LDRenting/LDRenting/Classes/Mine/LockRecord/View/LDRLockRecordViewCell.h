//
//  LDRLockRecordViewCell.h
//  LDRenting
//
//  Created by MAC on 2020/8/11.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, LDRLockRecordType) {
    LDRLockRecordTypeOpenDoor,
    LDRLockRecordTypeCallPolice,
    LDRLockRecordTypeNotification,
};
@interface LDRLockRecordViewCell : LDRBaseTableViewCell

@property (nonatomic, assign,getter=isLast) BOOL last;
@property (nonatomic, assign) LDRLockRecordType recordType;
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *timeString;
@end

NS_ASSUME_NONNULL_END
