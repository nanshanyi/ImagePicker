//
//  LimagePickerCollectionViewCell.h
//  LImagePicker
//
//  Created by liguohuai on 16/8/22.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
typedef void(^PickerCollectionCellBlock)(BOOL selected);
@interface LimagePickerCollectionViewCell : UICollectionViewCell
@property (nonatomic,   copy) PickerCollectionCellBlock cellBlock;

- (void)updateWith:(ALAsset *)asset isSelected:(BOOL)selected;
@end
