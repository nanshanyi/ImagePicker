//
//  LImagePickerToolBar.h
//  LImagePicker
//
//  Created by liguohuai on 16/8/23.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ItemType) {
    ItemTypePreview,
    ItemTypeComplate
};

@protocol LImagePickerToolBarDelegate <NSObject>
/**
 *  ToolBarDelegate
 *
 *  @param itemType 左边Item
 */
- (void)itemClickWithItemType:(ItemType)itemType;

@end

@interface LImagePickerToolBar : UIToolbar

@property (nonatomic, strong) UIBarButtonItem *leftItem;
@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic,   weak) id <LImagePickerToolBarDelegate> ldelegate;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)updateStatus:(NSInteger)count;

@end
