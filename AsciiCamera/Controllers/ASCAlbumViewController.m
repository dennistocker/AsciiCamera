//
//  ASCAlbumViewController.m
//  AsciiCamera
//
//  Created by 程利 on 2017/12/4.
//  Copyright © 2017年 foundersc. All rights reserved.
//

#import "ASCAlbumViewController.h"
#import "ASCAlbumViewCell.h"
#import "ASCAlbumHeaderView.h"
#import "ASCImageViewController.h"
#import "ASCAlbumTransition.h"

@interface ASCAlbumViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate>

//@property (nonatomic, strong) UICollectionView *collection;

@end

@implementation ASCAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.frame), 20);
    CGFloat width = CGRectGetWidth(self.view.frame) - 20 - 5*3;
    flowLayout.itemSize = CGSizeMake(width/4, width/4);
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 20, 10);

    _collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collection.backgroundColor = [UIColor whiteColor];
    [_collection registerClass:[ASCAlbumViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [_collection registerClass:[ASCAlbumHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"supId"];
    _collection.dataSource = self;
    _collection.delegate = self;
    [self.view addSubview:_collection];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    self.navigationController.delegate = self;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ASCAlbumViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    NSString *imageName = @(indexPath.row+1).stringValue;
    cell.imageView.image = [UIImage imageNamed:imageName];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ASCAlbumHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"supId" forIndexPath:indexPath];
    view.timeLabel.text = [[NSString alloc] initWithFormat:@"第%@行", @(indexPath.section+1)];
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ASCImageViewController *vc = [[ASCImageViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {

    id<UIViewControllerAnimatedTransitioning> transition = nil;
    if ([toVC isKindOfClass:[ASCImageViewController class]]) {
        transition = [[ASCAlbumTransition alloc] initWithInverse:NO];
    }
    return transition;
}


@end
