//
//  LCWebBrowserViewController.m
//  BaseProject
//
//  Created by bing liu on 2018/10/25.
//  Copyright © 2018 Lovcreate. All rights reserved.
//

#import "LCWebBrowserViewController.h"
#import "UIView+Frame.h"
#import "LoginViewController.h"

typedef void (^ShareBlock)(int parameter);

static NSArray *CacheUrls = nil;

static void *LCWebBrowserContext = &LCWebBrowserContext;

@interface LCWebBrowserViewController () <UIAlertViewDelegate, WKScriptMessageHandler> {
    NSURL *_errorURL;
    
    // 多次提交标示符
    NSInteger submitIndex;
    // 当前页面是否只有返回按钮，没有关闭按钮
    BOOL isBackAction;
}

@property (nonatomic, strong) UIBarButtonItem *backButton, *forwardButton, *refreshButton, *stopButton, *fixedSeparator, *flexibleSeparator;

@property(nonatomic, strong) NSURL *uiWebViewCurrentURL;

@property(nonatomic,assign) NSString *urlId;

@property(nonatomic, strong) WKUserContentController *currentUserContentController;

@property (nonatomic,assign) BOOL isWelfareCentre;

@property (nonatomic, assign) BOOL isKMWebView;

@property (nonatomic, copy)ShareBlock shareBlockSuccess;

@property(nonatomic, copy) NSString *bookReaderType;

@end

@implementation LCWebBrowserViewController

#pragma mark - Static Initializers

+ (LCWebBrowserViewController *)webBrowser {
    return [self webBrowserWithConfiguration:nil];
}

+ (LCWebBrowserViewController *)webBrowserWithConfiguration:(WKWebViewConfiguration *)configuration {
    return [[self alloc] initWithConfiguration:configuration];
}

+ (LCWebBrowserViewController *)webBrowserWithUrlString:(NSString *)urlString {
    LCWebBrowserViewController *webBrowser = [self webBrowser];
    if (urlString) {
        [webBrowser loadURLString:urlString];
    }
    return webBrowser;
}

+ (LCWebBrowserViewController *)webBrowserWithTitle:(NSString *)title urlString:(NSString *)urlString{
    LCWebBrowserViewController *webBrowser = [self webBrowser];
    if (title) {
        webBrowser.navigationItem.title = title;
    }
    if (urlString) {
        [webBrowser loadURLString:urlString];
    }
    return webBrowser;
}

#pragma mark - Initializers

- (instancetype)init {
    return [self initWithConfiguration:nil];
}

- (instancetype)initWithConfiguration:(WKWebViewConfiguration *)configuration {
    if(self = [super init]) {
        if([WKWebView class]) {
            
            self.isWelfareCentre = NO;
            
            if(!configuration) {
                configuration = [[WKWebViewConfiguration alloc] init];
            }
            
            WKUserContentController *userContentController = [[WKUserContentController alloc] init];
            
            WKUserScript *userScript = [[WKUserScript alloc] initWithSource:@"function getLoginInfo() { return 'ddddd' }" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
            [userContentController addUserScript:userScript];
            
            // base webview js
            [userContentController addScriptMessageHandler:self name:@"js名字"];
            
            configuration.userContentController = userContentController;
            
            self.currentUserContentController = userContentController;
            _bookWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        }
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isKMWebView = NO;
    
//    self.tintColor = [UIColor whiteColor];
    
    _progressBar = [[UNProgressBar alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height-44 + 42.5, self.view.width, 2)];
    _progressBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    self.navigationController.navigationBar.translucent = NO;
    
    if(_bookWebView) {
        _bookWebView.frame = self.view.bounds;
        _bookWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _bookWebView.navigationDelegate = self;
        _bookWebView.UIDelegate = self;
        _bookWebView.multipleTouchEnabled = YES;
        _bookWebView.scrollView.alwaysBounceVertical = YES;
        _bookWebView.allowsBackForwardNavigationGestures = YES;
        [self.view addSubview:_bookWebView];
    }
    if (_bookWebView) {
        [_bookWebView addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                          options:0
                          context:LCWebBrowserContext];
        [_bookWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:LCWebBrowserContext];
    }
    
    if (self.class == [LoginViewController class]) {
        
    }
    
    [self loadURLString:@"https://www.baidu.com/"];

}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if ([_bookWebView.title isEqualToString:@"指定一个title"]) {
    //通知
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)reloaddelegate{
    [self reload];
}

- (void)willMoveToParentViewController:(UIViewController *)parent{
    
    [super willMoveToParentViewController:parent];
    if(!parent){
        
    }
}

- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
    if(!parent){
        self.isKMWebView = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar addSubview:_progressBar];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_progressBar removeFromSuperview];
}

