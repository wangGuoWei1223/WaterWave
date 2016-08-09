//
//  waveView.m
//  wave
//
//  Created by niuwan on 16/7/22.
//  Copyright © 2016年 niuwan. All rights reserved.
//

#import "waveView.h"

@interface waveView ()

@property (nonatomic, strong) CAShapeLayer *waveShapeLayer;
@property (nonatomic, strong) CAShapeLayer *waveShapeLayerT;
@property (nonatomic, strong) UIColor *waveColoer;
@property (nonatomic, strong) UIColor *waveColoerT;
/**  <#Description#>  */
@property (nonatomic, strong) CADisplayLink *waveDisplayLink;
@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, assign) CGFloat waveSpeed;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) CGFloat waveWidth;
@property (nonatomic, assign) CGFloat waveAmplitude;

@property (nonatomic, assign) CGFloat offsetXT;

@end


@implementation waveView

- (void)initData {

    self.waveSpeed = 3.0;
    self.waveHeight = self.frame.size.height * 0.7 - 20;
    self.waveWidth = self.frame.size.width;
    
    self.waveAmplitude = 70.0;

}

- (void)wave {
    
    /**
     *  创建两个layer
     */
    
    self.waveShapeLayer = [CAShapeLayer layer];
    self.waveShapeLayer.fillColor = self.waveColoer.CGColor;
    [self.layer addSublayer:self.waveShapeLayer];
    
    
    self.waveShapeLayerT = [CAShapeLayer layer];
    self.waveShapeLayerT.fillColor = self.waveColoerT.CGColor;
    [self.layer addSublayer:self.waveShapeLayerT];
    
    /**
     *  定时器
     */
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)getCurrentWave {
    
    //offsetX决定x位置
    self.offsetX += self.waveSpeed;
    
    //声明第一条波曲线的路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始点
    CGPathMoveToPoint(path, nil, 0, self.waveHeight);
    
    CGFloat y = 0.f;
    //第一个波公式
    for (float x = 0.f; x <= self.waveWidth; x++) {
        
        y = self.waveAmplitude * sin((490 / self.waveWidth) * (x * M_PI / 180) - self.offsetX * M_PI / 270) + self.waveHeight*1;
        
        CGPathAddLineToPoint(path, nil, x, y);
        x++;
    }
    //把绘图信息添加到路径里
    CGPathAddLineToPoint(path, nil, self.waveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    //结束绘图信息
    CGPathCloseSubpath(path);
    
    self.waveShapeLayer.path = path;
    
    //释放绘图路径
    CGPathRelease(path);
    
    
    /*
     *  第二个
     */
    self.offsetXT += self.waveSpeed;
    CGMutablePathRef pathT = CGPathCreateMutable();
    CGPathMoveToPoint(pathT, nil, 0, self.waveHeight+100);
    
    CGFloat yT = 0.f;
    for (float x = 0.f; x <= self.waveWidth ; x++) {
        yT = self.waveAmplitude*1.6 * sin((600 / self.waveWidth) * (x * M_PI / 180) - self.offsetXT * M_PI / 180) + self.waveHeight;
        CGPathAddLineToPoint(pathT, nil, x, yT-10);
    }
    CGPathAddLineToPoint(pathT, nil, self.waveWidth, self.frame.size.height);
    CGPathAddLineToPoint(pathT, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(pathT);
    self.waveShapeLayerT.path = pathT;
    CGPathRelease(pathT);

}

- (UIColor *)waveColoer {
    
    if (!_waveColoer) {
        _waveColoer = [UIColor lightGrayColor];
    }
    return _waveColoer;
}
- (UIColor *)waveColoerT {
    
    if (!_waveColoerT) {
        _waveColoerT = [UIColor grayColor];
    }
    return _waveColoerT;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self initData];
    
    [self wave];
    
}


@end
