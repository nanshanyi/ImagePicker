//
//  LIamgePickerViewController.h
//  LImagePicker
//
//  Created by liguohuai on 16/8/22.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol LImagePickerTableViewDelegate <NSObject>

- (void)didFinishPickingImage:(NSArray *)images;

@end

@interface LImagePickerTableViewController : UITableViewController
@property (weak, nonatomic) id <LImagePickerTableViewDelegate> delegate;
@end
