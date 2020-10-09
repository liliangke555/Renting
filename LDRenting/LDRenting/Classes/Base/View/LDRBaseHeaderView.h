//
//  LDRBaseHeaderView.h
//  LDRenting
//
//  Created by MAC on 2020/7/28.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static CGFloat bottomHeight = 24;
@interface LDRBaseHeaderView : UIView

- (instancetype)initWithTitle:(NSString *)title
                      details:(NSString *)details
                        image:(void(^)(UIImageView *image))setImage;

@end

NS_ASSUME_NONNULL_END
