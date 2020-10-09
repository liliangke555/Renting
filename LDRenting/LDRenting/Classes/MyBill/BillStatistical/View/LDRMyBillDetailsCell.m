//
//  LDRMyBillDetailsCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/27.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRMyBillDetailsCell.h"

@interface LDRMyBillDetailsCell ()
@property (weak, nonatomic) IBOutlet UILabel *houseTitleLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *incomeOrExpenditure;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeOrExpenditure;

@end

@implementation LDRMyBillDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.houseTitleLabel setTextColor:LDR_TextBalckColor];
    [self.noteLabel setTextColor:LDR_TextGrayColor];
    [self.timeLabel setTextColor:LDR_TextGrayColor];
    [self.amountLabel setTextColor:LDR_MainGreenColor];
    [self.incomeOrExpenditure.layer setCornerRadius:9.0f];
    [self.incomeOrExpenditure setClipsToBounds:YES];
}

- (void)setIncome:(BOOL)income
{
    _income = income;
    if (income) {
        [self.incomeOrExpenditure setBackgroundColor:LDR_MainGreenColor];
        [self.incomeOrExpenditure setText:@"收"];
        [self.amountLabel setTextColor:LDR_MainGreenColor];
    } else {
        [self.incomeOrExpenditure setBackgroundColor:[UIColor redColor]];
        [self.incomeOrExpenditure setText:@"支"];
        [self.amountLabel setTextColor:[UIColor redColor]];
    }
}

- (void)setHouse:(NSString *)house
{
    _house = house;
    [self.houseTitleLabel setText:house];
}
- (void)setNote:(NSString *)note
{
    _note = note;
    [self.noteLabel setText:note];
}
- (void)setTime:(NSString *)time
{
    _time = time;
    [self.timeLabel setText:time];
}
- (void)setMoney:(NSString *)money
{
    _money = money;
    if (self.income) {
        [self.amountLabel setText:[NSString stringWithFormat:@"+%@",money]];
    } else {
        [self.amountLabel setText:[NSString stringWithFormat:@"-%@",money]];
    }
}
- (void)setCellType:(LDRBillCellType)cellType
{
    _cellType = cellType;
    if (cellType == LDRBillCellRentRecords) {
        [self.noteLabel setFont:LDRFont14];
        [self.noteLabel setTextColor:LDR_TextBalckColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
