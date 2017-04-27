//
//  RollTextView.h
//  功能测试集3
//
//  Created by gmtx on 15/12/16.
//  Copyright © 2015年 gmtx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RollTextView : UIView
-(instancetype)initWithFrame:(CGRect)frame texts:(NSArray<NSString *> *)textArray attributes:(NSArray<NSDictionary *> *)attributes;
@property(nonatomic, strong)NSArray<NSString *> * texts;
@property(nonatomic, strong)NSArray<NSDictionary *> *attributes;

-(void)checkAnimation;
@end
