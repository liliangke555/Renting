//
//  LDROfflineOpenTableCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/31.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDROfflineOpenTableCell.h"

@interface LDROfflineOpenTableCell ()
@property (weak, nonatomic) IBOutlet UIButton *openFingerButton;
@property (weak, nonatomic) IBOutlet UIButton *openICCardButton;
@property (weak, nonatomic) IBOutlet UIView *fingerBackView;
@property (weak, nonatomic) IBOutlet UIView *icCardBackView;

@end

@implementation LDROfflineOpenTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.icCardBackView.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.icCardBackView.layer setShadowRadius:LDRShadowRadius];
    [self.icCardBackView.layer setShadowColor:LDR_shadowBottomColor.CGColor];
    [self.icCardBackView.layer setShadowOpacity:1.0f];
    [self.icCardBackView.layer setCornerRadius:LDRRadius];
    [self.icCardBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iccardDidClickAction:)]];
    
    [self.fingerBackView.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.fingerBackView.layer setShadowRadius:LDRShadowRadius];
    [self.fingerBackView.layer setShadowColor:LDR_shadowBottomColor.CGColor];
    [self.fingerBackView.layer setShadowOpacity:1.0f];
    [self.fingerBackView.layer setCornerRadius:LDRRadius];
    [self.fingerBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerDidClickAction:)]];
}
- (void)fingerDidClickAction:(UITapGestureRecognizer *)sender
{
    if (self.didClickFinger) {
        self.didClickFinger();
    }
}
- (void)iccardDidClickAction:(UITapGestureRecognizer *)sender
{
    if (self.didClickicCard) {
        self.didClickicCard();
    }
}
- (void)setDidClickFinger:(void (^)(void))didClickFinger
{
    _didClickFinger = didClickFinger;
}
- (void)setDidClickicCard:(void (^)(void))didClickicCard
{
    _didClickicCard = didClickicCard;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
