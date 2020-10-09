//
//  LDRHomeLoginHeaderView.m
//  LDRenting
//
//  Created by MAC on 2020/7/16.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRHomeLoginHeaderView.h"
#import "LDRCollectionIndexCountModel.h"
@interface LDRHomeLoginHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeMessageButton;
@property (weak, nonatomic) IBOutlet UIButton *addLockButton;
@property (weak, nonatomic) IBOutlet UIImageView *messageBackImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomBackView;
@property (weak, nonatomic) IBOutlet UIButton *helpButton;
@property (weak, nonatomic) IBOutlet UILabel *totalIncomeLabel;
@property (weak, nonatomic) IBOutlet UIView *checkMoneyButton;
@property (weak, nonatomic) IBOutlet UIButton *myBillButton;
@property (weak, nonatomic) IBOutlet UILabel *rentingIncomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *myCardLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitBonusLabel;
@property (weak, nonatomic) IBOutlet UIButton *profitBonusButton;
@property (nonatomic, strong) CAGradientLayer *gradient;

@end

@implementation LDRHomeLoginHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupView];
}
- (void)setupView
{
    [self.myBillButton setClipsToBounds:YES];
    self.profitBonusLabel.userInteractionEnabled = YES;
    [self.profitBonusLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profitBonusButtonAction:)]];
    [self.profitBonusButton setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    
    [self.totalIncomeLabel setFont:LDRHomeNumberFont24];
    [self.rentingIncomeLabel setFont:LDRHomeNumberFont18];
    [self.profitBonusLabel setFont:LDRHomeNumberFont18];
    [self.myCardLabel setFont:LDRHomeNumberFont18];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //渐变色
//    gradient.frame = self.bounds;
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0x263345FF] CGColor], (id)[[UIColor colorWithHex:0x4F5D70FF] CGColor],nil];
    [self.layer insertSublayer:gradient atIndex:0];
    self.gradient = gradient;
}
- (IBAction)profitBonusButtonAction:(id)sender
{
    NSLog(@"--- 收益分红 ---");
    if ([self.delegate respondsToSelector:@selector(didClickProfit)]) {
        [self.delegate didClickProfit];
    }
}
- (IBAction)myBillButtonAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(didClickMyBill)]) {
        [self.delegate didClickMyBill];
    }
}
- (IBAction)checkMoneyButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        self.totalIncomeLabel.text = @"****";
        self.rentingIncomeLabel.text = @"****";
        self.profitBonusLabel.text = @"****";
    } else {
        [self.totalIncomeLabel setText:[NSString stringWithFormat:@"%.2f",self.moneyCount]];
        [self.rentingIncomeLabel setText:[NSString stringWithFormat:@"%.2f",[self.model.rentCollectionCount floatValue]]];
        [self.profitBonusLabel setText:[NSString stringWithFormat:@"%.2f",[self.model.earningsCount floatValue]]];
    }
}
- (IBAction)helpButtonAction:(UIButton *)sender
{
    LDRExplainAlertView *alertView = [[LDRExplainAlertView alloc] initWithTitle:@"累计收入说明" details:@"说明：\n统计一个自然年（12个月）内，由租房产生的收益（房租收益、分红收益）总和"];
    [alertView show];
}
- (IBAction)addLockButtonAction:(UIButton *)sender
{
}
- (IBAction)closeMessageButtonAction:(UIButton *)sender
{
    self.messageBackImageView.hidden = YES;
    self.messageLabel.hidden = YES;
    sender.hidden = YES;
}
#pragma mark - Setter
- (void)setModel:(LDRCollectionIndexCountModel *)model
{
    _model = model;
    if (model) {
        [self.myCardLabel setText:[NSString stringWithFormat:@"%ld",model.cardCount]];
        [self.rentingIncomeLabel setText:[NSString stringWithFormat:@"%.2f",[model.rentCollectionCount floatValue]]];
        [self.profitBonusLabel setText:[NSString stringWithFormat:@"%.2f",[model.earningsCount floatValue]]];
    }
}
- (void)setMoneyCount:(CGFloat)moneyCount
{
    _moneyCount = moneyCount;
    [self.totalIncomeLabel setText:[NSString stringWithFormat:@"%.2f",moneyCount]];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gradient.frame = self.bounds;
    [self.bottomBackView clipCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                              radius:LDRRadius + 2];
    [self.myBillButton clipCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                            radius:LDRRadius];
}

@end
