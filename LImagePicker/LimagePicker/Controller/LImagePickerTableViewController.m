//
//  LIamgePickerViewController.m
//  LImagePicker
//
//  Created by liguohuai on 16/8/22.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LImagePickerTableViewController.h"
#import "LimagePickerCollectionViewController.h"
#import "LimagepickerTableViewCell.h"
@interface LImagePickerTableViewController ()
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *assetGroupArray;
@end

@implementation LImagePickerTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
    
}

-(void)setupUI{
    self.tableView.tableFooterView = [UIView new];
    self.title = @"照片";
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];

}
- (void)loadData{
    _assetGroupArray = [NSMutableArray array];
    __weak typeof (self)weakSelf = self;
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            if (group.numberOfAssets > 0) {
                [weakSelf.assetGroupArray addObject:group];
            }
        }else{
            [weakSelf.tableView reloadData];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)rightItemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _assetGroupArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdenfifier = @"cellIdenfifier";
    LimagepickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenfifier];
    if(cell == nil) {
        cell = [[LimagepickerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenfifier];
    }
    ALAssetsGroup *group = self.assetGroupArray[indexPath.row];
    [cell updateCellWith:group];
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LimagePickerCollectionViewController *pickerCollectionVC = [[LimagePickerCollectionViewController alloc]init];
    pickerCollectionVC.assetsGroup = self.assetGroupArray[indexPath.row];
    
    [self.navigationController pushViewController:pickerCollectionVC animated:YES];
}

#pragma mark - Get

- (ALAssetsLibrary*)assetsLibrary{
    if (!_assetsLibrary) {
       _assetsLibrary = [[ALAssetsLibrary alloc]init];
    }
    return _assetsLibrary;
}


@end
