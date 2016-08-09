//
//  ViewController.m
//  wave
//
//  Created by niuwan on 16/7/22.
//  Copyright © 2016年 niuwan. All rights reserved.
//

#import "ViewController.h"
#import "waveView.h"

@interface ViewController ()

@property (nonatomic, strong) waveView *wave_view;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wave_view = [[waveView alloc] initWithFrame:self.view.bounds];
    self.wave_view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.wave_view];


}



@end
