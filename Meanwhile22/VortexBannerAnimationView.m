//
// VortexBannerAnimationView.m
// Generated by Core Animator version 1.3 on 8/20/16.
//
// DO NOT MODIFY THIS FILE. IT IS AUTO-GENERATED AND WILL BE OVERWRITTEN
//

#import "VortexBannerAnimationView.h"

@implementation VortexBannerAnimationView

#pragma mark - Life Cycle

- (instancetype)init
{
	return [self initWithFrame:CGRectMake(0,0,1100,330)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		[self setupHierarchy];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self)
	{
		[self setupHierarchy];
	}
	return self;
}

#pragma mark - Scaling

- (void)layoutSubviews
{
	[super layoutSubviews];

	UIView *scalingView = self.viewsByName[@"__scaling__"];
	float xScale = self.bounds.size.width / scalingView.bounds.size.width;
	float yScale = self.bounds.size.height / scalingView.bounds.size.height;
	switch (self.contentMode) {
		case UIViewContentModeScaleToFill:
			break;
		case UIViewContentModeScaleAspectFill:
		{
			float scale = MAX(xScale, yScale);
			xScale = scale;
			yScale = scale;
			break;
		}
		default:
		{
			float scale = MIN(xScale, yScale);
			xScale = scale;
			yScale = scale;
			break;
		}
	}
	scalingView.transform = CGAffineTransformMakeScale(xScale, yScale);
	scalingView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

#pragma mark - Setup

- (void)setupHierarchy
{
	NSMutableDictionary *viewsByName = [NSMutableDictionary dictionary];
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];

	UIView *__scaling__ = [UIView new];
	__scaling__.bounds = CGRectMake(0, 0, 1100, 330);
	__scaling__.center = CGPointMake(550.0, 165.0);
	__scaling__.layer.masksToBounds = YES;
	[self addSubview:__scaling__];
	viewsByName[@"__scaling__"] = __scaling__;

	UIImageView *vortexSpinBanner = [UIImageView new];
	vortexSpinBanner.bounds = CGRectMake(0, 0, 1917.0, 611.0);
	UIImage *imgVortexSpinBanner = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"vortex spin banner.png" ofType:nil]];
	if ( imgVortexSpinBanner == nil ) { NSLog(@"** Warning: Could not create image from 'vortex spin banner.png'. Please make sure that it is added to the project directly (not in a folder reference)."); }
	vortexSpinBanner.image = imgVortexSpinBanner;
	vortexSpinBanner.contentMode = UIViewContentModeCenter;
	vortexSpinBanner.layer.position = CGPointMake(550.000, 165.000);
	vortexSpinBanner.transform = CGAffineTransformMakeScale(0.80, 2.00);
	[__scaling__ addSubview:vortexSpinBanner];
	viewsByName[@"vortex spin banner"] = vortexSpinBanner;

	UIImageView *vortexWordsBanner = [UIImageView new];
	vortexWordsBanner.bounds = CGRectMake(0, 0, 1528.0, 458.0);
	UIImage *imgVortexWordsBanner = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"vortex words banner.png" ofType:nil]];
	if ( imgVortexWordsBanner == nil ) { NSLog(@"** Warning: Could not create image from 'vortex words banner.png'. Please make sure that it is added to the project directly (not in a folder reference)."); }
	vortexWordsBanner.image = imgVortexWordsBanner;
	vortexWordsBanner.contentMode = UIViewContentModeCenter;
	vortexWordsBanner.layer.position = CGPointMake(550.000, 165.000);
	vortexWordsBanner.transform = CGAffineTransformMakeScale(0.73, 0.73);
	[__scaling__ addSubview:vortexWordsBanner];
	viewsByName[@"vortex words banner"] = vortexWordsBanner;

	self.viewsByName = viewsByName;
}

#pragma mark - VortexBannerAnimation

- (void)addVortexBannerAnimation
{
	[self addVortexBannerAnimationWithBeginTime:0 andFillMode:kCAFillModeBoth andRemoveOnCompletion:NO];
}

- (void)addVortexBannerAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion
{
	[self addVortexBannerAnimationWithBeginTime:0 andFillMode:removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth andRemoveOnCompletion:removedOnCompletion];
}

