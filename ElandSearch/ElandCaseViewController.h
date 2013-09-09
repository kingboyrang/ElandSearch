//
//  ElandCaseViewController.h
//  ElandSearch
//
//  Created by aJia on 13/9/5.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimateLoadView.h"
#import "AnimateErrorView.h"
@interface ElandCaseViewController : UIViewController
@property(nonatomic,readonly) BOOL hasNetwork;
-(AnimateErrorView*) errorView;
-(AnimateLoadView*) loadingView;
-(void) showLoadingAnimated:(BOOL) animated process:(void (^)(AnimateLoadView *showView))process;
-(void) hideLoadingViewAnimated:(BOOL) animated completed:(void (^)(AnimateLoadView *hideView))complete;
-(void) showErrorViewAnimated:(BOOL) animated process:(void (^)(AnimateErrorView *errorView))process;
-(void) hideErrorViewAnimated:(BOOL) animated completed:(void (^)(AnimateErrorView *errorView))complete;
-(void)showNoNetworkErrorView;
@end
