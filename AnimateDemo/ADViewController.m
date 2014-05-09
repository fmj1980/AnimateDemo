//
//  ADViewController.m
//  AnimateDemo
//
//  Created by fmj on 14-5-7.
//  Copyright (c) 2014年 fmj. All rights reserved.
//

#import "ADViewController.h"
#import "ADAnimateView.h"
#import "ADMenuItem.h"

@interface ADViewController ()
@property (weak, nonatomic) IBOutlet ADAnimateView *animateView;
@end

@implementation ADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
    _animateView.menuButton = [[ADMenuItem alloc] initWithbg: [UIImage imageNamed:@"bg"]
                                                         content:[UIImage imageNamed:@"plus"]
                                                         bgHighted:[UIImage imageNamed:@"bg"]
                                                         contentHighted:[UIImage imageNamed:@"plushighlighted"]];

    _animateView.menuItems = @[
                               [[ADMenuItem alloc] initWithbg: [UIImage imageNamed:@"bg"]
                                                      content:[UIImage imageNamed:@"plus"]
                                                      bgHighted:[UIImage imageNamed:@"bg"]
                                                      contentHighted:[UIImage imageNamed:@"plushighlighted"]],
                               
                                [[ADMenuItem alloc] initWithbg: [UIImage imageNamed:@"bg"]
                                                      content:[UIImage imageNamed:@"plus"]
                                                      bgHighted:[UIImage imageNamed:@"bg"]
                                                      contentHighted:[UIImage imageNamed:@"plushighlighted"]],
                               
                               [[ADMenuItem alloc] initWithbg: [UIImage imageNamed:@"bg"]
                                                      content:[UIImage imageNamed:@"plus"]
                                                    bgHighted:[UIImage imageNamed:@"bg"]
                                               contentHighted:[UIImage imageNamed:@"plushighlighted"]],
                               
                               [[ADMenuItem alloc] initWithbg: [UIImage imageNamed:@"bg"]
                                                      content:[UIImage imageNamed:@"plus"]
                                                    bgHighted:[UIImage imageNamed:@"bg"]
                                               contentHighted:[UIImage imageNamed:@"plushighlighted"]]
                               ];
    self.view.userInteractionEnabled = YES;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pulseButtonClicked:(UIButton *)sender
{
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    rotateAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:.5f], [NSNumber numberWithFloat:1.0f],nil];
    rotateAnimation.duration = 1 + (rand() % 10) * 0.05;
    rotateAnimation.keyTimes = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:.0],
                                [NSNumber numberWithFloat:.75], [NSNumber numberWithFloat:1.0],nil];
    [self.view.layer addAnimation:rotateAnimation forKey:nil];
}

-(IBAction)colorButtonClicked:(id)sender
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anim.duration = 1.f;
    anim.toValue = (id)[UIColor redColor].CGColor;
    anim.fromValue =  _animateView.backgroundColor;
    anim.delegate = self;
    anim.autoreverses = YES;
    
    [_animateView.layer addAnimation:anim forKey:nil];
}

- (void)animationDidStop:(CAPropertyAnimation *)anim finished:(BOOL)flag
{
    if ( [anim.keyPath isEqualToString:( @"backgroundColor")]) {
        _animateView.backgroundColor = [UIColor blueColor];
    }
    
}

-(IBAction)cornerButtonClicked:(id)sender
{
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    anim2.duration = 1.f;
    anim2.fromValue = [NSNumber numberWithFloat:0.f];
    anim2.toValue = [NSNumber numberWithFloat:60.0f];
    anim2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim2.repeatCount = CGFLOAT_MAX;
    anim2.autoreverses = YES;
    
    [_animateView.layer addAnimation:anim2 forKey:@"cornerRadius"];
}


-(IBAction)shadowButtonClicked:(id)sender
{
    [_animateView.layer setShadowOffset:CGSizeMake(4,4)];
    [_animateView.layer setShadowOpacity:1];
    [_animateView.layer setShadowColor:[UIColor grayColor].CGColor];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"shadowColor"];
    anim.duration = 1.f;
    anim.toValue = (id)[UIColor redColor].CGColor;
    anim.fromValue =  (id)[UIColor blackColor].CGColor;
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.repeatCount = CGFLOAT_MAX;
    anim.autoreverses = YES;
    
    [_animateView.layer addAnimation:anim forKey:nil];
}

-(IBAction)blinkButtonClicked:(id)sender
{
    CABasicAnimation* animate = [ADViewController opacityForever_Animation:1.0f];
    [_animateView.layer addAnimation:animate forKey:nil];
}
+(CABasicAnimation*)opacityForever_Animation:(float)time

{
    CABasicAnimation
    *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.2];
    animation.autoreverses=YES;
    animation.duration=time;
    animation.repeatCount=FLT_MAX;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+(CABasicAnimation*)moveX:(float)time X:(NSNumber *)x //横向移动

{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue=x;
    animation.duration=time;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    

}
@end
