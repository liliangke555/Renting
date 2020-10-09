//
//  LDRHomeMessageTableViewCell.h
//  LDRenting
//
//  Created by MAC on 2020/7/15.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRHomeMessageTableViewCell : LDRBaseTableViewCell
@property (nonatomic, copy) NSString * _Nonnull titleString;
- (void)setImageToImageView:(void(^)(UIImageView *imageView))setImage;
@end

NS_ASSUME_NONNULL_END
