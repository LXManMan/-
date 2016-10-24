//
//  LXKeyBoardToolView.m
//  Inputview
//
//  Created by chuanglong02 on 16/10/23.
//  Copyright © 2016年 漫漫. All rights reserved.
//

#import "LXKeyBoardToolView.h"

@implementation LXKeyBoardToolView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initWithTextView];
    }
    return self;
}
-(void)initWithTextView
{
    self.textView =[[UITextView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, 30)];
    self.textView.backgroundColor = [UIColor redColor];
    self.textView.keyboardType = UIKeyboardTypeDefault;
    [self addSubview:self.textView];

}

@end
