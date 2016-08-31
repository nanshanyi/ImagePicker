//
//  LimagePickerCollectionViewController.h
//  LImagePicker
//
//  Created by liguohuai on 16/8/22.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol LimagePickerCollectionViewDelegate <NSObject>

- (void)didFinishPickingImages:(NSArray *)images;

@end

@interface LimagePickerCollectionViewController : UIViewController

@property (nonatomic, weak) id <LimagePickerCollectionViewDelegate> delegate;

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;

@end
