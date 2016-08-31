//
//  LImagePickerViewController.h
//  LImagePicker
//
//  Created by liguohuai on 16/8/22.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LImagePickerViewController;

@protocol LImagePickerViewDelegate <NSObject>

- (void)limagePickerController:(LImagePickerViewController *)picker didFinishPickingImage:(NSArray *)images;

@end

@interface LImagePickerViewController : UINavigationController

@property (weak, nonatomic) id <LImagePickerViewDelegate> deleate;

@end

