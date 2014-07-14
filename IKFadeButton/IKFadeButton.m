//
//  IKFadeButton.m
//  Inaka
//
//  Created by Pablo Villar on 7/11/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IKFadeButton.h"

CGFloat const IKFadeButtonDefaultDuration = .5;

@interface IKFadeButton ()

@property (strong, nonatomic) UIImageView *overlayBackground;
@property (strong, nonatomic) UIImageView *overlayImage;
@property (strong, nonatomic) UILabel *overlayLabel;

@end

@implementation IKFadeButton

#pragma mark - Lifecycle

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self addOverlayBackgroundImage];
    [self addOverlayImage];
    [self addOverlayLabel];
}

#pragma mark - Accessors

- (CGFloat)fadeDuration
{
    return (_fadeDuration == 0) ? IKFadeButtonDefaultDuration : _fadeDuration;
}

#pragma mark - Subclass

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self showOverlays];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self fadeOutOverlays];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self fadeOutOverlays];
}

- (void)setHighlighted:(BOOL)highlighted
{
    // Intentionally overriden to do nothing.
}

#pragma mark - Private

- (void)addOverlayBackgroundImage
{
    self.overlayBackground = [[UIImageView alloc] initWithImage:[self backgroundImageForState:UIControlStateHighlighted]];
    CGRect frame = self.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    self.overlayBackground.frame = frame;
    self.overlayBackground.alpha = self.highlighted;
    [self addSubview:self.overlayBackground];
}

- (void)addOverlayImage
{
    self.overlayImage = [[UIImageView alloc] initWithImage:[self imageForState:UIControlStateHighlighted]];
    self.overlayImage.frame = self.imageView.frame;
    self.overlayImage.alpha = self.highlighted;
    [self addSubview:self.overlayImage];
}

- (void)addOverlayLabel
{
    self.overlayLabel = [[UILabel alloc] init];
    self.overlayLabel.frame = self.titleLabel.frame;
    self.overlayLabel.alpha = self.highlighted;
    self.overlayLabel.font = self.titleLabel.font;
    self.overlayLabel.text = self.titleLabel.text;
    self.overlayLabel.textColor = [self titleColorForState:UIControlStateHighlighted];
    [self addSubview:self.overlayLabel];
}

- (void)showOverlays
{
    self.overlayBackground.alpha = 1;
    self.overlayImage.alpha = 1;
    self.overlayLabel.alpha = 1;
}

- (void)fadeOutOverlays
{
    [UIView animateWithDuration:self.fadeDuration animations:^{
        self.overlayBackground.alpha = 0;
        self.overlayImage.alpha = 0;
        self.overlayLabel.alpha = 0;
    }];
}

@end