- (void)dealloc {
    
    if (_bookWebView) {
        [_bookWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
        [_bookWebView removeObserver:self forKeyPath:@"title"];
    }
    
}

#pragma mark - js回调的代理

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *data = message.body;
    //    NSString *mess = message.name;
    if ([message.name isEqualToString:@"js名字"]) {
        if ([data objectForKey:@"urlId"]) {
            self.urlId = [data objectForKey:@"urlId"];
            [self.bookWebView evaluateJavaScript:@"hasFavorite(1)" completionHandler:nil];
        }
    }else if ([message.name isEqualToString:@"reload"]) {
        [self loadURL:self.uiWebViewCurrentURL];
    }
}

#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    completionHandler();
    [[ToastManager sharedInstance] showMessage:@"%@", message];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    completionHandler(NO);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    
//    if ([prompt isEqualToString:@"getLoginInfo"]) {
//        completionHandler([self getLoginInfoString]);
//    }
    
}

#pragma mark - TouristMode

/* 游客模式登录后刷新cookie 和 token
 *
 */
- (void)resignTouristMode {
    [_bookWebView evaluateJavaScript:@"window.webkit.messageHandlers.updateCookies.postMessage(document.cookie);" completionHandler:nil];
    
    [self reload];
}

#pragma mark - Parameters


- (NSURL *)url {
    if (_errorURL) {
        return _errorURL;
    }
    if (_bookWebView) {
        return _bookWebView.URL;
    }
    return nil;
}

#pragma mark - Public Interface

- (void)loadRequest:(NSURLRequest *)request {
    
    self.uiWebViewCurrentURL = request.URL;
    
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:request.URL];
    
    [mutableRequest addValue:[NSString stringWithFormat:@"P=%@", @"11111"] forHTTPHeaderField:@"Cookie"];
    
    if (_bookWebView) {
        [_bookWebView loadRequest:mutableRequest];
    }
}

