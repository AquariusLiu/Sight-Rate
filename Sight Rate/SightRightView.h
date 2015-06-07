//
//  SightRightView.h
//  Sight Rate
//
//  Created by Liu XiangYu on 15/6/7.
//  Copyright (c) 2015年 Liu XiangYu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface SightRightView : UIView

@property CAShapeLayer *backgroundRingLayer;
@property CAShapeLayer *ringLayer;
@property CALayer *imageLayer;

@property (nonatomic) IBInspectable double rating;
@property (nonatomic) IBInspectable double lineWidth;

@end
