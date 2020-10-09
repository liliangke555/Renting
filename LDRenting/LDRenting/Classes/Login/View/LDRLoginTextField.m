//
//  LDRLoginTextField.m
//  LDRenting
//
//  Created by MAC on 2020/7/13.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRLoginTextField.h"

static NSInteger const maxPhoneNumber = 13; //限制手机号长度。因为手机格式为344 所以多两个字符

@interface LDRLoginTextField ()
{
    NSInteger _num;
}

@property (nonatomic, strong) UIView *line;

@end

@implementation LDRLoginTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (self.maxLen == 0) {
            self.maxLen = maxPhoneNumber;
        }
        UIView *line = [[UIView alloc] init];
        self.line = line;
        [self addSubview:line];
        [line setBackgroundColor:LDR_TextGrayColor];
        
        [self addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}


-(void)textFieldDidEditing:(LDRLoginTextField *)textField{
    if ([self.ldrDelegate respondsToSelector:@selector(didChangeEditing:)]) {
        [self.ldrDelegate didChangeEditing:textField];
    }
    if (textField.text.length > _num) {
        if (textField.text.length == 4 || textField.text.length == 9 ) {//输入
            NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
            [str insertString:@" " atIndex:(textField.text.length-1)];
            textField.text = str;
        }
        if (textField.text.length >= self.maxLen ) {//输入完成
            textField.text = [textField.text substringToIndex:self.maxLen];
//                [textField resignFirstResponder];
            if ([self.ldrDelegate respondsToSelector:@selector(didEndEditingCompletion:)]) {
                [self.ldrDelegate didEndEditingCompletion:textField];
            }
        }
        _num = textField.text.length;
        
    }else if (textField.text.length < _num){//删除
        if (textField.text.length == 4 || textField.text.length == 9) {
            textField.text = [NSString stringWithFormat:@"%@",textField.text];
            textField.text = [textField.text substringToIndex:(textField.text.length-1)];
        }
        _num = textField.text.length;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.line.frame = CGRectMake(0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 0.5f);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