- (void)loadURL:(NSURL *)URL {
    self.uiWebViewCurrentURL = URL;
    
    [self loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)loadURLString:(NSString *)URLString {
    
#pragma mark - 拼接param
    
    [self loadURL:[NSURL URLWithString: URLString]];
}

- (void)loadHTMLString:(NSString *)HTMLString {
    if(_bookWebView) {
        [_bookWebView loadHTMLString:HTMLString baseURL:nil];
    }
}

- (void)reload {
    if (_bookWebView) {
        [_bookWebView reload];
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    self.navigationController.navigationBar.tintColor = tintColor;
    self.navigationController.toolbar.tintColor = tintColor;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if(webView == _bookWebView) {
//        NSURLRequest *request = navigationAction.request;
//        NSURL *url = request.URL;
//        NSString *urlStr = [NSString stringWithFormat:@"%@",url];
        
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

//scheme判断及处理
- (BOOL)readSchemeUrl:(NSString *)url{
    
    BOOL isReadSchemeUrl = NO;
    if ([url hasPrefix:@"reader://"]) {
        NSString *dataString = [url substringFromIndex:@"reader://".length];
        
        NSRange range = [dataString rangeOfString:@"?"];
        NSString *methodString = @"";
        NSString *paramString = @"";
        if (range.location!=NSNotFound) {
            methodString = [dataString substringToIndex:range.location];
            paramString =  [dataString substringFromIndex:range.location+1];
        }else{
            methodString = [dataString substringFromIndex:0];
        }
        //        if (range.location!=NSNotFound)
        {
            isReadSchemeUrl = YES;
            
            
            NSMutableDictionary *paramsDic = [[NSMutableDictionary alloc] init];
            for (NSString *param in [paramString componentsSeparatedByString:@"&"]) {
                NSArray *elts = [param componentsSeparatedByString:@"="];
                if([elts count] < 2) continue;
                [paramsDic setObject:[elts lastObject] forKey:[elts firstObject]];
            }
            
        }
    } else if ([url hasPrefix:@"wvjbscheme://"]) {
        isReadSchemeUrl = YES;
    }
    return isReadSchemeUrl;
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if(webView == _bookWebView) {
        
        _progressBar.isLoading = YES;
        [_progressBar progressUpdate:.05];
        
        if([_delegate respondsToSelector:@selector(webBrowser:didStartLoadingURL:)]) {
            [_delegate webBrowser:self didStartLoadingURL:_bookWebView.URL];
        }
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (webView == _bookWebView) {
        _progressBar.isLoading = NO;
        
        if([_delegate respondsToSelector:@selector(webBrowser:didFinishLoadingURL:)]) {
            [_delegate webBrowser:self didFinishLoadingURL:_bookWebView.URL];
        }
        _errorURL = nil;
        
        NSString *js = @"document.getElementById('no_search').innerHTML";
        [webView evaluateJavaScript:js completionHandler:^(id pageSource, NSError * _Nullable error) {
            if ([pageSource isEqualToString:@"yes"]) {
                self.navigationItem.rightBarButtonItem = nil;
            }
        }];
        
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    [self webView:webView didFailWithError:error];
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    [self webView:webView didFailWithError:error];
}

- (void)webView:(WKWebView *)webView didFailWithError:(NSError *)error {
    if(webView == _bookWebView) {
        _progressBar.isLoading = NO;
        [_progressBar setProgressZero];
        
        if([_delegate respondsToSelector:@selector(webBrowser:didFailToLoadURL:error:)]) {
            [_delegate webBrowser:self didFailToLoadURL:_bookWebView.URL error:error];
        }
        
        NSString * customURLStr = error.userInfo[@"NSErrorFailingURLStringKey"];
        NSURL * url = [NSURL URLWithString:customURLStr];
        if (![url.scheme hasPrefix:@"http"]) {
            if (url) {
                [[UIApplication sharedApplication] openURL:url];
            }
            return;
        }
        
        if ([error code] == kCFURLErrorCannotFindHost || [error code] == kCFURLErrorNotConnectedToInternet) {
            [self.bookWebView.scrollView setContentOffset:CGPointMake(0, 0)];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"failed-load" ofType:@"htm"];
            NSError *error;
            NSString *htmlString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
            
            [self.bookWebView loadHTMLString:htmlString baseURL:self.bookWebView.URL];
        }
    }
}

#pragma mark - WKUIDelegate

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - NavigationItem

- (void)goBack:(UIButton *)sender {
    [self goBackIfPossible];
    //    if (!_historyEnable) {
    //        [self close];
    //    } else {
    //        [self goBackIfPossible];
    //
    //        if (_showCloseBtn) {
    //            if (self.navigationController &&
    //                self.navigationItem.leftBarButtonItems.count == 1 &&
    //                (_bookWebView.canGoBack)) {
    //                UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    //
    //                UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    //                self.navigationItem.leftBarButtonItems = @[backItem, closeItem];
    //            }
    //        }
    //    }
}

- (void)goBackIfPossible {
    if (_bookWebView) {
        if (_bookWebView.canGoBack) {
           
            [_bookWebView goBack];
            return;
        }
    }
    [self close];
}

- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Estimated Progress KVO (WKWebView)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == _bookWebView &&
        [keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]) {
        double estimatedProgress = [change[@"new"] doubleValue];
        [_progressBar progressUpdate:estimatedProgress];
    } else if (object == _bookWebView && [keyPath isEqualToString:@"title"]) {
        if ([keyPath isEqualToString:@"title"]) {
        }
    } else {
        //        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - External App Support

- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL {
    static NSSet *validSchemes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        validSchemes = [NSSet setWithObjects:@"http", @"https", nil];
    });
    return ![validSchemes containsObject:URL.scheme];
}

#pragma mark - Interface Orientation

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return YES;
}

#pragma mark - 子类需要实现的方法

- (void)loadWebView {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)removeScript {
    if (self.currentUserContentController) {
        [self.currentUserContentController removeScriptMessageHandlerForName:@"hasBookId"];
    }
}


- (NSURLRequest *)loadWebURL:(NSString *)url {
    return [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",url]]];
}
- (void)reloadMKWebView{
    [self reload];
}

- (void)finishLoginSuccessful{
    if (self.currentUserContentController) {
        [self.currentUserContentController removeScriptMessageHandlerForName:@"hasBookId"];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
