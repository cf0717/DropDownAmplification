//
//  ViewController.m
//  导航栏渐变文字效果
//
//  Created by chaofan on 2016/10/14.
//  Copyright © 2016年 chaofan. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    MainViewController *mainVC = [[MainViewController alloc]init];
    [self.navigationController pushViewController:mainVC animated:YES];
}

@end
