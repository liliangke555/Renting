//
//  LDRLoginTextField.h
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LDRLoginTextField;
@protocol LDRLoginTextFieldDelegate <NSObject>

- (void)didEndEditingCompletion:(LDRLoginTextField *)textField;
- (void)didChangeEditing:(LDRLoginTextField *)textField;

@end

@interface LDRLoginTextField : UITextField

@property (nonatomic, assign) NSInteger maxLen;
@property (nonatomic, weak) id <LDRLoginTextFieldDelegate> ldrDelegate;

@end

NS_ASSUME_NONNULL_END
