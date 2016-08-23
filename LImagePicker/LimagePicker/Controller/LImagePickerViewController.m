//
//  LImagePickerViewController.m
//  LImagePicker
//
//  Created by liguohuai on 16/8/22.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LImagePickerViewController.h"
#import "LImagePickerTableViewController.h"
@interface LImagePickerViewController ()

@end

@implementation LImagePickerViewController

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return [self setupRoot];
}

- (LImagePickerViewController*)setupRoot{
    LImagePickerTableViewController *pickerTableViewVC = [[LImagePickerTableViewController alloc]init];
//    self.viewControllers = @[pickerTableViewVC];
    return [self initWithRootViewController:pickerTableViewVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
