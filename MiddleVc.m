//
//  MiddleVc.m
//  Tinder
//
//  Created by 张德荣 on 16/4/29.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "MiddleVc.h"
#import "RadarView.h"
@interface MiddleVc ()
{
    CALayer *_layer;
//    CAAnimationGroup *_animaTionGroup;
//    CADisplayLink *_disPlayLink;
    
}
@property (nonatomic, strong) CALayer *layer;

@property (nonatomic, strong) CAAnimationGroup *animaTionGroup;

@property (nonatomic, strong) CADisplayLink *disPlayLink;

@property (nonatomic,strong) RadarView *imgView;
@property(nonatomic,strong) CALayer *staticLayer;
@property(nonatomic,strong) CAGradientLayer *staticShadowLayer;
@property (nonatomic,assign) NSTimeInterval getAddressTime;
@property(nonatomic,strong)NSTimer *timer ;
@end

@implementation MiddleVc
@synthesize imgView;
#pragma mark 懒加载
-(CALayer *)staticLayer{
    if (!_staticLayer) {
        _staticLayer = [[CALayer alloc] init];
        _staticLayer.cornerRadius = [UIScreen mainScreen].bounds.size.width/4;
        _staticLayer.frame = CGRectMake(0, 0, self.staticLayer.cornerRadius*2 , self.staticLayer.cornerRadius*2);
        _staticLayer.borderWidth = 1;
        _staticLayer.position = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
        
        UIColor *color = [UIColor redColor];
        
        _staticLayer.borderColor =color.CGColor;
        
    }
    return _staticLayer;
}

-(CAGradientLayer *)staticShadowLayer{
    if (!_staticShadowLayer) {
        _staticShadowLayer = [[CAGradientLayer alloc] init];
        _staticShadowLayer.cornerRadius = [UIScreen mainScreen].bounds.size.width/4;
        _staticShadowLayer.frame = CGRectMake(0, 0, self.staticLayer.cornerRadius*2-1 , self.staticLayer.cornerRadius*2-1);
        //    layer1.borderWidth = 18;
        _staticShadowLayer.position = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
        UIColor* backColor = [UIColor colorWithRed:100/255.0 green:46/255.0 blue:97/255.0 alpha:0.8];
        _staticShadowLayer.colors = [NSArray arrayWithObjects:(id)backColor.CGColor,[UIColor colorWithRed:59/255.0 green:46/255.0 blue:97/255.0 alpha:0.8].CGColor ,nil];
        
    }
    return _staticShadowLayer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationController.navigationBarHidden = YES;
//    self.view.backgroundColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:105/225.0 alpha:1];
//    
//    self.imgView = [[RadarView alloc]init];
//    self.imgView.backgroundColor = [UIColor clearColor];
//    self.imgView.frame=self.view.frame;
//    [self.view addSubview:self.imgView];
//    [self startAnimation];
    [self setupRippleAnimation];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, 80, 80);
    btn.center = self.view.center;
    btn.layer.cornerRadius = 80/2;
    btn.clipsToBounds = YES;
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)setupRippleAnimation {
    
    
    CGFloat width = 4;
    CGRect pathFrame = CGRectMake(0, 0, 4, 4);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:width/2];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.position = self.view.center;
    shapeLayer.bounds = path.bounds;
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor colorWithRed:1.00f green:0.71f blue:0.71f alpha:1.00f] CGColor];
    shapeLayer.fillColor = [UIColor colorWithRed:1.00f green:0.82f blue:0.82f alpha:1.00f].CGColor;
    shapeLayer.lineWidth = 0.05;
    [self.view.layer addSublayer:shapeLayer];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(60, 60, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation,alphaAnimation];
    animation.duration = 2;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    [shapeLayer addAnimation:animation forKey:nil];
    
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"]];
    //    UIView *imageView = [UIView new];
    //    imageView.image.size = CGSizeMake(20, 20);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor whiteColor];
    CGFloat imageViewWidth = 80;
    imageView.frame = CGRectMake(0, 0, imageViewWidth, imageViewWidth);
    imageView.center = self.view.center;
    //    imageView.layer.borderWidth = 15;
    imageView.layer.cornerRadius = imageViewWidth/2;
    //    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    //    imageView.layer.masksToBounds = YES;
    imageView.clipsToBounds = YES;
    
    //    imageView.layer.backgroundColor = [UIColor whiteColor].CGColor;
//    [self.view addSubview:imageView];
    
    
    
}
- (void)btnAction
{
    [self setupRippleAnimation];
}


