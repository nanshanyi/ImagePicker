//
//  LImageBrowserCell.m
//  LImagePicker
//
//  Created by 李国怀 on 2016/8/29.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LImageBrowserCell.h"

@implementation LImageBrowserCell

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage*)image{
    if (self = [super initWithFrame:frame]) {
        [self initSubViewsWith:image];
    }
    return self;
}

- (void)initSubViewsWith:(UIImage*)image{
    self.zoomScale = 1.0;
    self.bounces = NO;
    self.maximumZoomScale = 3.0;
    self.minimumZoomScale = 1.0;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    [self addSubview:imageView];
}

@end
