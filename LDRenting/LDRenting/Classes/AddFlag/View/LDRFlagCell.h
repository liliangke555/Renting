//
//  LDRFlagCell.h
//  LDRenting
//
//  Created by MAC on 2020/8/3.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface LDRFlagCell : UICollectionViewCell
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) LDRFlagType flagType;
@end

NS_ASSUME_NONNULL_END
