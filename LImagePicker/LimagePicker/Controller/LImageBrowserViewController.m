//
//  LImageBrowserViewController.m
//  LImagePicker
//
//  Created by 李国怀 on 2016/8/29.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LImageBrowserViewController.h"
#import "LImageBrowserCell.h"

@interface LImageBrowserViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *browserScrollView;
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UIButton  *rightButton;
@end

@implementation LImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)setupSubviews{
    [self.view addSubview:self.browserScrollView];
    [self.view addSubview:self.navView];
    self.view.backgroundColor = [UIColor blackColor];
    [_images enumerateObjectsUsingBlock:^(UIImage *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LImageBrowserCell *cell = [[LImageBrowserCell alloc]initWithFrame:CGRectMake(idx * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height) image:obj];
        [self.browserScrollView addSubview:cell];
    }];
}
#pragma mark - 事件处理
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBtnClick{
    
}

#pragma mark - Get
- (UIScrollView *)browserScrollView{
    if (!_browserScrollView) {
        _browserScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _browserScrollView.pagingEnabled = YES;
        _browserScrollView.delegate = self;
        _browserScrollView.bounces = NO;
        _browserScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * self.images.count, self.view.bounds.size.height);
        _browserScrollView.contentOffset = CGPointMake(self.view.bounds.size.width * _selectIndex, 0);
        
    }
    return _browserScrollView;
}
- (UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        _navView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
        [backButton setImage:[UIImage imageNamed:@"navi_back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:backButton];
        [_navView addSubview:self.rightButton];

    }
    return _navView;
}
- (UIButton *)rightButton{
    if (!_rightButton) {
       _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 44, 20, 44, 44)];
        [_rightButton setImage:[UIImage imageNamed:@"photo_def_previewVc"] forState:UIControlStateNormal];
        [_rightButton setImage:[UIImage imageNamed:@"photo_sel_previewVc"] forState:UIControlStateSelected];
        [_rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

@end
