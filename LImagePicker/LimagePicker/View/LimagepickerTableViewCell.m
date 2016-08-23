//
//  LimagepickerTableViewCell.m
//  LImagePicker
//
//  Created by liguohuai on 16/8/22.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LimagepickerTableViewCell.h"

@interface LimagepickerTableViewCell()

@property (nonatomic, strong) UIImageView *contentImageView;

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation LimagepickerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    [self.contentView addSubview:self.contentImageView];
    [self.contentView addSubview:self.contentLabel];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)updateCellWith:(ALAssetsGroup*)group{
    
    self.contentLabel.attributedText = [self albumTitle:group];
    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            self.contentImageView.image = [UIImage imageWithCGImage:result.aspectRatioThumbnail];
            *stop = YES;
        }
    }];
}

- (NSAttributedString *)albumTitle:(ALAssetsGroup *)assetsGroup
{
    NSString *albumTitle = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    NSString *numberString = [NSString stringWithFormat:@"  (%@)",@(assetsGroup.numberOfAssets)];
    NSString *cellTitleString = [NSString stringWithFormat:@"%@%@",albumTitle,numberString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cellTitleString];
    [attributedString setAttributes: @{
                                       NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                                       NSForegroundColorAttributeName : [UIColor blackColor],
                                       }
                              range:NSMakeRange(0, albumTitle.length)];
    [attributedString setAttributes:@{
                                      NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                                      NSForegroundColorAttributeName : [UIColor grayColor],
                                      } range:NSMakeRange(albumTitle.length, numberString.length)];
    return attributedString;
    
}

#pragma mark - Get
- (UIImageView*)contentImageView{
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 70, 70)];
        _contentImageView.layer.masksToBounds = YES;
        _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _contentImageView;
}
- (UILabel*)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 200, 80)];
        
    }
    return _contentLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
