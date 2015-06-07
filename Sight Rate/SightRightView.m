//
//  SightRightView.m
//  Sight Rate
//
//  Created by Liu XiangYu on 15/6/7.
//  Copyright (c) 2015年 Liu XiangYu. All rights reserved.
//

#import "SightRightView.h"


@implementation SightRightView

-(void)setRating:(double)rating {
    _rating = rating;
    [self updateLayerProperties];
}

-(void)setLineWidth:(double)lineWidth {
    _lineWidth = lineWidth;
    [self updateLayerProperties];
}

- (void)layoutSubviews {
//    _rating = 0.6;
//    _lineWidth = 10.0;
    
    if (!_backgroundRingLayer) {
        _backgroundRingLayer = [CAShapeLayer new];
        [self.layer addSublayer:_backgroundRingLayer];
        
        CGRect rect = CGRectInset(self.bounds, _lineWidth / 2.0, _lineWidth / 2.0);
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        
        _backgroundRingLayer.path = path.CGPath;
        _backgroundRingLayer.fillColor = nil;
        _backgroundRingLayer.lineWidth = _lineWidth;
        _backgroundRingLayer.strokeColor = [[UIColor colorWithWhite:0.5 alpha:0.3] CGColor];
    }
    _backgroundRingLayer.frame = self.layer.bounds;
    
    if (!_ringLayer) {
        _ringLayer = [CAShapeLayer new];
        
        CGRect innerRect = CGRectInset(self.bounds, _lineWidth / 2.0, _lineWidth / 2.0);
        UIBezierPath *innerPath = [UIBezierPath bezierPathWithOvalInRect:innerRect];
        
        _ringLayer.path = innerPath.CGPath;
        _ringLayer.fillColor = nil;
        _ringLayer.lineWidth = _lineWidth;
        _ringLayer.strokeColor = [[UIColor blueColor] CGColor];
        _ringLayer.anchorPoint = CGPointMake(0.5, 0.5);
        _ringLayer.transform = CATransform3DRotate(_ringLayer.transform, -M_PI/2, 0, 0, 1);
        
        [self.layer addSublayer:_ringLayer];
    }
    _ringLayer.frame = self.layer.bounds;
    
    [self updateLayerProperties];
}

- (void)updateLayerProperties {
    if (_ringLayer) {
        _ringLayer.strokeEnd = _rating;
        
        UIColor *strokeColor = [UIColor lightGrayColor];
        if (_rating >= 0.75) {
            strokeColor = [UIColor colorWithHue:112.0/360.0 saturation:0.39 brightness:0.85 alpha:1.0];
        } else if (_rating >= 0.5) {
            strokeColor = [UIColor colorWithHue:208.0/360.0 saturation:0.51 brightness:0.75 alpha:1.0];
        } else if (_rating >= 0.25) {
            strokeColor = [UIColor colorWithHue:40.0/360.0 saturation:0.39 brightness:0.85 alpha:1.0];
        } else {
            strokeColor = [UIColor colorWithHue:359.0/360.0 saturation:0.48 brightness:0.63 alpha:1.0];
        }
        
        _ringLayer.strokeColor = [strokeColor CGColor];
    }
    
    if (_imageLayer) {
        
    }
    
    if (!_imageLayer) {
        CAShapeLayer *imageMaskLayer = [CAShapeLayer new];
        CGRect insetBounds = CGRectInset(self.bounds, _lineWidth + 3.0, _lineWidth + 3.0);
        UIBezierPath *innerPath = [UIBezierPath bezierPathWithOvalInRect:insetBounds];
        
        imageMaskLayer.path = innerPath.CGPath;
        imageMaskLayer.fillColor = [[UIColor blackColor] CGColor];
        imageMaskLayer.frame = self.bounds;
        [self.layer addSublayer:imageMaskLayer];
        
        _imageLayer = [CALayer new];
        _imageLayer.mask = imageMaskLayer;
        _imageLayer.frame = self.bounds;
        _imageLayer.backgroundColor = [[UIColor lightGrayColor] CGColor];
        _imageLayer.contentsGravity = kCAGravityResizeAspectFill;
        [self.layer addSublayer:_imageLayer];
    }
}

@end
