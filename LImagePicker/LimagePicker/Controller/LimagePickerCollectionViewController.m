//
//  LimagePickerCollectionViewController.m
//  LImagePicker
//
//  Created by liguohuai on 16/8/22.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LimagePickerCollectionViewController.h"
#import "LimagePickerCollectionViewCell.h"
#import "LImagePickerToolBar.h"
#import "LImageBrowserViewController.h"

@interface LimagePickerCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,LImagePickerToolBarDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *assetArray;

@property (nonatomic, strong) NSMutableArray *selectedAssetArray;

@property (nonatomic, strong) NSMutableArray *selectImageArray;

@property (nonatomic, strong) NSMutableArray *allImageArray;

@property (nonatomic, strong) LImagePickerToolBar *toolBar;

@end

@implementation LimagePickerCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
#define edgemargin 7
#define itemSizeWH ([UIScreen mainScreen].bounds.size.width - 5 * edgemargin) / 4.0

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [_assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[LimagePickerCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    [self.view addSubview:self.toolBar];
    
}
- (void)loadData{
    _assetArray = [NSMutableArray array];
    _selectImageArray = [NSMutableArray array];
    _selectedAssetArray = [NSMutableArray array];
    _allImageArray = [NSMutableArray array];
    [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result) {
            [self.assetArray addObject:result];
            [self.allImageArray addObject:[UIImage imageWithCGImage:result.aspectRatioThumbnail]];
        }
    }];
    
    [self.collectionView reloadData];
}
- (void)rightItemClick{

    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LimagePickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ALAsset *asset = self.assetArray[indexPath.row];
    [cell updateWith:asset isSelected:[self cellPhotoIsSelected:asset]];
    __weak typeof (self)weakSelf = self;
    cell.cellBlock = ^(BOOL selected){
        selected ? [weakSelf.selectedAssetArray addObject:asset] : [weakSelf.selectedAssetArray removeObject:asset];
        [weakSelf changeToolBarStatus];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LImageBrowserViewController *imageBrowser = [[LImageBrowserViewController alloc]init];
    imageBrowser.images = self.allImageArray;
    imageBrowser.selectIndex = indexPath.row;
    [self.navigationController pushViewController:imageBrowser animated:YES];
}

- (BOOL)cellPhotoIsSelected:(ALAsset*)asset{
    return  [self.selectedAssetArray containsObject:asset];
}

- (void)changeToolBarStatus{

    [self.toolBar updateStatus:(NSInteger)self.selectedAssetArray.count];
}

#pragma mark - LImagePickerToolBarDelegate
- (void)itemClickWithItemType:(ItemType)itemType{
    [_selectImageArray removeAllObjects];
    [_selectedAssetArray enumerateObjectsUsingBlock:^(ALAsset *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *image = [UIImage imageWithCGImage:obj.aspectRatioThumbnail];
        [_selectImageArray addObject:image];
    }];
    if (itemType == ItemTypePreview) {
        LImageBrowserViewController *browserViewController = [[LImageBrowserViewController alloc]init];
        browserViewController.images = _selectImageArray;
        browserViewController.selectIndex = 0;
        [self.navigationController pushViewController:browserViewController animated:YES];
    }else {
        if ([self.delegate respondsToSelector:@selector(didFinishPickingImages:)]) {
            [self.delegate didFinishPickingImages:_selectImageArray];
        }
    }
}


#pragma mark - Get
- (UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = edgemargin;
        layout.minimumInteritemSpacing = edgemargin;
        layout.itemSize = CGSizeMake(itemSizeWH, itemSizeWH);
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.contentInset = UIEdgeInsetsMake(edgemargin, edgemargin, 50, edgemargin);
        _collectionView.backgroundColor = [UIColor whiteColor];

        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
- (LImagePickerToolBar*)toolBar{
    if (!_toolBar) {
        _toolBar = [[LImagePickerToolBar alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40)];
        _toolBar.ldelegate = self;
    }
    return _toolBar;
}

@end