#pragma mark 动画
//开始动画
- (void)startAnimation
{
    [self.view.layer addSublayer:self.staticLayer];
    [self.view.layer addSublayer:self.staticShadowLayer];
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    self.animaTionGroup = [CAAnimationGroup animation];
    self.animaTionGroup.delegate = self;
    self.animaTionGroup.duration = 1;
    self.animaTionGroup.removedOnCompletion = YES;
    self.animaTionGroup.timingFunction = defaultCurve;
    
    self.animaTionGroup.autoreverses = YES;
    self.animaTionGroup.repeatCount = MAXFLOAT;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.7;
    scaleAnimation.toValue = @0.8;
    scaleAnimation.duration = 1;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.autoreverses = YES;
    
    CAKeyframeAnimation *opencityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opencityAnimation.duration = 1;
    opencityAnimation.values = @[@0.6,@0.2,@0.2];
    opencityAnimation.keyTimes = @[@0,@0.5,@1];
    opencityAnimation.removedOnCompletion = YES;
    opencityAnimation.autoreverses = YES;
    opencityAnimation.repeatCount = MAXFLOAT;
    
    NSArray *animations = @[scaleAnimation];
    
    self.animaTionGroup.animations = animations;
    [self.staticLayer addAnimation:_animaTionGroup forKey:@"groupAnnimation"];
    [self.staticShadowLayer addAnimation:_animaTionGroup forKey:@"groupAnnimation"];
    
    
    [self.view bringSubviewToFront:self.imgView];
}

//点击事件的动画
-(void)click{
    
    self.getAddressTime = [[NSDate date] timeIntervalSince1970];
    
    
    CALayer *layer = [[CALayer alloc] init];
    layer.cornerRadius = [UIScreen mainScreen].bounds.size.width;
    layer.frame = CGRectMake(0, 0, layer.cornerRadius*2 , layer.cornerRadius*2);
    layer.borderWidth = 1;
    layer.position = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    
    UIColor *color = [UIColor redColor];
    
    UIColor *backColor = [UIColor colorWithRed:59/255.0 green:46/255.0 blue:97/255.0 alpha:0.5];
    layer.borderColor =color.CGColor;
    [self.view.layer addSublayer:layer];
    
    
    CAGradientLayer *layer1 = [[CAGradientLayer alloc] init];
    layer1.cornerRadius = [UIScreen mainScreen].bounds.size.width;
    layer1.frame = CGRectMake(0, 0, layer.cornerRadius*2-1 , layer.cornerRadius*2-1);
    layer1.position = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    backColor = [UIColor colorWithRed:100/255.0 green:46/255.0 blue:97/255.0 alpha:0.8];
    layer1.colors = [NSArray arrayWithObjects:(id)backColor.CGColor,[UIColor colorWithRed:59/255.0 green:46/255.0 blue:97/255.0 alpha:0.8].CGColor ,nil];
    
    [self.view.layer addSublayer:layer1];
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    self.animaTionGroup = [CAAnimationGroup animation];
    self.animaTionGroup.delegate = self;
    self.animaTionGroup.duration = 2;
    self.animaTionGroup.removedOnCompletion = YES;
    self.animaTionGroup.timingFunction = defaultCurve;
    
    
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.15;
    scaleAnimation.toValue = @1;
    scaleAnimation.duration = 2;
    
    
    CAKeyframeAnimation *opencityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opencityAnimation.duration = 2;
    opencityAnimation.values = @[@0.6,@0.2,@0.2];
    opencityAnimation.keyTimes = @[@0,@0.5,@1];
    opencityAnimation.removedOnCompletion = YES;
    
    
    NSArray *animations = @[scaleAnimation];
    
    self.animaTionGroup.animations = animations;
    [layer addAnimation:self.animaTionGroup forKey:@"groupAnnimation"];
    [layer1 addAnimation:self.animaTionGroup forKey:@"groupAnnimation"];
    
    [self performSelector:@selector(removeLayer:) withObject:layer afterDelay:2];
    [self performSelector:@selector(removeLayer:) withObject:layer1 afterDelay:2];
    
    [self.view bringSubviewToFront:self.imgView];
}


- (void)removeLayer:(CALayer *)layer
{
    [layer removeFromSuperlayer];
    [layer removeAnimationForKey:@"groupAnnimation"];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(action) userInfo:nil repeats:NO];
    
}

//点击事件结束2秒后开始执行startAnimation
-(void)action{
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];;
    if (currentTime-self.getAddressTime>2) {
        [self startAnimation];
        [self.timer invalidate];
        self.timer = nil;
    }else{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(action) userInfo:nil repeats:NO];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    
    [self.staticShadowLayer removeFromSuperlayer];
    [self.staticShadowLayer removeAnimationForKey:@"groupAnnimation"];
    [self.staticLayer removeFromSuperlayer];
    [self.staticLayer removeAnimationForKey:@"groupAnnimation"];
    
    self.disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(click)];
    self.disPlayLink.frameInterval = 40.0;
    [self.disPlayLink  addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)delayAnimation
{
    [self startAnimation];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.view.layer removeAllAnimations];
    [self.disPlayLink  invalidate];
    self.disPlayLink  = nil;
}
@end
