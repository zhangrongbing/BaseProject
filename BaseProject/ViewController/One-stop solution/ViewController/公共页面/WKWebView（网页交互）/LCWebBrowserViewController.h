//
//  LCWebBrowserViewController.h
//  BaseProject
//
//  Created by bing liu on 2018/10/25.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "UNProgressBar.h"

//NS_ASSUME_NONNULL_BEGIN

@class LCWebBrowserViewController;

@protocol LCWebBrowserDelegate <NSObject>

@optional
- (void)webBrowser:(LCWebBrowserViewController *)webBrowser didStartLoadingURL:(NSURL *)URL;
- (void)webBrowser:(LCWebBrowserViewController *)webBrowser didFinishLoadingURL:(NSURL *)URL;
- (void)webBrowser:(LCWebBrowserViewController *)webBrowser didFailToLoadURL:(NSURL *)URL error:(NSError *)error;
- (void)webBrowserViewControllerWillDismiss:(LCWebBrowserViewController*)viewController;

@end

@protocol reloadDelegateWithPassid <NSObject>

- (void)reloadDelegateWithPassid:(NSString *)passId;

@end

@interface LCWebBrowserViewController : BaseViewController <UIWebViewDelegate, WKNavigationDelegate, WKUIDelegate>

#pragma mark - Public Properties

@property (nonatomic, weak) id <LCWebBrowserDelegate> delegate;
@property (nonatomic, assign) id <reloadDelegateWithPassid> reloadDelegate;
// The web views
// Depending on the version of iOS, one of these will be set
@property (nonatomic, strong) WKWebView *bookWebView;

- (id)initWithConfiguration:(WKWebViewConfiguration *)configuration NS_AVAILABLE_IOS(8_0);

#pragma mark - Static Initializers

/*
 Initialize a basic KINWebBrowserViewController instance for push onto navigation stack
 
 Ideal for use with UINavigationController pushViewController:animated: or initWithRootViewController:
 
 Optionally specify KINWebBrowser options or WKWebConfiguration
 */

+ (LCWebBrowserViewController *)webBrowser;
+ (LCWebBrowserViewController *)webBrowserWithConfiguration:(WKWebViewConfiguration *)configuration NS_AVAILABLE_IOS(8_0);
+ (LCWebBrowserViewController *)webBrowserWithUrlString:(NSString *)urlString;
+ (LCWebBrowserViewController *)webBrowserWithTitle:(NSString *)title urlString:(NSString *)urlString;

@property (nonatomic, strong) UIColor *tintColor;
//@property (nonatomic, assign) BOOL toolbarHidden;
//@property (nonatomic, assign) BOOL showsURLInNavigationBar;
//@property (nonatomic, assign) BOOL showsPageTitleInNavigationBar;
//@property (nonatomic, assign) BOOL historyEnable;//“返回”时是否回到之前的网页
//@property (nonatomic, assign) BOOL showCloseBtn;
//@property (nonatomic, strong) NSString *backURL;
@property (nonatomic, strong) UNProgressBar *progressBar;   // 进度条

/**
 *  在网页加载失败的情况下，用reload方法无法加载页面
 *  举例：推广首页加载失败的话，即使有网，下拉刷新也不会加载数据
 */
@property (nonatomic, readonly, strong) NSURL *url;

@property (nonatomic, strong) NSString *comicVip;

@property(nonatomic, assign) BOOL isFuliWeb;

@property(nonatomic, assign) BOOL isPushWeb;

#pragma mark - Public Interface

// Load a NSURLURLRequest to web view
// Can be called any time after initialization
- (void)loadRequest:(NSURLRequest *)request;

// Load a NSURL to web view
// Can be called any time after initialization
- (void)loadURL:(NSURL *)URL;

// Loads a URL as NSString to web view
// Can be called any time after initialization
- (void)loadURLString:(NSString *)URLString;

// Loads an string containing HTML to web view
// Can be called any time after initialization
- (void)loadHTMLString:(NSString *)HTMLString;



@end

//NS_ASSUME_NONNULL_END
