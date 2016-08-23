//
//  ViewController.m
//  LImagePicker
//
//  Created by liguohuai on 16/8/22.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "ViewController.h"
#import "LImagePickerViewController.h"
@interface ViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView  *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)setupUI{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 50, 100, 50)];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"选取" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 0.5;
    [button addTarget:self action:@selector(imagePicker) forControlEvents:UIControlEventTouchUpInside];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, 100, 100)];
    [self.view addSubview:self.imageView];
    [self.view addSubview:button];
}
- (void)imagePicker{
    UIActionSheet *sheet = nil;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"选取现有的",@"取消", nil];
    }else {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"选取现有的",@"取消", nil];
    }
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;{
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        switch (buttonIndex) {
            case 0:
                [self presentToCamera];
                break;
            case 1:
                [self presentToImagePicker];
                break;
          default:
                break;
        }
    }
    else {
        if (buttonIndex == 0) {
            [self presentToImagePicker];
        }
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    self.imageView.image = image;
    NSLog(@"%@",editingInfo);
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 跳转
- (void)presentToCamera{
    // 跳转到相机页面
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)presentToImagePicker{
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    LImagePickerViewController *picker = [[LImagePickerViewController alloc]init];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
