//
//  LDRLockRecordViewCell.m
//  LDRenting
//
//  Created by MAC on 2020/8/11.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRLockRecordViewCell.h"

@interface LDRLockRecordViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation LDRLockRecordViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.titleLabel setTextColor:LDR_TextBalckColor];
    [self.timeLabel setTextColor:LDR_TextGrayColor];
}
- (void)setLast:(BOOL)last
{
    _last = last;
    if (last) {
        self.lineView.hidden= YES;
    } else {
        self.lineView.hidden= NO;
    }
}
- (void)setRecordType:(LDRLockRecordType)recordType
{
    _recordType = recordType;
    if (recordType == LDRLockRecordTypeOpenDoor) {
        [self.headerImageView setImage:[UIImage imageNamed:@"record_open"]];
    } else if (recordType == LDRLockRecordTypeCallPolice) {
        [self.headerImageView setImage:[UIImage imageNamed:@"record_police"]];
    } else {
        [self.headerImageView setImage:[UIImage imageNamed:@"record_notification"]];
    }
}
- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    [self.titleLabel setText:titleString];
}
- (void)setTimeString:(NSString *)timeString
{
    _timeString = timeString;
    [self.timeLabel setText:timeString];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
