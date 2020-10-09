//
//  LDRSliderAlertView.m
//  LDRenting
//
//  Created by MAC on 2020/8/17.
//  Copyright © 2020 LD. All rights reserved.
//

#import "LDRSliderAlertView.h"
#import <WebKit/WebKit.h>

@interface LDRSliderAlertView ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;
@end
@implementation LDRSliderAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.type = LDRPopupTypeAlert;
        self.layer.cornerRadius = LDRControllerRadius;
        self.clipsToBounds = YES;
        self.backgroundColor = LDR_BackgroundColor;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(LDR_WIDTH - 32);
        }];
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
        
        MASViewAttribute *lastAttribute = self.mas_top;
        UILabel *titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).mas_offset(LDRPadding);
            make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, LDRPadding, 0, LDRPadding));
        }];
        [titleLabel setText:@"滑块验证"];
        [titleLabel setTextColor:LDR_TextBalckColor];
        [titleLabel setFont:LDRBoldFont18];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        lastAttribute = titleLabel.mas_bottom;
        
        
         WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userCC = config.userContentController;
//        意思是网页中需要传递的参数是通过这个JS中的appPass方法来传递的
        [userCC addScriptMessageHandler:self name:LDRAliSliderCallBackName];

        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preferences;
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        [self addSubview:webView];
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).mas_offset(LDRPadding);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(64);
        }];
        lastAttribute = webView.mas_bottom;
        NSURL *url = [NSURL URLWithString:LDRAliSliderURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
        webView.navigationDelegate = self;
        webView.UIDelegate= self;
        
        self.webView = webView;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastAttribute).mas_offset(LDRPadding);
        }];
    }
    return self;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self show];
    NSString *str = [NSString stringWithFormat:@"window.getAppKey(\"%@\", \"%@\")",LDRAliSliderKey,LDRAliSliderScene];
    [self.webView evaluateJavaScript:str completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"response:%@,error:%@",response,error);
    }];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if (error) {
        [self hide];
    }
    
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if (error) {
        [self hide];
    }
}
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSLog(@"%@",message);
    NSLog(@"%@",message.body);
    NSLog(@"%@",message.name);
    
    LDRWeakify(self);
    //这个是注入JS代码后的处理效果,尽管html已经有实现了,但是没用,还是执行JS中的实现
    NSDictionary *para = message.body;
    if ([message.name isEqualToString:LDRAliSliderCallBackName]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Get:%@", para);
            if (weakSelf.didSuccessCallBack) {
                weakSelf.didSuccessCallBack(para);
            }
        });
        [self hide];
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
NSLog(@"msg = %@ frmae = %@",message,frame);
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
        NSLog(@"msg = %@ frmae = %@",message,frame);

}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    NSLog(@"msg = %@ ",prompt);
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"sssss");
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)setDidSuccessCallBack:(void (^)(NSDictionary * _Nonnull))didSuccessCallBack
{
    _didSuccessCallBack = didSuccessCallBack;
}
@end
