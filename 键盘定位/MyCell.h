//
//  MyCell.h
//  键盘定位
//
//  Created by chuanglong02 on 16/10/24.
//  Copyright © 2016年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
+(UINib *)nib;
@end
