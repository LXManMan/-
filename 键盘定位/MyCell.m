//
//  MyCell.m
//  键盘定位
//
//  Created by chuanglong02 on 16/10/24.
//  Copyright © 2016年 漫漫. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell
+(UINib *)nib
{
    NSString *string = NSStringFromClass([self class]);
    return [UINib nibWithNibName:string bundle:nil];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.commentBtn.backgroundColor = LBRandomColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
