//
//  LimagepickerTableViewCell.h
//  LImagePicker
//
//  Created by liguohuai on 16/8/22.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface LimagepickerTableViewCell : UITableViewCell

- (void)updateCellWith:(ALAssetsGroup*)asset;

@end
