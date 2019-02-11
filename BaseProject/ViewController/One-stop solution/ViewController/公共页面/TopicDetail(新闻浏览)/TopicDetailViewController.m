//
//  TopicDetailViewController.m
//  BaseProject
//
//  Created by 张熔冰 on 2019/1/31.
//  Copyright © 2019年 Lovcreate. All rights reserved.
//

#import "TopicDetailViewController.h"
#import <WebKit/WebKit.h>
#import "UIView+Addition.h"

#define kUrl_JianShu @"https://www.jianshu.com/p/f31e39d3ce41"
#define kKeyPath_WebView @"scrollView.contentSize"
#define kKeyPath_TableView @"contentSize"

@interface TopicDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, WKNavigationDelegate>

@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIScrollView *containerView;

@end

@implementation TopicDetailViewController{
    CGFloat lastWebViewContentHeight;
    CGFloat lastTableViewContentHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self addObservers];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kUrl_JianShu]];
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    [self.webView loadRequest:request];
}

-(void)dealloc{
    DebugLog(@"");
    [self removeObservers];
}

#pragma mark - Observers
-(void)addObservers{
    [self.webView addObserver:self forKeyPath:kKeyPath_WebView options:NSKeyValueObservingOptionNew context:nil];
    [self.tableView addObserver:self forKeyPath:kKeyPath_TableView options:NSKeyValueObservingOptionNew context:nil];
}

-(void)removeObservers{
    [self.webView removeObserver:self forKeyPath:kKeyPath_WebView];
    [self.tableView removeObserver:self forKeyPath:kKeyPath_TableView];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self updateContainerSubViewFrame];
}

-(void)updateContainerSubViewFrame{
    CGFloat webViewContentHeight = self.webView.scrollView.contentSize.height;
    CGFloat tableViewContentHeight = self.tableView.contentSize.height;
    
    if (webViewContentHeight == lastWebViewContentHeight && tableViewContentHeight == lastTableViewContentHeight) {
        return;
    }
    
    lastWebViewContentHeight = webViewContentHeight;
    lastTableViewContentHeight = tableViewContentHeight;
    
    self.containerView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), webViewContentHeight + tableViewContentHeight);
    CGFloat webViewHeight = (webViewContentHeight < self.view.height) ?webViewContentHeight :self.view.height;
    CGFloat tableViewHeight = tableViewContentHeight < self.view.height ?tableViewContentHeight :self.view.height;
    self.webView.height = webViewHeight <= 0.1 ?0.1 :webViewHeight;
    
    self.tableView.height = tableViewHeight;
    self.tableView.top = self.webView.bottom;
    
    [self scrollViewDidScroll:self.containerView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_containerView != scrollView) {
        return;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat webViewHeight = self.webView.height;
    CGFloat tableViewHeight = self.tableView.height;
    
    CGFloat webViewContentHeight = self.webView.scrollView.contentSize.height;
    CGFloat tableViewContentHeight = self.tableView.contentSize.height;
    //TODO: webview 高度小于屏幕高度
    if (offsetY <= 0) {
        self.webView.top = 0.f;
        self.webView.scrollView.contentOffset = CGPointZero;
        self.tableView.contentOffset = CGPointZero;
    }else if(offsetY  < webViewContentHeight - webViewHeight){
        self.webView.top = offsetY;
        self.tableView.top = self.webView.bottom;
        self.webView.scrollView.contentOffset = CGPointMake(0, offsetY);
        self.tableView.contentOffset = CGPointZero;
    }else if(offsetY < webViewContentHeight){
        self.webView.top = webViewContentHeight - webViewHeight;
        self.tableView.top = self.webView.bottom;
        self.webView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);
        self.tableView.contentOffset = CGPointZero;
    }else if(offsetY < webViewContentHeight + tableViewContentHeight - tableViewHeight){
        self.webView.top = offsetY - webViewHeight;
        self.tableView.top = self.webView.bottom;
        self.tableView.contentOffset = CGPointMake(0, offsetY - webViewContentHeight);
        self.webView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);
    }else if(offsetY <= webViewContentHeight + tableViewContentHeight ){
        self.webView.top = webViewContentHeight + tableViewContentHeight - webViewHeight - webViewHeight;
        self.tableView.top = self.webView.bottom;
        self.webView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);
        self.tableView.contentOffset = CGPointMake(0, tableViewContentHeight - tableViewHeight);
    }else {
        //do nothing
        NSLog(@"do nothing");
    }
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

static NSString *CellIdentifier = @"Cell";
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"我爱我的祖国";
    return cell;
}

#pragma mark - Public
-(void)initView{
    [self.containerView addSubview:self.webView];
    [self.containerView addSubview:self.tableView];
    [self.view addSubview:self.containerView];
    
    self.webView.top = 0;
    self.webView.height = self.view.height;
    self.tableView.top = self.webView.bottom;
}

#pragma mark - Getter and Setter
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}

-(UIScrollView *)containerView{
    if (!_containerView) {
        _containerView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [_containerView setShowsHorizontalScrollIndicator:NO];
        [_containerView setAlwaysBounceVertical:YES];
        _containerView.delegate = self;
    }
    return _containerView;
}

-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.safeTop_bounds];
        _webView.scrollView.scrollEnabled = NO;
        _webView.navigationDelegate = self;
    }
    return _webView;
}
@end
