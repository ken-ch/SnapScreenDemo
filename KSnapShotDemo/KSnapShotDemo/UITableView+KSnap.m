//
//  UITableView+KSnap.m
//  KSnapShotDemo
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018 mac. All rights reserved.
//

#import "UITableView+KSnap.h"

@implementation UITableView (KSnap)

-(UIImage *)tableShotImage{
    UIImage *tableImg = nil;
    
    NSInteger tableViewContentHeight = self.tableViewContentHeight;
    NSInteger tableViewSectionHeaderHeight = self.tableViewSectionHeaderHeight;
    NSInteger tableViewSectionFooterHeight = self.tableViewSectionFooterHeight;
    
    //滚回到顶部 (回滚到顶部是否报错)
    [self setContentOffset:CGPointMake(0,0) animated:NO];
    
    CGPoint originalOffset = self.contentOffset;
    NSInteger finalHeight = tableViewContentHeight + tableViewSectionHeaderHeight + tableViewSectionFooterHeight;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.frame.size.width, finalHeight), YES, 1);
    
    CGPoint savedContentOffset = self.contentOffset;
    CGRect savedFrame = self.frame;
    
    self.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    self.contentOffset = CGPointZero;
    
    [self.layer renderInContext: UIGraphicsGetCurrentContext()];
    tableImg = UIGraphicsGetImageFromCurrentImageContext();

    self.contentOffset = savedContentOffset;
    self.frame = savedFrame;
    
    UIGraphicsEndImageContext();
    
    self.contentOffset = originalOffset;
    
    return tableImg;
}
//循环取出table存在的cell
-(NSArray *)indexPaths{
    NSMutableArray *indexPaths = @[].mutableCopy;
    for (int i = 0; i< self.numberOfSections; i++) {
        NSInteger rows = [self numberOfRowsInSection:i];
        for (int j = 0; j< rows ; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            [indexPaths addObject:indexPath];
        }
    }
    return indexPaths.copy;
}
//获取所有cell的高度
-(NSInteger )tableViewContentHeight{
    NSInteger result = 0;
    for (NSIndexPath *indexPath in self.indexPaths) {
        
        NSInteger lastSectionIndex=[self numberOfSections]-1;
        NSInteger lastRowIndex=[self numberOfRowsInSection: lastSectionIndex ]-1;
        if (lastRowIndex > 0) {    //在这里加了一个判断 防止在row为0时的直接崩溃
            [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
             UITableViewCell *cell = (UITableViewCell*)[self cellForRowAtIndexPath:indexPath];
            result += cell.frame.size.height;
        }
    }
    return  result;
}
//获取所有sectionHeader的高度
-(NSInteger )tableViewSectionHeaderHeight{
    NSInteger result = 0;
    if ([self respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        NSInteger sectionHeight = 0;
        for (int i = 0; i < self.numberOfSections; i++) {
            sectionHeight = [self.delegate tableView:self heightForHeaderInSection:i];
            result += sectionHeight;
        }
    }
    return result;
}

//获取所有sectionFooter的高度
-(NSInteger )tableViewSectionFooterHeight{
    NSInteger result = 0;
    if ([self respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        NSInteger sectionHeight = 0;
        for (int i = 0; i < self.numberOfSections; i++) {
            sectionHeight = [self.delegate tableView:self heightForFooterInSection:i];
            result += sectionHeight;
        }
    }
    return result;
}


@end
