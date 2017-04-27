//
//  RollTextView.m
//  功能测试集3
//
//  Created by gmtx on 15/12/16.
//  Copyright © 2015年 gmtx. All rights reserved.
//

#import "RollTextView.h"

#define LabelSpace 50

@interface RollTextView()
@property(nonatomic, strong)UILabel *label;
@property(nonatomic, strong)UILabel  *expandLabel;

@property(nonatomic, assign)BOOL isAnimation;
@property(nonatomic, assign)BOOL shoulAnimation;
@end

@implementation RollTextView

-(instancetype)initWithFrame:(CGRect)frame texts:(NSArray<NSString *> *)textArray attributes:(NSArray<NSDictionary *> *)attributes
{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        //文字长度
        __block CGFloat textWidth = 0;
        _attributes = attributes;
        NSMutableAttributedString *textString = [[NSMutableAttributedString alloc]init];
        [textArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSAttributedString *string = [[NSAttributedString alloc]initWithString:obj attributes:attributes[idx]];
            [textString appendAttributedString:string];
            CGSize size = [obj boundingRectWithSize:CGSizeMake(MAXFLOAT, frame.size.height) options:NSStringDrawingTruncatesLastVisibleLine |
                                 NSStringDrawingUsesLineFragmentOrigin |
                                 NSStringDrawingUsesFontLeading
                         attributes:attributes[idx] context:nil].size;
            textWidth += size.width;
        }];
        if (textWidth > frame.size.width) {
            self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, textWidth, frame.size.height)];
            self.expandLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.label.frame.origin.y + self.label.bounds.size.width + LabelSpace, 0, textWidth, frame.size.height)];
            [self addSubview:self.label];
            [self addSubview:self.expandLabel];
            self.label.attributedText = textString;
            self.expandLabel.attributedText = textString;
            //
            [self addAniamtion];
            self.shoulAnimation = YES;
        }
        else
        {
            self.label = [[UILabel alloc]initWithFrame:self.bounds];
            self.label.attributedText = textString;
            self.label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.label];
            self.shoulAnimation = NO;
        }
    }
    return self;
}

-(void)setTexts:(NSArray<NSString *> *)texts
{
    _texts = texts;
    [self.label.layer removeAllAnimations];
    if (self.expandLabel) {
        [self.expandLabel.layer removeAllAnimations];
    }
    //文字长度
    __block CGFloat textWidth = 0;
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc]init];
    [texts enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSAttributedString *string = [[NSAttributedString alloc]initWithString:obj attributes:self.attributes[idx]];
        [textString appendAttributedString:string];
        CGSize size = [obj boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                     attributes:self.attributes[idx] context:nil].size;
        textWidth += size.width;
    }];
    if (textWidth > self.frame.size.width) {
        self.label.frame = CGRectMake(0, 0, textWidth, self.frame.size.height);
        self.label.textAlignment = NSTextAlignmentLeft;
        if (!self.expandLabel) {
            self.expandLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.label.frame.origin.y + self.label.bounds.size.width + LabelSpace, 0, textWidth, self.frame.size.height)];
            [self addSubview:self.expandLabel];
        }
        else
        {
            self.expandLabel.frame = CGRectMake(self.label.frame.origin.y + self.label.bounds.size.width + LabelSpace, 0, textWidth, self.frame.size.height);
        }
        self.label.attributedText = textString;
        self.expandLabel.attributedText = textString;
        //
        [self addAniamtion];
        self.shoulAnimation = YES;
    }
    else
    {
        self.label.frame = self.bounds;
        self.label.attributedText = textString;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.shoulAnimation = NO;
        self.expandLabel.text = @"";
    }
}

-(void)addAniamtion
{
    self.isAnimation = YES;
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    positionAnimation.duration = 10;
    positionAnimation.repeatCount = HUGE_VALF;
    positionAnimation.toValue = @(self.label.layer.position.x - self.label.bounds.size.width - LabelSpace);
    positionAnimation.delegate = self;
    [self.label.layer addAnimation:positionAnimation forKey:positionAnimation.keyPath];
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    expandAnimation.duration = 10;
    expandAnimation.repeatCount = HUGE_VALF;
    expandAnimation.toValue = @(self.expandLabel.layer.position.x - self.expandLabel.bounds.size.width - LabelSpace);
    [self.expandLabel.layer addAnimation:expandAnimation forKey:expandAnimation.keyPath];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.isAnimation = NO;
}

-(void)checkAnimation
{
    if (self.shoulAnimation && !self.isAnimation) {
        [self.label.layer removeAllAnimations];
        if (self.expandLabel) {
            [self.expandLabel.layer removeAllAnimations];
        }
        [self addAniamtion];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
