//
//  LDRMyHouseCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/28.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMyHouseCell.h"

@interface LDRMyHouseCell ()
@property (weak, nonatomic) IBOutlet UILabel *bigTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumber;
@property (weak, nonatomic) IBOutlet UIButton *addPeopleButton;
@property (weak, nonatomic) IBOutlet UIButton *bookingButton;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation LDRMyHouseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bigTitleLabel setTextColor:LDR_TextBalckColor];
    [self.addressLabel setTextColor:LDR_TextBalckColor];
    [self.peopleNumber setTextColor:LDR_TextGrayColor];
    
    [self.addPeopleButton setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
    [self.bookingButton setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
    
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:4];
    [self.backView.layer setShadowColor:LDR_shadowColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];
    [self.backView.layer setCornerRadius:LDRRadius];
}
- (IBAction)addPeopleButtonAction:(UIButton *)sender
{
    if (self.didClickAddHouse) {
        self.didClickAddHouse();
    }
}
- (IBAction)bookingButtonAction:(UIButton *)sender
{
    if (self.didClickAddBooking) {
        self.didClickAddBooking();
    }
}

- (void)setDidClickAddHouse:(void (^)(void))didClickAddHouse
{
    _didClickAddHouse = didClickAddHouse;
}
- (void)setDidClickAddBooking:(void (^)(void))didClickAddBooking
{
    _didClickAddBooking = didClickAddBooking;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
