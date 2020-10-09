//
//  LDRSendCodeViewCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/12.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSendCodeViewCell.h"

@interface LDRSendCodeViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *codeInput;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation LDRSendCodeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.button setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
    [self.button.layer setCornerRadius:12];
    [self.button.layer setBorderWidth:.5f];
    [self.button.layer setBorderColor:LDR_MainGreenColor.CGColor];
    
    [self.button setTitleColor:LDR_MainGreenGrayColor forState:UIControlStateDisabled];
    
    self.codeInput.delegate =self;
}
- (IBAction)buttonAction:(UIButton *)sender
{
    sender.enabled = NO;
    [self setTime];
}

- (void)setTime
{
    LDRWeakify(self);
    __block  int i = 60;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        i--;
        if (i < 0) {
            //计时器取消
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.button.enabled = YES;
                [weakSelf.button setTitle:@"重新发送" forState:UIControlStateNormal];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.button setTitle:[NSString stringWithFormat:@"%ds",i] forState:UIControlStateDisabled];
            });
        }
    });
    dispatch_resume(timer);
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.didEndEditing) {
        self.didEndEditing(textField.text);
    }
}

- (void)setDidEndEditing:(void (^)(NSString * _Nonnull))didEndEditing
{
    _didEndEditing = didEndEditing;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
