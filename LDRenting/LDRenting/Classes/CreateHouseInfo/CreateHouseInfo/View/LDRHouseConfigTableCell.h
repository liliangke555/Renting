//
//  LDRHouseConfigTableCell.h
//  LDRenting
//
//  Created by MAC on 2020/8/4.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRHouseConfigTableCell : LDRBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign,getter=isCheck) BOOL check;
@end

NS_ASSUME_NONNULL_END
