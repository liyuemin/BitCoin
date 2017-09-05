//
//  MSWebViewController.m
//  MSVideo
//
//  Created by mai on 17/7/14.
//  Copyright © 2017年 yuemin li. All rights reserved.
//

#import "MSWebViewController.h"
#import "MSWebViewModel.h"
#import "UIView+YYAdd.h"

@interface MSWebViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) JSContext *context;

@property (nonatomic, strong) UIWebView *contentWebView;

@property (nonatomic, strong) MSWebViewModel *webViewModel;



@end

@implementation MSWebViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setWebUI];
    
    self.webViewModel = [[MSWebViewModel alloc]init];
    
    [self loadPage];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIWebView *)contentWebView
{
    if (!_contentWebView)
    {
        CGRect tmpRect = self.view.bounds;
        
        if (self.haveMyNavBar)
        {
            tmpRect.origin.y = 65;
            tmpRect.size.height -= 65;
        }
        else
        {
            tmpRect.origin.y = 0;
        }
        _contentWebView = [[UIWebView alloc]initWithFrame:tmpRect];
        _contentWebView.backgroundColor = [UIColor clearColor];
        
        _contentWebView.delegate = self;
        
        _contentWebView.scrollView.delegate = self;
        _contentWebView.opaque = NO;
        
        _contentWebView.scalesPageToFit = YES;
    }
    return _contentWebView;
}


- (void)setWebUI
{
    if (self.webTitle)
    {
        self.navBar.topItem.title = self.webTitle;
    }
    else if (self.webDefaultTitle)
    {
        self.navBar.topItem.title = self.webDefaultTitle;
    }
    
    [self.view addSubview:self.contentWebView];
    
    UIButton * backBtn = [[UIButton alloc]init];
    [backBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [backBtn setTitleColor:Sys_Nav_Title_Color forState:UIControlStateNormal];
    [backBtn sizeToFit];
    [backBtn addTarget:self action:@selector(goClose) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:TOPBAR_BACKEDGE];
    self.navBar.topItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}


//加载网页
- (void)loadPage
{
    NSLog(@"load:%@",self.contentWebView.request.URL);
    
    if (!self.webUrlString)
    {
        return;
    }
    [self showHudAction];
    if (!self.contentWebView.request || self.contentWebView.request.URL.absoluteString.length == 0)
    {
        if (![self.webUrlString containsString:@"openWithApp=YES"])
        {
            if ([self.webUrlString containsString:@"?"])
            {
                NSString *tmpString = [NSString stringWithFormat:@"%@&openWithApp=YES",self.webUrlString];
                self.webUrlString = tmpString;
            }
            else
            {
                NSString *tmpString = [NSString stringWithFormat:@"%@?openWithApp=YES",self.webUrlString];
                self.webUrlString = tmpString;
            }
        }
        
        NSURL *url = [self extendUrlWithInitUrl:self.webUrlString];
        
        NSLog(@"lipeiranweburl is1:%@",url);
        
        [self loadUrl:url];
    }
    else
    {
        NSLog(@"lipeiranweburl is2:%@",self.contentWebView.request.URL);
        
        [self loadUrl:self.contentWebView.request.URL];
    }
}

- (NSURL *)extendUrlWithInitUrl:(NSString *)tmpUrlString
{
    NSURL * tmpUrl = [[NSURL alloc]initWithString:tmpUrlString];
    
    return tmpUrl;
}

-(void)loadUrl:(NSURL*)url

{    //[self.loadHUD show:YES];
    [self.HUD showAnimated:YES];
    
    NSDate *date = [NSDate date];
    NSTimeInterval time = [date timeIntervalSince1970]*1000;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:time];
    if ([url.absoluteString containsString:self.webUrlString] && self.postBody)
    {
        if (self.postBody)
        {
            NSString *paramUrl = [APIUrlManager getParamUrlSring:self.postBody];
            [request setHTTPMethod: @"POST"];
            NSLog(@"paramUrl is this:%@",paramUrl);
            [request setHTTPBody: [paramUrl dataUsingEncoding: NSUTF8StringEncoding]];
        }
    }
    request.timeoutInterval = 30.0f;
    [self.contentWebView loadRequest:request];
}

- (void)showHudAction
{
    [self.HUD showAnimated:YES];
   // [self.loadHUD show:YES];
}

- (void)hideHudAction
{
    //[self.loadHUD hide:YES];
    [self.HUD hideAnimated:YES];
}

- (void)goClose
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //    [self.loadHUD hide:YES];
    
    NSLog(@"%s",__func__);
    
    NSString *tmpString=[[request.URL absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"tmpstring is:%@",tmpString);
    NSLog(@"lipeiran is:%@",_contentWebView.request.URL);
    NSLog(@"-----title-%@.",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
    NSString *tmpTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (!self.webTitle && tmpTitle && tmpTitle.length)
    {
        [self performSelector:@selector(showMyTitle:) withObject:tmpTitle afterDelay:0.1];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{    //[self.loadHUD hide:YES];
    [self.HUD hideAnimated:YES];
    NSLog(@"%s",__func__);
}

- (void)showMyTitle:(id)tmpObj
{
    self.navBar.topItem.title = [self.contentWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@", [self.contentWebView stringByEvaluatingJavaScriptFromString:@"document.title"]);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
   // [self.loadHUD hide:YES];
    [self.HUD hideAnimated:YES];
    
    if (!self.webTitle)
    {
        [self performSelector:@selector(showMyTitle:) withObject:[webView stringByEvaluatingJavaScriptFromString:@"document.title"] afterDelay:1];
    }
    // 禁用 页面元素选择
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    // 禁用 长按弹出ActionSheet
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 打印异常
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    
    // 以 JSExport 协议关联 native 的方法
    self.context[@"native"] = self.webViewModel;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%s",__func__);
    //[self.loadHUD hide:YES];
    [self.HUD hideAnimated:YES];
}
- (void)goBack{
    
   
    if (self.contentWebView.canGoBack) {
        [self.contentWebView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
