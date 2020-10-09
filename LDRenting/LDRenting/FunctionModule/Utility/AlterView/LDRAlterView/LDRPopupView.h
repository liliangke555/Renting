//
//  LDRPopupView.h
//  LDRenting
//
//  Created by MAC on 2020/8/5.
//  Copyright © 2020 LD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPopupItem.h"
#import "MMPopupWindow.h"
#import "MMPopupCategory.h"
#import "MMPopupDefine.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LDRPopupType) {
    LDRPopupTypeAlert,
    LDRPopupTypeSheet,
    LDRPopupTypeCustom,
};

@class LDRPopupView;

typedef void(^LDRPopupBlock)(LDRPopupView *);
typedef void(^LDRPopupCompletionBlock)(LDRPopupView *, BOOL);

@interface LDRPopupView : UIView
@property (nonatomic, assign, readonly) BOOL           visible;             // default is NO.

@property (nonatomic, strong          ) UIView         *attachedView;       // default is MMPopupWindow. You can attach MMPopupView to any UIView.

@property (nonatomic, assign          ) LDRPopupType    type;                // default is MMPopupTypeAlert.
@property (nonatomic, assign          ) NSTimeInterval animationDuration;   // default is 0.3 sec.
@property (nonatomic, assign          ) BOOL           withKeyboard;        // default is NO. When YES, alert view with be shown with a center offset (only effect with MMPopupTypeAlert).

@property (nonatomic, copy            ) LDRPopupCompletionBlock   showCompletionBlock; // show completion block.
@property (nonatomic, copy            ) LDRPopupCompletionBlock   hideCompletionBlock; // hide completion block

@property (nonatomic, copy            ) LDRPopupBlock   showAnimation;       // custom show animation block.
@property (nonatomic, copy            ) LDRPopupBlock   hideAnimation;       // custom hide animation block.

/**
 *  override this method to show the keyboard if with a keyboard
 */
- (void) showKeyboard;

/**
 *  override this method to hide the keyboard if with a keyboard
 */
- (void) hideKeyboard;


/**
 *  show the popup view
 */
- (void) show;

/**
 *  show the popup view with completiom block
 *
 *  @param block show completion block
 */
- (void) showWithBlock:(LDRPopupCompletionBlock)block;

/**
 *  hide the popup view
 */
- (void) hide;

/**
 *  hide the popup view with completiom block
 *
 *  @param block hide completion block
 */
- (void) hideWithBlock:(LDRPopupCompletionBlock)block;

/**
 *  hide all popupview with current class, eg. [MMAlertview hideAll];
 */
+ (void) hideAll;

@end

NS_ASSUME_NONNULL_END
