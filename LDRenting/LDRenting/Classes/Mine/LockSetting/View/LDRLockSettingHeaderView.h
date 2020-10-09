//
//  LDRLockSettingHeaderView.h
//  LDRenting
//
//  Created by MAC on 2020/8/10.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LDRLockSettingHeaderView : UIView
@property (nonatomic,assign) CGFloat singnal;
@property (nonatomic,assign) CGFloat electricity;
- (void)didClickRecords:(void(^)(void))clickRecord didClickBuleTooth:(void(^)(void))clickBuleTooth didClickPassword:(void(^)(void))clickPassword;
@end

NS_ASSUME_NONNULL_END
