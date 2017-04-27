//
//  ViewController.m
//  跑马灯
//
//  Created by 品德信息 on 2017/3/3.
//  Copyright © 2017年 品德信息. All rights reserved.
//

#import "ViewController.h"
#import "RollTextView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UISplitViewController
    NSString *rollStr = [NSString stringWithFormat:@"%@%@",@"南京品德信息技术有限公司",@""];
    
    //跑马灯
    RollTextView  *rolltextView = [[RollTextView alloc] initWithFrame:CGRectMake(30, 28, 140, 30) texts:@[rollStr] attributes:@[@{NSFontAttributeName:[UIFont systemFontOfSize:16.0], NSForegroundColorAttributeName:[UIColor redColor]}]];
    
    [self.view addSubview:rolltextView];
}


@end
