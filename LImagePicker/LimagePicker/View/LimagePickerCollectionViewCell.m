//
//  LimagePickerCollectionViewCell.m
//  LImagePicker
//
//  Created by liguohuai on 16/8/22.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LimagePickerCollectionViewCell.h"

@interface LimagePickerCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *selectButton;

@end

@implementation LimagePickerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.selectButton];
}

- (void)updateWith:(ALAsset *)asset isSelected:(BOOL)selected{
    _selectButton.selected = selected;
    UIImage *image = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
    self.imageView.image = image;
}

- (void)secetBtnClick{
    _selectButton.selected = !_selectButton.selected;
    if (self.cellBlock) {
        _cellBlock(_selectButton.selected);
    }
}
#pragma mark - Get
- (UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.layer.masksToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}
- (UIButton*)selectButton{
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectButton.frame = CGRectMake(self.bounds.size.width - 30, 0, 30, 30);
//        _selectButton.contentMode = UIViewContentModeTopRight;
        [_selectButton setImage:[UIImage imageNamed:@"photo_def_photoPickerVc"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"photo_sel_photoPickerVc"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(secetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}
@end
