//
//  LImagePickerViewController.h
//  LImagePicker
//
//  Created by liguohuai on 16/8/22.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LImagePickerViewDelegate <NSObject>

- (void)limagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(NSArray *)images;

@end

@interface LImagePickerViewController : UINavigationController

@property (weak, nonatomic) id <LImagePickerViewDelegate> deleate;

@end
