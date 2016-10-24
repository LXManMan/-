//
//  ViewController.m
//  键盘定位
//
//  Created by chuanglong02 on 16/10/24.
//  Copyright © 2016年 漫漫. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
static NSString *cellIndentifier = @"cell";
#import "LXKeyBoardToolView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UITextField *textField;
@property (nonatomic, assign) CGFloat history_Y_offset;//记录table的offset.y
@property(nonatomic,strong)NSIndexPath *selectedIndexPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    YYFPSLabel *lable  =[[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 0, 64, 30)];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:lable];
    
    self.textField =[[UITextField alloc]initWithFrame:CGRectMake(0, Device_Height, Device_Width, 40)];
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    
    LXKeyBoardToolView *toolView =[[LXKeyBoardToolView alloc]initWithFrame:CGRectMake(0, 0, Device_Width, 40)];
    toolView.backgroundColor =[UIColor grayColor];
    self.textField.inputAccessoryView = toolView;
    [self.textField resignFirstResponder];
    
    [self.view addSubview:self.tableview];
    
    UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Device_Width, 370)];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    imageview.image =[UIImage imageNamed:@"pbg.jpg"];
    self.tableview.tableHeaderView = imageview;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell =[[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    [cell.commentBtn addTarget:self action:@selector(commentAction: ) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)commentAction:(UIButton *)button
{
    MyCell *cell =(MyCell *) button.superview.superview;
     UIWindow *window =[UIApplication sharedApplication].keyWindow;
    self.history_Y_offset = [cell.contentLabel convertRect:cell.contentLabel.bounds toView:window].origin.y;
    self.selectedIndexPath = [self.tableview indexPathForCell:cell];

//    MyCell *cell = (MyCell *)button.superview.superview;
    [self.textField becomeFirstResponder];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.textField resignFirstResponder];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)keyboardFrameChange:(NSNotification *)notification
{

    
    if (self.tableview.isDragging) {
        return;
    }
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardRect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    CGFloat delta = 0.0;
   
        delta = self.history_Y_offset - ([UIApplication sharedApplication].keyWindow.bounds.size.height - keyboardHeight-40-1);//
   
    CGPoint offset = self.tableview.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
//    [UIView animateWithDuration:0.05 animations:^{
        [self.tableview setContentOffset:offset animated:YES];
    
//    }];
    MyCell *cell =[self.tableview cellForRowAtIndexPath:self.selectedIndexPath];
    UIWindow *window =[UIApplication sharedApplication].keyWindow;

    self.history_Y_offset = [cell.contentLabel convertRect:cell.contentLabel.bounds toView:window].origin.y;

}

-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Device_Width, Device_Height ) style:UITableViewStylePlain];
        _tableview.delegate =  self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.tableFooterView =[UIView new];
        _tableview.rowHeight = 100;
        [_tableview registerNib:[MyCell nib] forCellReuseIdentifier:cellIndentifier];
        
    }
    return _tableview;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textField resignFirstResponder];
}

@end
