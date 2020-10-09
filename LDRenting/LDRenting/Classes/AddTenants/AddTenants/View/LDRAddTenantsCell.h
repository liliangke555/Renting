//
//  LDRAddTenantsCell.h
//  LDRenting
//
//  Created by MAC on 2020/7/29.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRAddTenantsCell : LDRBaseTableViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@end

NS_ASSUME_NONNULL_END
