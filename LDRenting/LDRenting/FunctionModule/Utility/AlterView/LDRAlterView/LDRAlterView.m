//
//  LDRAlterView.m
//  LDRenting
//
//  Created by MAC on 2020/7/27.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRAlterView.h"
@interface LDRAlterView()

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *detailLabel;
@property (nonatomic, strong) UIView      *buttonView;

@property (nonatomic, strong) NSArray     *actionItems;
@property (nonatomic, assign,getter=isAgreementType) BOOL agreemnetType;
@property (nonatomic, strong) UIButton *agreeButton;
@property (nonatomic, copy) MMPopupInputHandler inputHandler;

@end
@implementation LDRAlterView

- (instancetype) initWithInputTitle:(NSString *)title
                             detail:(NSString *)detail
                        placeholder:(NSString *)inputPlaceholder
                            handler:(MMPopupInputHandler)inputHandler
{
    LDRAlertConfig *config = [LDRAlertConfig globalConfig];
    
    NSArray *items =@[
                      MMItemMake(config.defaultTextCancel, MMItemTypeHighlight, nil),
                      MMItemMake(config.defaultTextConfirm, MMItemTypeHighlight, nil)
                      ];
    return [self initWithTitle:title
                      setImage:nil
                        detail:detail
                     isWarning:NO
                   agreeString:nil
                     agreement:nil
                         items:items
              inputPlaceholder:inputPlaceholder
                  inputHandler:inputHandler];
}

- (instancetype) initWithInputTitle:(NSString *)title
     detail:(NSString *)detail
items:(NSArray*)items
placeholder:(NSString *)inputPlaceholder
    handler:(MMPopupInputHandler)inputHandler
{
    return [self initWithTitle:title
            setImage:nil
              detail:detail
           isWarning:NO
         agreeString:nil
           agreement:nil
               items:items
    inputPlaceholder:inputPlaceholder
        inputHandler:inputHandler];
}

- (instancetype) initWithConfirmTitle:(NSString*)title
                               detail:(NSString*)detail
{
    LDRAlertConfig *config = [LDRAlertConfig globalConfig];
    
    NSArray *items =@[
                      MMItemMake(config.defaultTextConfirm, MMItemTypeHighlight, nil)
                      ];
    
    return [self initWithTitle:title detail:detail items:items];
}

- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                     isWarning:(BOOL)isWarning
                         items:(NSArray*)items
{
    return [self initWithTitle:title
                      setImage:nil
                        detail:detail
                     isWarning:isWarning
                   agreeString:nil
                     agreement:nil
                         items:items
              inputPlaceholder:nil
                  inputHandler:nil];
}

- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                         items:(NSArray*)items
{
    return [self initWithTitle:title
                      setImage:nil
                        detail:detail
                     isWarning:NO
                   agreeString:nil
                     agreement:nil
                         items:items
              inputPlaceholder:nil
                  inputHandler:nil];
}
- (instancetype) initWithTitle:(NSString*)title
                      setImage:(void(^)(UIImageView *imageView))setImage
                        detail:(NSString*)detail
                         items:(NSArray*)items
{
    return [self initWithTitle:title setImage:setImage detail:detail isWarning:NO agreeString:nil agreement:nil items:items inputPlaceholder:nil inputHandler:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                       detail:(NSString *)detail
                  agreeString:(NSString *)agreeString
                    agreement:(NSString *)agreement
                        items:(NSArray*)items
{
    return [self initWithTitle:title setImage:nil detail:detail isWarning:NO agreeString:agreeString agreement:agreement items:items inputPlaceholder:nil inputHandler:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                     setImage:(void(^)(UIImageView *imageView))setImage
                       detail:(NSString *)detail
                    isWarning:(BOOL)isWarning
                  agreeString:(NSString *)agreeString
                    agreement:(NSString *)agreement
                        items:(NSArray *)items
             inputPlaceholder:(NSString *)inputPlaceholder
                 inputHandler:(MMPopupInputHandler)inputHandler
{
    self = [super init];
    
    if ( self ) {
        NSAssert(items.count>0, @"Could not find any items.");
        
        LDRAlertConfig *config = [LDRAlertConfig globalConfig];
        
        self.type = LDRPopupTypeSheet;
        self.withKeyboard = (inputHandler!=nil);
        
        self.inputHandler = inputHandler;
        self.actionItems = items;
        
        self.layer.cornerRadius = config.cornerRadius;
        self.clipsToBounds = YES;
        self.backgroundColor = config.backgroundColor;
        self.layer.borderWidth = MM_SPLIT_WIDTH;
        self.layer.borderColor = config.splitColor.CGColor;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(config.width);
        }];
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
        
        MASViewAttribute *lastAttribute = self.mas_top;
        if ( title.length > 0 ) {
            self.titleLabel = [UILabel new];
            [self addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(config.innerMargin);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
            }];
            self.titleLabel.textColor = config.titleColor;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.font = [UIFont boldSystemFontOfSize:config.titleFontSize];
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.backgroundColor = self.backgroundColor;
            self.titleLabel.text = title;
            
            lastAttribute = self.titleLabel.mas_bottom;
        }
        
        if (setImage) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).mas_offset(34.0f);
                make.centerX.equalTo(self);
            }];
            setImage(imageView);
            lastAttribute = imageView.mas_bottom;
        }
        
        if ( detail.length > 0 ) {
            self.detailLabel = [UILabel new];
            [self addSubview:self.detailLabel];
            [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(config.innerMargin);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
            }];
            self.detailLabel.textColor = config.detailColor;
            self.detailLabel.textAlignment = NSTextAlignmentCenter;
            self.detailLabel.font = [UIFont systemFontOfSize:config.detailFontSize];
            self.detailLabel.numberOfLines = 0;
            self.detailLabel.backgroundColor = self.backgroundColor;
            
            NSRange range = [detail rangeOfString:@"数据均会被删除"];
            if (range.location != NSNotFound) {
                NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:detail];
                [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0xF25441FF] range:range];
                [self.detailLabel setAttributedText:attri];
            } else {
                NSRange range = [detail rangeOfString:@"请保持蓝牙连接"];
                if (range.location != NSNotFound) {
                    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:detail];
                    [attri addAttribute:NSForegroundColorAttributeName value:LDR_TextBalckColor range:range];
                    [attri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:config.detailFontSize] range:range];
                    [self.detailLabel setAttributedText:attri];
                } else {
                    NSRange rang = [detail rangeOfString:@" 00# "];
                    if (rang.location != NSNotFound) {
                        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:detail];
                        [attri addAttribute:NSForegroundColorAttributeName value:LDR_MainGreenColor range:rang];
                        [attri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:config.detailFontSize] range:rang];
                        [attri addAttribute:NSBackgroundColorAttributeName value:[UIColor colorWithHex:0xF2F2F2FF] range:rang];
                        
                        [self.detailLabel setAttributedText:attri];
                    } else {
                        self.detailLabel.text = detail;
                    }
                }
            }
            
            lastAttribute = self.detailLabel.mas_bottom;
        }
        
        if (agreeString.length > 0) {
            self.agreemnetType = YES;
            UIButton *agreeButton = [UIButton buttonWithTarget:self action:@selector(agreeButtonAction:)];
            [self addSubview:agreeButton];
            [agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_centerX);
                make.top.equalTo(lastAttribute).mas_offset(24);
            }];
            [agreeButton.titleLabel setFont:LDRFont12];
            [agreeButton setTitleColor:LDR_TextBalckColor forState:UIControlStateNormal];
            [agreeButton setImage:[UIImage imageNamed:@"square_normal"] forState:UIControlStateNormal];
            [agreeButton setImage:[UIImage imageNamed:@"square_selected"] forState:UIControlStateSelected];
            [agreeButton setTitle:agreeString forState:UIControlStateNormal];
            
            UIButton *mentButton = [UIButton buttonWithTarget:self action:@selector(mentButtonAction)];
            [self addSubview:mentButton];
            [mentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(agreeButton.mas_right);
                make.centerY.equalTo(agreeButton.mas_centerY);
            }];
            [mentButton.titleLabel setFont:LDRFont12];
            [mentButton setTitleColor:LDR_MainGreenColor forState:UIControlStateNormal];
            [mentButton setTitle:agreement forState:UIControlStateNormal];
            
            lastAttribute = agreeButton.mas_bottom;
        }
        
        if ( self.inputHandler ) {
            self.inputView = [UITextField new];
            [self addSubview:self.inputView];
            [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(config.innerMargin);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin*2, 0, config.innerMargin*2));
                make.height.mas_equalTo(72);
            }];
            self.inputView.backgroundColor = [UIColor colorWithHex:0x0000000C];
            [self.inputView.layer setCornerRadius:4.0f];
            [self.inputView setClipsToBounds:YES];
            self.inputView.enabled = NO;
