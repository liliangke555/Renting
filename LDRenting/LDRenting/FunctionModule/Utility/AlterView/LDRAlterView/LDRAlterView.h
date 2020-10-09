//
//  LDRAlterView.h
//  LDRenting
//
//  Created by MAC on 2020/7/27.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRPopupView.h"
#import "MMPopupDefine.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^MMPopupInputHandler)(NSString *text);

@protocol LDRAlertDelegate <NSObject>

- (void)checkAgreement;

@end

@interface LDRAlterView : LDRPopupView
@property (nonatomic, assign) NSUInteger maxInputLength;    // default is 0. Means no length limit.
@property (nonatomic, weak) id <LDRAlertDelegate> delegate;
@property (nonatomic, strong) UITextField *inputView;

- (instancetype) initWithInputTitle:(NSString*)title
                             detail:(NSString*)detail
                        placeholder:(NSString*)inputPlaceholder
                            handler:(MMPopupInputHandler)inputHandler;
- (instancetype) initWithInputTitle:(NSString *)title
     detail:(NSString *)detail
items:(NSArray*)items
placeholder:(NSString *)inputPlaceholder
                            handler:(MMPopupInputHandler)inputHandler;

- (instancetype) initWithConfirmTitle:(NSString*)title
                               detail:(NSString*)detail;

- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                         items:(NSArray*)items;

- (instancetype) initWithTitle:(NSString*)title
                      setImage:(void(^)(UIImageView *imageView))setImage
                        detail:(NSString*)detail
                         items:(NSArray*)items;

- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                     isWarning:(BOOL)isWarning
                         items:(NSArray*)items;

- (instancetype)initWithTitle:(NSString *)title
                       detail:(NSString *)detail
                  agreeString:(NSString *)agreeString
                    agreement:(NSString *)agreement
                        items:(NSArray*)items;
@end

/**
 *  Global Configuration of MMAlertView.
 */
@interface LDRAlertConfig : NSObject

+ (LDRAlertConfig*) globalConfig;

@property (nonatomic, assign) CGFloat width;                // Default is 275.
@property (nonatomic, assign) CGFloat buttonHeight;         // Default is 50.
@property (nonatomic, assign) CGFloat innerMargin;          // Default is 25.
@property (nonatomic, assign) CGFloat cornerRadius;         // Default is 5.

@property (nonatomic, assign) CGFloat titleFontSize;        // Default is 18.
@property (nonatomic, assign) CGFloat detailFontSize;       // Default is 14.
@property (nonatomic, assign) CGFloat buttonFontSize;       // Default is 17.

@property (nonatomic, strong) UIColor *backgroundColor;     // Default is #FFFFFF.
@property (nonatomic, strong) UIColor *titleColor;          // Default is #333333.
@property (nonatomic, strong) UIColor *detailColor;         // Default is #333333.
@property (nonatomic, strong) UIColor *splitColor;          // Default is #CCCCCC.

@property (nonatomic, strong) UIColor *itemNormalColor;     // Default is #333333. effect with MMItemTypeNormal
@property (nonatomic, strong) UIColor *itemHighlightColor;  // Default is #E76153. effect with MMItemTypeHighlight
@property (nonatomic, strong) UIColor *itemPressedColor;    // Default is #EFEDE7.

@property (nonatomic, strong) NSString *defaultTextOK;      // Default is "好".
@property (nonatomic, strong) NSString *defaultTextCancel;  // Default is "取消".
@property (nonatomic, strong) NSString *defaultTextConfirm; // Default is "确定".

@end

NS_ASSUME_NONNULL_END
