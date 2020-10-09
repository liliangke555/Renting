//
//  LDRFeedBackTypeTableCell.h
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRFeedBackTypeTableCell : LDRBaseTableViewCell
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *typeString;
//@property (nonatomic,getter=isSelected) BOOL selected;
@end

NS_ASSUME_NONNULL_END