//            self.inputView.layer.borderWidth = MM_SPLIT_WIDTH;
//            self.inputView.layer.borderColor = config.splitColor.CGColor;
//            self.inputView.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
//            self.inputView.leftViewMode = UITextFieldViewModeAlways;
//            self.inputView.clearButtonMode = UITextFieldViewModeWhileEditing;
            [self.inputView setTextColor:LDR_MainGreenColor];
            [self.inputView setFont:[UIFont boldSystemFontOfSize:40]];
            [self.inputView setTextAlignment:NSTextAlignmentCenter];
//            self.inputView.placeholder = inputPlaceholder;
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.inputView.mas_bottom).mas_offset(config.innerMargin);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin*2, 0, config.innerMargin*2));
            }];
            [label setFont:LDRFont12];
            [label setTextColor:config.detailColor];
            [label setText:inputPlaceholder];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setNumberOfLines:0];
            
            lastAttribute = label.mas_bottom;
        }
        
        self.buttonView = [UIView new];
        [self addSubview:self.buttonView];
        [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).offset(config.innerMargin);
            make.left.right.equalTo(self);
        }];
        
        __block UIButton *firstButton = nil;
        __block UIButton *lastButton = nil;
        for ( NSInteger i = 0 ; i < items.count; ++i )
        {
            MMPopupItem *item = items[i];
            
            UIButton *btn = [UIButton mm_buttonWithTarget:self action:@selector(actionButton:)];
            [self.buttonView addSubview:btn];
            btn.tag = i;
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                if ( items.count <= 2 ){
                    make.top.equalTo(self.buttonView).mas_offset(8);
                    make.bottom.equalTo(self.buttonView);
                    make.height.mas_equalTo(config.buttonHeight);
                    
                    if ( !firstButton ){
                        firstButton = btn;
                        make.left.equalTo(self.buttonView.mas_left).offset(LDRPadding);
                    } else {
                        make.left.equalTo(lastButton.mas_right).offset(LDRPadding);
                        make.width.equalTo(firstButton);
                    }
                } else {
                    make.left.right.equalTo(self.buttonView);
                    make.height.mas_equalTo(config.buttonHeight);
                    
                    if ( !firstButton ) {
                        firstButton = btn;
                        make.top.equalTo(self.buttonView.mas_top).offset(-MM_SPLIT_WIDTH);
                    } else {
                        make.top.equalTo(lastButton.mas_bottom).offset(-MM_SPLIT_WIDTH);
                        make.width.equalTo(firstButton);
                    }
                }
                lastButton = btn;
            }];
            
            [btn setTitle:item.title forState:UIControlStateNormal];
            [btn.layer setCornerRadius:LDRRadius];
            [btn setClipsToBounds:YES];
            if (item == items.lastObject) {
                if (self.isAgreementType) {
                    [btn setBackgroundImage:[UIImage mm_imageWithColor:LDR_MainGreenGrayColor] forState:UIControlStateDisabled];
                    btn.enabled = NO;
                }
                [btn setBackgroundImage:[UIImage mm_imageWithColor:isWarning? LDR_MainWarnningColor : LDR_MainGreenColor] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage mm_imageWithColor:config.itemPressedColor] forState:UIControlStateHighlighted];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            } else {
                [btn setBackgroundImage:[UIImage mm_imageWithColor:LDR_GrayColor] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage mm_imageWithColor:config.itemPressedColor] forState:UIControlStateHighlighted];
                [btn setTitleColor:item.highlight?config.itemHighlightColor:config.itemNormalColor forState:UIControlStateNormal];
            }
            btn.titleLabel.font = (item==items.lastObject)?[UIFont boldSystemFontOfSize:config.buttonFontSize]:[UIFont systemFontOfSize:config.buttonFontSize];
        }
        [lastButton mas_updateConstraints:^(MASConstraintMaker *make) {
            
            if ( items.count <= 2 ) {
                make.right.equalTo(self.buttonView.mas_right).offset(-LDRPadding);
            } else {
                make.bottom.equalTo(self.buttonView.mas_bottom).offset(-LDRPadding);
            }
            
        }];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.buttonView.mas_bottom).mas_offset(LDRPadding);
            
        }];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)actionButton:(UIButton*)btn
{
    MMPopupItem *item = self.actionItems[btn.tag];
    
    if ( item.disabled )
    {
        return;
    }
    
    if ( self.withKeyboard && (btn.tag==1) )
    {
        if ( self.inputView.text.length > 0 )
        {
            [self hide];
        }
    }
    else
    {
        [self hide];
    }
    
    if ( self.inputHandler && (btn.tag>0) )
    {
        self.inputHandler(self.inputView.text);
    }
    else
    {
        if ( item.handler )
        {
            item.handler(btn.tag);
        }
    }
}

