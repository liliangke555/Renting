//
//  LDRRenantsFlagCollectionViewCell.h
//  LDRenting
//
//  Created by MAC on 2020/7/31.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRRenantsFlagCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (nonatomic, assign) LDRFlagType flagType;
@end

NS_ASSUME_NONNULL_END
