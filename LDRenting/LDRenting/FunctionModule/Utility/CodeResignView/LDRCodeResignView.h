//
//  LDRCodeResignView.h
//  LDRenting
//
//  Created by MAC on 2020/7/14.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CodeResignCompleted)(NSString *content);
typedef void (^CodeResignUnCompleted)(NSString *content);

@interface LDRCodeResignView : UIView

@property (copy, nonatomic) CodeResignCompleted codeResignCompleted;
@property (copy, nonatomic) CodeResignUnCompleted codeResignUnCompleted;

- (void)removeText;
- (instancetype) initWithCodeBits:(NSInteger)codeBits;

@end

NS_ASSUME_NONNULL_END
