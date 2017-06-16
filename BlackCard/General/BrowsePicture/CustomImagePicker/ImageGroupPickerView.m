//
//  ImageGroupPickerView.m
//  magicbean
//
//  Created by cwytm on 16/3/21.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "ImageGroupPickerView.h"
#import "SCImageGroupPickerObject.h"

@implementation ImageGroupPickerView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 10)];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 1)];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section {
    if (self.assetGroups.count > 0) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return [self.assetGroups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    SCImageGroupPickerObject *obj = [self.assetGroups objectAtIndex:row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",obj.groupNameS,@(obj.groupImageNum)];
    cell.imageView.image = obj.groupImage;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    [self.delegate view:self didAction:kAction_ImageGroup data:@(row)];
}


#pragma mark - didAction
- (IBAction)didActionDismissView:(id)sender {
     [self.delegate view:self didAction:kAction_ImageGroupViewDismiss data:nil];
}


#pragma mark - private
- (void) show {
    WEAKSELF
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
    }];
}
- (void) dismiss {
    WEAKSELF
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.frame = CGRectMake(0, -kMainScreenHeight, kMainScreenWidth, kMainScreenHeight);
    }];
}


@end
