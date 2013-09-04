//
//  MKPhotoScroll.m
//  ScrollImageDemo
//
//  Created by rang on 13-8-14.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "MKPhotoScroll.h"

@interface MKPhotoScroll()
-(CGRect)imageRect;
-(void)setLayoutImage;
-(void)updatePage;

@end

@implementation MKPhotoScroll
@synthesize scrollView=_scrollView;
@synthesize pageControl=_pageControl;
@synthesize imageCount;
@synthesize delegate;
@synthesize imageCollection;
@synthesize sourceImages;
-(void)dealloc{
    [super dealloc];
    [_scrollView release];
    [_pageControl release];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.alwaysBounceHorizontal=NO;
        self.scrollView.alwaysBounceVertical=NO;
        [self.scrollView setPagingEnabled:YES];
        self.scrollView.autoresizesSubviews=YES;
        self.scrollView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;//
        self.scrollView.delegate=self;
        [self addSubview:self.scrollView];
        
        
        self.pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-30, frame.size.width, 30)];
        self.pageControl.numberOfPages=1;
        self.pageControl.currentPage=0;
        [self.pageControl setPageIndicatorTintColor:[UIColor grayColor]];
        self.autoresizesSubviews=YES;
        self.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
        [self.pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];  //用户点击UIPageControl的响应函数
        [self addSubview:self.pageControl];
        currentCount=0;
    }
    return self;
}
-(NSInteger)imageCount{
    return currentCount;
}
-(NSArray*)imageCollection{
    if (self.scrollView&&[self.scrollView.subviews count]>0) {
        NSMutableArray *arr=[NSMutableArray array];
        for (int i=1;i<=3;i++) {
            UIImageView *imageView=(UIImageView*)[self.scrollView viewWithTag:100+i];
            if (imageView) {
                [arr addObject:imageView];
            }
        }
        return arr;
    }
    return nil;
}
-(NSArray*)sourceImages{
    NSArray *arr=[self imageCollection];
    if(arr){
        NSMutableArray *result=[NSMutableArray arrayWithCapacity:[arr count]];
        for (UIImageView *imageView in arr) {
            [result addObject:[imageView.image copy]];
        }
        return result;
    }
    return nil;
}
- (void)pageTurn:(UIPageControl*)sender
{
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = self.scrollView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.scrollView scrollRectToVisible:rect animated:YES];
}
-(void)addImage:(UIImage*)image{
    if (self.imageCount<3) {
        currentCount++;
        CGRect rect=[self imageRect];
        UIImageView *imageView=[[[UIImageView alloc] initWithFrame:rect] autorelease];
        imageView.tag=100+currentCount;
        [imageView setImage:image];
        imageView.autoresizesSubviews=YES;
        imageView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        imageView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGesture=[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonImageTap:)] autorelease];
        tapGesture.numberOfTapsRequired=1;
        tapGesture.numberOfTouchesRequired=1;
        [imageView addGestureRecognizer:tapGesture];
        
        [self.scrollView addSubview:imageView];
        [self updatePage];
        
    }
}
-(void)buttonImageTap:(id)sender{
    UITapGestureRecognizer *tapGesture=(UITapGestureRecognizer*)sender;
    UIImageView *imageView=(UIImageView*)tapGesture.view;
    int index=[self.scrollView.subviews indexOfObject:imageView];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(imageViewClick:imageIndex:)]) {
        [self.delegate imageViewClick:imageView imageIndex:index];
    }
}
-(void)addRangeImage:(NSArray*)images{
    if (images&&[images count]>0) {
        for (int i=0;i<[images count]; i++) {
            [self addImage:[images objectAtIndex:i]];
        }
    }
}
-(void)removeImageIndex:(int)index{
    NSArray *childs=[self imageCollection];
    if (childs&&index<[childs count]) {
        UIImageView *imageView=(UIImageView*)[childs objectAtIndex:index];
        if ([self.scrollView.subviews containsObject:imageView]) {
            [imageView removeFromSuperview];
            currentCount--;
            [self setLayoutImage];
            [self updatePage];
            
        }
    }
}
#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [self.pageControl setCurrentPage:offset.x / bounds.size.width];
}
#pragma mark -
#pragma mark 私有方法
-(CGRect)imageRect{
    int total=self.imageCount;
    CGSize size=self.scrollView.bounds.size;
    CGFloat w=size.width;
    CGFloat leftX=total==0?0.0:(total-1)*w;
    return CGRectMake(leftX, 0, w,296);
}
-(void)setLayoutImage{
    NSArray *childs=[self imageCollection];
    if (childs) {
        int index=1;
        for (UIImageView *imageView in childs) {
            imageView.tag=100+index;
            CGRect rect=imageView.frame;
            rect.origin.x=(index-1)*self.scrollView.bounds.size.width;
            imageView.frame=rect;
            index++;
        }
      
    }
}
-(void)updatePage{
    int total=self.imageCount;
    if (total>0) {
        self.scrollView.contentSize=CGSizeMake(self.scrollView.bounds.size.width*total,self.scrollView.bounds.size.height);
        self.pageControl.numberOfPages=total;
        //self.pageControl.currentPage=total-1;
    }else{
        self.pageControl.numberOfPages=1;
        self.pageControl.currentPage=0;
        self.scrollView.contentSize=CGSizeMake(self.scrollView.bounds.size.width,self.scrollView.bounds.size.height);
    }
}
@end
