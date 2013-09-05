//
//  ElandCaseViewController.m
//  ElandSearch
//
//  Created by aJia on 13/9/5.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "ElandCaseViewController.h"

@interface ElandCaseViewController (){
    AnimateLoadView *_loadView;
    AnimateErrorView *_errorView;
}

@end

@implementation ElandCaseViewController
-(void)dealloc{
    [super dealloc];
    if(_loadView){
        [_loadView release],_loadView=nil;
    }
    if(_errorView){
        [_errorView release],_errorView=nil;
    }

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 公有方法
-(AnimateErrorView*) errorView {
    
    if (!_errorView) {
        _errorView=[[AnimateErrorView alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
        
    }
    return _errorView;
}

-(AnimateLoadView*) loadingView {
    if (!_loadView) {
        _loadView=[[AnimateLoadView alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
        
    }
    return _loadView;
}

-(void) showLoadingAnimated:(BOOL) animated process:(void (^)(AnimateLoadView *showView))process{
    
    AnimateLoadView *loadingView = [self loadingView];
    if (process) {
        process(loadingView);
    }
    loadingView.alpha = 0.0f;
    [self.view addSubview:loadingView];
    [self.view bringSubviewToFront:loadingView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration animations:^{
        loadingView.alpha = 1.0f;
    }];
}

-(void) hideLoadingViewAnimated:(BOOL) animated completed:(void (^)(AnimateLoadView *hideView))complete{
    
    AnimateLoadView *loadingView = [self loadingView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration animations:^{
        loadingView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [loadingView removeFromSuperview];
        if (complete) {
            complete(loadingView);
        }
    }];
}

-(void) showErrorViewAnimated:(BOOL) animated process:(void (^)(AnimateErrorView *errView))process{
    
    AnimateErrorView *errorView = [self errorView];
    if (process) {
        process(errorView);
    }
    errorView.alpha = 0.0f;
    [self.view addSubview:errorView];
    [self.view bringSubviewToFront:errorView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration animations:^{
        errorView.alpha = 1.0f;
    }];
}

-(void) hideErrorViewAnimated:(BOOL) animated completed:(void (^)(AnimateErrorView *errView))complete{
    
    AnimateErrorView *errorView = [self errorView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration animations:^{
        errorView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [errorView removeFromSuperview];
        if (complete) {
            complete(errorView);
        }
    }]; 
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    
    CGRect screnRect=self.view.bounds;
    CGFloat screenW=screnRect.size.width,screenH=screnRect.size.height;
    if (_loadView) {
        CGRect frame=_loadView.frame;
        frame.origin.x=(screenW-frame.size.width)/2.0;
        frame.origin.y=(screenH-frame.size.height)/2.0;
        _loadView.frame=frame;
    }
    if (_errorView) {
        CGRect frame=_errorView.frame;
        frame.origin.x=(screenW-frame.size.width)/2.0;
        frame.origin.y=(screenH-frame.size.height)/2.0;
        _errorView.frame=frame;
    }
}
@end
