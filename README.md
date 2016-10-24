# -
1.实现点击某一行键盘定位问题，点击评论按钮同样
2.解决了在切换键盘中英文以及接入第三方键盘（搜狗）切换时候的键盘定位问题
3.在键盘Frame改变后，当前的Contentoffset会发生改变，所以重置完contentoffset后，需要定位的按钮或者评论行也需要重新设置

        delta = self.history_Y_offset - ([UIApplication sharedApplication].keyWindow.bounds.size.height - keyboardHeight-40-1);//
   
    CGPoint offset = self.tableview.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }

        [self.tableview setContentOffset:offset animated:YES];

    MyCell *cell =[self.tableview cellForRowAtIndexPath:self.selectedIndexPath];
    UIWindow *window =[UIApplication sharedApplication].keyWindow;

    self.history_Y_offset = [cell.contentLabel convertRect:cell.contentLabel.bounds toView:window].origin.y;
