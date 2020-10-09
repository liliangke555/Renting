//
//  LDRSettingAlterView.h
//  LDRenting
//
//  Created by MAC on 2020/7/24.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRPopupView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDRSettingAlterView : LDRPopupView

- (instancetype)initWithTitle:(NSString *)title
                      details:(NSString *)detail
                         type:(NSString *)type
                    loadImage:(void(^)(UIImageView *imageView))loadImage
                       cancel:(MMPopupItemHandler)cancelHandler;

@property (nonatomic, copy) NSString *typeString;
@property (nonatomic, assign) BOOL isCompletion;
@property (nonatomic, copy) NSString *completionImage;

@end

/**
 *  Global Configuration of MMAlertView.
 */
@interface LDRAlertViewConfig : NSObject

+ (LDRAlertViewConfig*) globalConfig;

@property (nonatomic, assign) CGFloat topInnerMargin;                // Default is 275.
@property (nonatomic, assign) CGFloat width;                // Default is 275.
@property (nonatomic, assign) CGFloat buttonHeight;         // Default is 50.
@property (nonatomic, assign) CGFloat innerMargin;          // Default is 25.
@property (nonatomic, assign) CGFloat cornerRadius;         // Default is 5.

@property (nonatomic, assign) CGFloat titleFontSize;        // Default is 18.
@property (nonatomic, assign) CGFloat detailFontSize;       // Default is 14.
@property (nonatomic, assign) CGFloat buttonFontSize;       // Default is 17.


@property (nonatomic, strong) UIColor *backgroundColor;     // Default is #FFFFFF.
@property (nonatomic, strong) UIColor *headerBackgroundColor;
@property (nonatomic, strong) UIColor *titleColor;          // Default is #333333.
@property (nonatomic, strong) UIColor *detailColor;         // Default is #333333.
@property (nonatomic, strong) UIColor *typeColor;          // Default is #CCCCCC.

@property (nonatomic, strong) UIColor *itemNormalColor;     // Default is #333333. effect with MMItemTypeNormal
@property (nonatomic, strong) UIColor *itemHighlightColor;  // Default is #E76153. effect with MMItemTypeHighlight
@property (nonatomic, strong) UIColor *itemPressedColor;    // Default is #EFEDE7.

@property (nonatomic, strong) NSString *defaultTextCancel;  // Default is "取消".
@property (nonatomic, strong) NSString *defaultTextConfirm; // Default is "确定".

@end

NS_ASSUME_NONNULL_END
