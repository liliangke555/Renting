//
//  LDRInputInfoCell.h
//  LDRenting
//
//  Created by MAC on 2020/7/22.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRInputInfoCell : UITableViewCell
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *rightString;
@property (nonatomic, copy) NSString *placehold;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, copy) void(^didEndEidting)(NSString *string);
@end

NS_ASSUME_NONNULL_END
