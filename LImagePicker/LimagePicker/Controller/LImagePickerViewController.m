//
//  LImagePickerViewController.m
//  LImagePicker
//
//  Created by liguohuai on 16/8/22.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LImagePickerViewController.h"
#import "LImagePickerTableViewController.h"
@interface LImagePickerViewController ()<LImagePickerTableViewDelegate>

@end

@implementation LImagePickerViewController

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return [self setupRoot];
}

- (LImagePickerViewController*)setupRoot{
    LImagePickerTableViewController *pickerTableViewVC = [[LImagePickerTableViewController alloc]init];
    pickerTableViewVC.delegate = self;
    return [self initWithRootViewController:pickerTableViewVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - LImagePickerTableViewDelegate

- (void)didFinishPickingImage:(NSArray *)images{
    if ([self.deleate respondsToSelector:@selector(limagePickerController:didFinishPickingImage:)]) {
        [self.deleate limagePickerController:self didFinishPickingImage:images];
    }
}
@end
