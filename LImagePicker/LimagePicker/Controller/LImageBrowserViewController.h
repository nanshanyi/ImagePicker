//
//  LImageBrowserViewController.h
//  LImagePicker
//
//  Created by 李国怀 on 2016/8/29.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LImageBrowserViewController : UIViewController
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) NSInteger  selectIndex;
@end
