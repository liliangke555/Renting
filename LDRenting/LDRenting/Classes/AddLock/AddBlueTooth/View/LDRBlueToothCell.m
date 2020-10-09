//
//  LDRBlueToothCell.m
//  LDRenting
//
//  Created by MAC on 2020/7/22.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRBlueToothCell.h"

@interface LDRBlueToothCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UILabel *macLabel;
@property (weak, nonatomic) IBOutlet UILabel *signalLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *signalOne;
@property (weak, nonatomic) IBOutlet UIView *signalTwo;
@property (weak, nonatomic) IBOutlet UIView *signalThree;
@property (weak, nonatomic) IBOutlet UIView *signalFrou;

@property (nonatomic, copy) void(^didClick)(void);

@end

@implementation LDRBlueToothCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setBackgroundColor:LDR_BackgroundColor];
    [self.macLabel setTextColor:LDR_TextBalckColor];
    [self.signalLabel setTextColor:LDR_TextDarkGrayColor];
    [self.addButton setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
    [self.addButton setTitle:@"添加" forState:UIControlStateNormal];
    
    [self.backView.layer setCornerRadius:LDRRadius];
    [self.backView.layer setShadowOffset:CGSizeZero];
    [self.backView.layer setShadowRadius:LDRShadowRadius];
    [self.backView.layer setShadowColor:LDR_GrayColor.CGColor];
    [self.backView.layer setShadowOpacity:1.0f];

    [self.signalOne.layer setCornerRadius:1];
    [self.signalTwo.layer setCornerRadius:1];
    [self.signalThree.layer setCornerRadius:1];
    [self.signalFrou.layer setCornerRadius:1];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}
- (IBAction)addButtonAction:(UIButton *)sender
{
    if (self.didClick) {
        self.didClick();
    }
}
- (void)didClickAddButton:(void (^)(void))didClick
{
    _didClick = didClick;
}
#pragma mark - Getter

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    [self.macLabel setText:[NSString stringWithFormat:@"MAC：%@",titleString]];
}
- (void)setSingnal:(CGFloat)singnal
{
    _singnal = singnal;
    [self.signalLabel setText:[NSString stringWithFormat:@"%0.f%%",singnal*100]];
    if (singnal > 0.75 && singnal <= 1) {
        [self.signalOne setBackgroundColor:LDR_MainGreenColor];
        [self.signalTwo setBackgroundColor:LDR_MainGreenColor];
        [self.signalThree setBackgroundColor:LDR_MainGreenColor];
        [self.signalFrou setBackgroundColor:LDR_TextLightGrayColor];
    } else if (singnal > 0.5 && singnal <= 0.75) {
        [self.signalOne setBackgroundColor:LDR_MainGreenColor];
        [self.signalTwo setBackgroundColor:LDR_MainGreenColor];
        [self.signalThree setBackgroundColor:LDR_TextLightGrayColor];
        [self.signalFrou setBackgroundColor:LDR_TextLightGrayColor];
    } else if (singnal > 0.25 && singnal <= 0.5) {
        [self.signalOne setBackgroundColor:LDR_MainGreenColor];
        [self.signalTwo setBackgroundColor:LDR_TextLightGrayColor];
        [self.signalThree setBackgroundColor:LDR_TextLightGrayColor];
        [self.signalFrou setBackgroundColor:LDR_TextLightGrayColor];
    } else {
        [self.signalOne setBackgroundColor:LDR_TextLightGrayColor];
        [self.signalTwo setBackgroundColor:LDR_TextLightGrayColor];
        [self.signalThree setBackgroundColor:LDR_TextLightGrayColor];
        [self.signalFrou setBackgroundColor:LDR_TextLightGrayColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
