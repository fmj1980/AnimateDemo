//
//  ADMenuItem.h
//  AnimateDemo
//
//  Created by fmj on 14-5-8.
//  Copyright (c) 2014年 fmj. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ADMenuItemDelete;

@interface ADMenuItem : UIImageView

-(instancetype)initWithbg:(UIImage*)bg content:(UIImage*)content bgHighted:(UIImage*)bgHighted contentHighted:(UIImage*)contentHighted;

@property(nonatomic,retain) UIImage* menuBgImage;
@property(nonatomic,retain) UIImage* menuBgHightlightImage;
@property(nonatomic,retain) UIImage* menuContentImage;
@property(nonatomic,retain) UIImage* menuContentHighlightImage;

@property(nonatomic,retain) id<ADMenuItemDelete> delegate;

@end

@protocol ADMenuItemDelete <NSObject>

@optional
-(void)ADMenuTouchBegin:(ADMenuItem*)menuitem;
-(void)ADMenuTouchended:(ADMenuItem*)menuitem;

@end