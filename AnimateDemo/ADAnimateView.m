//
//  ADAnimateView.m
//  AnimateDemo
//
//  Created by fmj on 14-5-7.
//  Copyright (c) 2014年 fmj. All rights reserved.
//

#import "ADAnimateView.h"
#import "ADMenuItem.h"
#define SUBMENU_TAG 1000

@implementation ADAnimateView
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initMenu];
    }
    
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initMenu];
}

-(void)initMenu;
{
    _expanded = NO;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setMenuButton:(ADMenuItem *)centerMenuItem
{
    if (_menuButton!=nil ) {
        [_menuButton removeFromSuperview];
    }
    _menuButton = centerMenuItem;
    _menuButton.delegate = self;
    [self addSubview:_menuButton];
}

-(void)ADMenuTouchBegin:(ADMenuItem*)menuitem
{
    if ( menuitem == _menuButton ) {
        
    }
}

-(void)ADMenuTouchended:(ADMenuItem*)menuitem
{
    NSLog(@"ADMenuTouchended");
    
    if ( menuitem == _menuButton ) {
        self.expanded = !self.expanded;
        if (_expanded) {
            [self initSubMenus];
        }
        else
        {
            NSUInteger count = [_menuItems count];
            for (int i = 0; i < count; i ++)
            {
                ADMenuItem *item = [_menuItems objectAtIndex:i];
                
                [self performSelector:@selector(animateHideSubMenu:) withObject:item afterDelay:0.1*(count-i)];
            }
        }
    }
}

-(void)setExpanded:(BOOL)expanded
{
    float angle = self.expanded ? 0.0f:-M_PI_4;
    [UIView animateWithDuration:0.3f animations:^{
        _menuButton.transform = CGAffineTransformMakeRotation(angle);
    }];
    _expanded = expanded;
    
    
}

-(void)animateHideSubMenu:(ADMenuItem*)item
{
    CAAnimationGroup *blowup = [self _blowupAnimationAtPoint:item.center];
    [item.layer addAnimation:blowup forKey:@"blowup"];
    
    item.center = _menuButton.center;
    
    
}

-(void)adnimateShowSubMenu:(ADMenuItem*)item
{
   
    int index = (int)[_menuItems indexOfObject:item];
    
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:M_PI],[NSNumber numberWithFloat:0.0f], nil];
    rotateAnimation.duration = 1.5;
    rotateAnimation.keyTimes = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:.3],
                                [NSNumber numberWithFloat:.4], nil];
    
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = 0.5;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat height = _menuButton.image.size.height+10;
    
    CGPathMoveToPoint(path, NULL, item.center.x, item.center.y+ _menuButton.image.size.height);
    CGPathAddLineToPoint(path, NULL, item.center.x, item.center.y+ height*(index+1));
    CGPathAddLineToPoint(path, NULL, item.center.x, item.center.y+height*(index+1)+20);
    CGPathAddLineToPoint(path, NULL, item.center.x, item.center.y+height*(index+1));
    positionAnimation.path = path;
    CGPathRelease(path);
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, rotateAnimation, nil];
    animationgroup.duration = 0.5;
    animationgroup.fillMode = kCAFillModeForwards;
    animationgroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animationgroup.delegate = self;
  
    [item.layer addAnimation:animationgroup forKey:@"Expand"];
    item.center = CGPointMake(_menuButton.center.x, _menuButton.center.y+height*(index+1));
}

-(void)initSubMenus
{
   
    int countcontrols = (int)self.subviews.count;
    
    NSUInteger count = [_menuItems count];
    for (int i = 0; i < count; i ++)
    {
        ADMenuItem *item = [_menuItems objectAtIndex:i];
        item.tag = SUBMENU_TAG + i;
        item.delegate = self;
        item.center = _menuButton.center;
        item.delegate = self;
		[self insertSubview:item belowSubview:_menuButton];
        
        [self performSelector:@selector(adnimateShowSubMenu:) withObject:item afterDelay:0.1*(count-i)];
    }
    countcontrols = (int)self.subviews.count;
}

- (CAAnimationGroup *)_blowupAnimationAtPoint:(CGPoint)p
{
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.values = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:p], nil];
    positionAnimation.keyTimes = [NSArray arrayWithObjects: [NSNumber numberWithFloat:.3], nil];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(3, 3, 1)];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.toValue  = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, scaleAnimation, opacityAnimation, nil];
    animationgroup.duration = 0.5;
    animationgroup.fillMode = kCAFillModeForwards;
    
    return animationgroup;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[super touchesBegan:touches withEvent:event];
}
@end