- (void)addVortexBannerAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion
{
	CAMediaTimingFunction *linearTiming = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

	CAKeyframeAnimation *vortexSpinBannerRotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
	vortexSpinBannerRotationAnimation.duration = 2.000;
	vortexSpinBannerRotationAnimation.values = @[@(0.000), @(-6.266)];
	vortexSpinBannerRotationAnimation.keyTimes = @[@(0.000), @(1.000)];
	vortexSpinBannerRotationAnimation.timingFunctions = @[linearTiming];
	vortexSpinBannerRotationAnimation.repeatCount = HUGE_VALF;
	vortexSpinBannerRotationAnimation.beginTime = beginTime;
	vortexSpinBannerRotationAnimation.fillMode = fillMode;
	vortexSpinBannerRotationAnimation.removedOnCompletion = removedOnCompletion;
	[[self.viewsByName[@"vortex spin banner"] layer] addAnimation:vortexSpinBannerRotationAnimation forKey:@"VortexBannerAnimation_Rotation"];

	CAKeyframeAnimation *vortexWordsBannerRotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
	vortexWordsBannerRotationAnimation.duration = 2.000;
	vortexWordsBannerRotationAnimation.values = @[@(0.000), @(3.135), @(6.283)];
	vortexWordsBannerRotationAnimation.keyTimes = @[@(0.000), @(0.500), @(1.000)];
	vortexWordsBannerRotationAnimation.timingFunctions = @[linearTiming, linearTiming];
	vortexWordsBannerRotationAnimation.beginTime = beginTime;
	vortexWordsBannerRotationAnimation.fillMode = fillMode;
	vortexWordsBannerRotationAnimation.removedOnCompletion = removedOnCompletion;
	[[self.viewsByName[@"vortex words banner"] layer] addAnimation:vortexWordsBannerRotationAnimation forKey:@"VortexBannerAnimation_Rotation"];

	CAKeyframeAnimation *vortexWordsBannerOpacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
	vortexWordsBannerOpacityAnimation.duration = 2.000;
	vortexWordsBannerOpacityAnimation.values = @[@(1.000), @(0.300), @(1.000)];
	vortexWordsBannerOpacityAnimation.keyTimes = @[@(0.000), @(0.500), @(1.000)];
	vortexWordsBannerOpacityAnimation.timingFunctions = @[linearTiming, linearTiming];
	vortexWordsBannerOpacityAnimation.repeatCount = HUGE_VALF;
	vortexWordsBannerOpacityAnimation.beginTime = beginTime;
	vortexWordsBannerOpacityAnimation.fillMode = fillMode;
	vortexWordsBannerOpacityAnimation.removedOnCompletion = removedOnCompletion;
	[[self.viewsByName[@"vortex words banner"] layer] addAnimation:vortexWordsBannerOpacityAnimation forKey:@"VortexBannerAnimation_Opacity"];

	CAKeyframeAnimation *vortexWordsBannerScaleXAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
	vortexWordsBannerScaleXAnimation.duration = 2.000;
	vortexWordsBannerScaleXAnimation.values = @[@(0.730), @(0.250), @(0.730)];
	vortexWordsBannerScaleXAnimation.keyTimes = @[@(0.000), @(0.500), @(1.000)];
	vortexWordsBannerScaleXAnimation.timingFunctions = @[linearTiming, linearTiming];
	vortexWordsBannerScaleXAnimation.beginTime = beginTime;
	vortexWordsBannerScaleXAnimation.fillMode = fillMode;
	vortexWordsBannerScaleXAnimation.removedOnCompletion = removedOnCompletion;
	[[self.viewsByName[@"vortex words banner"] layer] addAnimation:vortexWordsBannerScaleXAnimation forKey:@"VortexBannerAnimation_ScaleX"];

	CAKeyframeAnimation *vortexWordsBannerScaleYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
	vortexWordsBannerScaleYAnimation.duration = 2.000;
	vortexWordsBannerScaleYAnimation.values = @[@(0.730), @(0.250), @(0.730)];
	vortexWordsBannerScaleYAnimation.keyTimes = @[@(0.000), @(0.500), @(1.000)];
	vortexWordsBannerScaleYAnimation.timingFunctions = @[linearTiming, linearTiming];
	vortexWordsBannerScaleYAnimation.beginTime = beginTime;
	vortexWordsBannerScaleYAnimation.fillMode = fillMode;
	vortexWordsBannerScaleYAnimation.removedOnCompletion = removedOnCompletion;
	[[self.viewsByName[@"vortex words banner"] layer] addAnimation:vortexWordsBannerScaleYAnimation forKey:@"VortexBannerAnimation_ScaleY"];
}

- (void)removeVortexBannerAnimation
{
	[[self.viewsByName[@"vortex spin banner"] layer] removeAnimationForKey:@"VortexBannerAnimation_Rotation"];
	[[self.viewsByName[@"vortex words banner"] layer] removeAnimationForKey:@"VortexBannerAnimation_Rotation"];
	[[self.viewsByName[@"vortex words banner"] layer] removeAnimationForKey:@"VortexBannerAnimation_Opacity"];
	[[self.viewsByName[@"vortex words banner"] layer] removeAnimationForKey:@"VortexBannerAnimation_ScaleX"];
	[[self.viewsByName[@"vortex words banner"] layer] removeAnimationForKey:@"VortexBannerAnimation_ScaleY"];
}

- (void)removeAllAnimations
{
	for (UIView *view in self.viewsByName.allValues)
	{
		[view.layer removeAllAnimations];
	}
}

@end