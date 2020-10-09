//
//  LDRHouseInfoCollectionCell.h
//  LDRenting
//
//  Created by MAC on 2020/7/22.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRHouseInfoCollectionCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *details;
@property (nonatomic, copy) NSString *imageUrl;

@end

NS_ASSUME_NONNULL_END
