//
//  ADMenuItem.m
//  AnimateDemo
//
//  Created by fmj on 14-5-8.
//  Copyright (c) 2014年 fmj. All rights reserved.
//

#import "ADMenuItem.h"

@implementation ADMenuItem
{
    UIImageView* _contentImageView;
}

-(instancetype)initWithbg:(UIImage*)bg content:(UIImage*)content bgHighted:(UIImage*)bgHighted contentHighted:(UIImage*)contentHighted
{
    if (self = [super init]) {
        self.menuBgImage = bg;
        self.menuContentImage = content;
        self.menuBgHightlightImage = bgHighted;
        self.menuContentHighlightImage = contentHighted;
        self.userInteractionEnabled = YES;
        self.bounds = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
        self.frame = self.bounds;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setMenuBgImage:(UIImage *)menuBgImage
{
    self.image = menuBgImage;
}

-(UIImage*)menuBgImage
{
    return self.image;
}

-(void)setMenuBgHightlightImage:(UIImage *)menuBgHightlightImage
{
    self.highlightedImage = menuBgHightlightImage;
}

-(UIImage*)menuBgHightlightImage
{
    return self.highlightedImage;
}

-(void)setMenuContentImage:(UIImage *)menuContentImage
{
    if (_contentImageView == nil) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.userInteractionEnabled = YES;
        [self addSubview:_contentImageView];
    }
    _contentImageView.image = menuContentImage;
}

-(UIImage*)menuContentImage
{
    return _contentImageView.image;
}

-(void)setMenuContentHighlightImage:(UIImage *)menuContentHighlightImage
{
    if (_contentImageView == nil) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.userInteractionEnabled = YES;
        [self addSubview:_contentImageView];
    }
    _contentImageView.highlightedImage = menuContentHighlightImage;
}

-(UIImage*)menuContentHighlightImage
{
    return _contentImageView.image;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSLog(@"layoutSubviews");
    
    
    float width = _contentImageView.image.size.width;
    float height = _contentImageView.image.size.height;
    _contentImageView.frame = CGRectMake(self.bounds.size.width/2 - width/2, self.bounds.size.height/2 - height/2, width, height);
}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    _contentImageView.highlighted = highlighted;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGRect rect = self.bounds;
    CGRect rect1 = self.frame;
    [super touchesBegan:touches withEvent:event];
    
    NSLog(@"touchbegin");
    self.highlighted = YES;
    if (self.delegate && [_delegate respondsToSelector:@selector(ADMenuTouchBegin:)])
    {
        [_delegate ADMenuTouchBegin:self];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.highlighted = NO;
    CGPoint location = [[touches anyObject] locationInView:self];
    
    if (CGRectContainsPoint(self.bounds, location))
    {
        if (self.delegate && [_delegate respondsToSelector:@selector(ADMenuTouchended:)])
        {
            [_delegate ADMenuTouchended:self];
        }
    }
    NSLog(@"touchend");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
    self.highlighted = NO;
}

@end
