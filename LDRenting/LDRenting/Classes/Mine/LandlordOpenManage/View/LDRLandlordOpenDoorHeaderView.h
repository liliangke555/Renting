//
//  LDRLandlordOpenDoorHeaderView.h
//  LDRenting
//
//  Created by MAC on 2020/8/11.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRLandlordOpenDoorHeaderView : UIView
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic,getter=isOpen) BOOL open;
@end

NS_ASSUME_NONNULL_END
