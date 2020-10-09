//
//  LDRInputInfoCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/22.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRInputInfoCell.h"

@interface LDRInputInfoCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *bigTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation LDRInputInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bigTitleLabel setTextColor:LDR_TextBalckColor];
    [self.textField setTextColor:LDR_TextBalckColor];
    self.textField.delegate = self;
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.didEndEidting) {
        self.didEndEidting(textField.text);
    }
}
#pragma mark - Setter

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.bigTitleLabel.text = title;
}
- (void)setDetail:(NSString *)detail
{
    _detail = detail;
    [self.textField setText:detail];
}
- (void)setPlacehold:(NSString *)placehold
{
    _placehold = placehold;
    [self.textField setPlaceholder:placehold];
}
- (void)setEnable:(BOOL)enable
{
    _enable = enable;
    self.textField.userInteractionEnabled = enable;
    if (enable) {
        [self setAccessoryType:UITableViewCellAccessoryNone];
    } else {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
}
- (void)setRightString:(NSString *)rightString
{
    _rightString = rightString;
    [self.rightLabel setText:rightString];
}
- (void)setDidEndEidting:(void (^)(NSString * _Nonnull))didEndEidting
{
    _didEndEidting = didEndEidting;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
