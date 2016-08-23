//
//  LImagePickerToolBar.m
//  LImagePicker
//
//  Created by liguohuai on 16/8/23.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LImagePickerToolBar.h"

@interface LImagePickerToolBar ()

@property (nonatomic ,strong)UILabel *numLable;

@end

@implementation LImagePickerToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self customUI];
    }
    return self;
}
- (void)customUI{

    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setTitle:@"预览" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    UIBarButtonItem *fixedBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.rightItem = [[UIBarButtonItem alloc]initWithCustomView:[self itemCustomView]];
    //        item.enabled  = NO;
    self.items = @[_leftItem,fixedBtn,_rightItem];
}
- (UIButton*)itemCustomView{
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [backButton addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"完成" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [backButton setTitleColor:[UIColor colorWithRed:50/255.f green:178/255.f blue:0 alpha:1] forState:UIControlStateNormal];
    _numLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 20, 20)];
    _numLable.layer.cornerRadius = 10;
    _numLable.backgroundColor = [UIColor colorWithRed:50/255.f green:178/255.f blue:0 alpha:1];
    _numLable.hidden = YES;
    [backButton addSubview:_numLable];
    return backButton;
}
- (void)updateStatus:(NSInteger)count{
    self.numLable.hidden = count > 0;
    self.numLable.transform = CGAffineTransformScale(self.numLable.transform, 0.5, 0.5);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.numLable.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.numLable.text = [NSString stringWithFormat:@"%ld",count];
    }];
    
}

- (void)leftItemClick{
    if ([self.ldelegate respondsToSelector:@selector(itemClickWithItemType:)]) {
        [self.ldelegate itemClickWithItemType:ItemTypeLeft];
    }
}
- (void)rightItemClick{
    if ([self.ldelegate respondsToSelector:@selector(itemClickWithItemType:)]) {
        [self.ldelegate itemClickWithItemType:ItemTypeRight];
    }
}

@end