- (void)agreeButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    UIButton *button = [self viewWithTag:self.actionItems.count-1];
    button.enabled = sender.isSelected;
}
- (void)mentButtonAction
{
    if ([self.delegate respondsToSelector:@selector(checkAgreement)]) {
        [self.delegate checkAgreement];
    }
}

- (void)notifyTextChange:(NSNotification *)n
{
    if ( self.maxInputLength == 0 )
    {
        return;
    }
    
    if ( n.object != self.inputView )
    {
        return;
    }
    
    UITextField *textField = self.inputView;
    
    NSString *toBeString = textField.text;

    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (toBeString.length > self.maxInputLength) {
            textField.text = [toBeString mm_truncateByCharLength:self.maxInputLength];
        }
    }
}

- (void)showKeyboard
{
//    [self.inputView becomeFirstResponder];
}

- (void)hideKeyboard
{
//    [self.inputView resignFirstResponder];
}

@end


@interface LDRAlertConfig()

@end

@implementation LDRAlertConfig

+ (LDRAlertConfig *)globalConfig
{
    static LDRAlertConfig *config;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        config = [LDRAlertConfig new];
        
    });
    
    return config;
}

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        self.width          = LDR_WIDTH - 32;
        self.buttonHeight   = 48.0f;
        self.innerMargin    = 24.0f;
        self.cornerRadius   = 12.0f;

        self.titleFontSize  = 18.0f;
        self.detailFontSize = 14.0f;
        self.buttonFontSize = 17.0f;
        
        self.backgroundColor    = MMHexColor(0xFFFFFFFF);
        self.titleColor         = MMHexColor(0x303331FF);
        self.detailColor        = MMHexColor(0x626664FF);
        self.splitColor         = MMHexColor(0xCCCCCCFF);

        self.itemNormalColor    = MMHexColor(0x626664FF);
        self.itemHighlightColor = MMHexColor(0xE76153FF);
        self.itemPressedColor   = MMHexColor(0xEFEDE7FF);
        
        self.defaultTextOK      = @"好";
        self.defaultTextCancel  = @"取消";
        self.defaultTextConfirm = @"确定";
    }
    
    return self;
}

@end

