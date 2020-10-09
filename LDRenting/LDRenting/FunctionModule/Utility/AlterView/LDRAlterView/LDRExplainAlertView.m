//
//  LDRExplainAlertView.m
//  LDRenting
//
//  Created by MAC on 2020/7/27.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRExplainAlertView.h"

@interface LDRExplainAlertView ()
@property (nonatomic, copy) NSString *phone;
@end

@implementation LDRExplainAlertView

- (instancetype)initWithTitle:(NSString *)title details:(NSString *)details
{
    self = [super init];
    if (self) {
        self.type = LDRPopupTypeAlert;
        self.layer.cornerRadius = LDRRadius;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(LDR_WIDTH - 2 * LDRPadding);
        }];
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
        
        MASViewAttribute *lastAttribute = self.mas_top;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute);
            make.left.right.equalTo(self);
        }];
        UIImage *img=[UIImage imageNamed:@"alert_header_background"];
        img = [img stretchableImageWithLeftCapWidth:15 topCapHeight:12];
        [imageView setImage:img];
        lastAttribute = imageView.mas_bottom;
        
        if (title.length > 0) {
            
            
            UILabel *label = [[UILabel alloc] init];
            [imageView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageView.mas_top).mas_offset(20);
                make.bottom.equalTo(imageView.mas_bottom).mas_offset(-20);
                make.centerX.equalTo(imageView);
            }];
            [label setText:title];
            [label setFont:LDRFont17];
            [label setNumberOfLines:0];
            [label setTextColor:LDR_BackgroundColor];
        }
        
        UIImageView *bottomView = [[ UIImageView alloc] init];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute);
            make.left.right.equalTo(self);
        }];
        UIImage *bottomImg=[UIImage imageNamed:@"alert_bottom_background"];
        bottomImg = [bottomImg stretchableImageWithLeftCapWidth:15 topCapHeight:12];
        [bottomView setImage:bottomImg];
        bottomView.userInteractionEnabled = YES;
        lastAttribute = bottomView.mas_bottom;
        
        if (details.length > 0) {
            
            UILabel *label = [[UILabel alloc] init];
            [bottomView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bottomView.mas_top).mas_offset(24);
                make.bottom.equalTo(bottomView.mas_bottom).mas_offset(-24);
                make.centerX.equalTo(bottomView);
                make.left.right.equalTo(bottomView).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
            }];
            [label setText:details];
            [label setFont:LDRFont12];
            [label setNumberOfLines:0];
            [label setTextColor:LDR_TextDarkGrayColor];
            [self distinguishPhoneNumLabel:label labelStr:details];
        }
        UIButton *button = [UIButton buttonWithTarget:self action:@selector(buttonAction:)];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).mas_offset(32);
            make.centerX.equalTo(self);
            make.width.height.mas_equalTo(32);
        }];
        [button setImage:[UIImage imageNamed:@"alert_close_icon"] forState:UIControlStateNormal];
        lastAttribute = button.mas_bottom;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(lastAttribute).mas_offset(LDRPadding);
            
        }];
    }
    return self;
}
#pragma mark - IBAction
- (void)buttonAction:(UIButton *)sender
{
    [self hide];
}
#pragma mark -
-(void)distinguishPhoneNumLabel:(UILabel *)label labelStr:(NSString *)labelStr{

    //获取字符串中的电话号码
    NSString *regulaStr = @"\\d{3,4}[- ]?\\d{7,8}";
    NSRange stringRange = NSMakeRange(0, labelStr.length);
    //正则匹配
    NSError *error;

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:labelStr];

    NSRegularExpression *regexps = [NSRegularExpression regularExpressionWithPattern:regulaStr options:0 error:&error];
    if (!error && regexps != nil) {
        [regexps enumerateMatchesInString:labelStr options:0 range:stringRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            
            NSRange phoneRange = result.range;
            //定义一个NSAttributedstring接受电话号码字符串
            
            NSAttributedString *phoneNumber = nil;
            phoneNumber = [str attributedSubstringFromRange:phoneRange];
            self.phone = [phoneNumber string];
            //添加下划线
//            NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//            [str addAttributes:attribtDic range:phoneRange];
            //设置文本中的电话号码显示为黄色
            [str addAttribute:NSForegroundColorAttributeName value:LDR_MainGreenColor range:phoneRange];
            [str addAttribute:NSFontAttributeName value:LDRBoldFont12 range:phoneRange];
            
            label.attributedText = str;
            label.userInteractionEnabled = YES;
            
            //添加手势，可以点击号码拨打电话
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        
            [label addGestureRecognizer:tap];
        
        }];
    }

}
- (void)tapGesture:(UITapGestureRecognizer *)sender
{
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    [self hide];
}
@end
