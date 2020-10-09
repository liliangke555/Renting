//
//  LDRBlueToothCell.h
//  LDRenting
//
//  Created by MAC on 2020/7/22.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRBlueToothCell : UITableViewCell

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic,assign) CGFloat singnal;

- (void)didClickAddButton:(void(^)(void))didClick;

@end

NS_ASSUME_NONNULL_END
