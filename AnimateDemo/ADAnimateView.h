//
//  ADAnimateView.h
//  AnimateDemo
//
//  Created by fmj on 14-5-7.
//  Copyright (c) 2014年 fmj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADMenuItem.h"

@interface ADAnimateView : UIView <ADMenuItemDelete>

@property(nonatomic,retain) ADMenuItem* menuButton;
@property(nonatomic,retain) NSArray* menuItems;

@property (nonatomic) BOOL expanded;

@end
