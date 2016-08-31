//
//  LImagePickerToolBar.m
//  LImagePicker
//
//  Created by liguohuai on 16/8/23.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LImagePickerToolBar.h"

@interface LImagePickerToolBar ()

@property (nonatomic ,strong) UILabel *numLable;
@property (nonatomic, strong) UIButton *previewButton;
@property (nonatomic, strong) UIButton *complateButton;

@end

@implementation LImagePickerToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self customUI];
    }
    return self;
}
- (void)customUI{

    _previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _previewButton.frame = CGRectMake(0, 0, 40, 40);
    [_previewButton setTitle:@"预览" forState:UIControlStateNormal];
    _previewButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_previewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_previewButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_previewButton addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.leftItem = [[UIBarButtonItem alloc]initWithCustomView:_previewButton];
    UIBarButtonItem *fixedBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.rightItem = [[UIBarButtonItem alloc]initWithCustomView:[self itemCustomView]];
    [self buttonClickEnable:NO];
    self.items = @[_leftItem,fixedBtn,_rightItem];
}
- (UIButton*)itemCustomView{
    _complateButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [_complateButton addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [_complateButton setTitle:@"完成" forState:UIControlStateNormal];
    _complateButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _complateButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [_complateButton setTitleColor:[UIColor colorWithRed:50/255.f green:178/255.f blue:0 alpha:1] forState:UIControlStateNormal];
    [_complateButton setTitleColor:[UIColor colorWithRed:177/255.f green:225/255.f blue:180/255.f alpha:1] forState:UIControlStateDisabled];
    _numLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 20, 20)];
    _numLable.textColor = [UIColor whiteColor];
    _numLable.layer.masksToBounds = YES;
    _numLable.textAlignment = NSTextAlignmentCenter;
    _numLable.layer.cornerRadius = 10;
    _numLable.backgroundColor = [UIColor colorWithRed:50/255.f green:178/255.f blue:0 alpha:1];
    _numLable.hidden = YES;
    [_complateButton addSubview:_numLable];
    return _complateButton;
}
- (void)updateStatus:(NSInteger)count{
    [self buttonClickEnable:count > 0];
    self.numLable.transform = CGAffineTransformScale(self.numLable.transform, 0.5, 0.5);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.numLable.transform = CGAffineTransformIdentity;
        self.numLable.text = [NSString stringWithFormat:@"%ld",count];
    } completion:nil];
    
}
- (void)buttonClickEnable:(BOOL)enable{
    self.numLable.hidden = !enable;
    _previewButton.enabled = enable;
    _complateButton.enabled = enable;
}

- (void)leftItemClick{
    NSLog(@"预览点击");
    if ([self.ldelegate respondsToSelector:@selector(itemClickWithItemType:)]) {
        [self.ldelegate itemClickWithItemType:ItemTypePreview];
    }
}
- (void)rightItemClick{
    NSLog(@"完成点击");
    if ([self.ldelegate respondsToSelector:@selector(itemClickWithItemType:)]) {
        [self.ldelegate itemClickWithItemType:ItemTypeComplate];
    }
}

@end
