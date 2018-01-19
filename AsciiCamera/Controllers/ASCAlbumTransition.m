//
//  ASCAlbumTransition.m
//  AsciiCamera
//
//  Created by 程利 on 2017/12/5.
//  Copyright © 2017年 foundersc. All rights reserved.
//

#import "ASCAlbumTransition.h"
#import "ASCAlbumViewController.h"
#import "ASCAlbumViewCell.h"
#import "ASCImageViewController.h"

@interface ASCAlbumTransition ()

@property (nonatomic, assign) BOOL inverse;

@end

@implementation ASCAlbumTransition

- (instancetype)initWithInverse:(BOOL)inverse
{
    self = [super init];
    if (self) {
        _inverse = inverse;
    }

    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (!_inverse) {
        [self pushTransition:transitionContext];
    } else {
        [self popTransition:transitionContext];
    }
}

- (void)pushTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    ASCImageViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ASCAlbumViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    ASCAlbumViewCell *cell = (ASCAlbumViewCell *)[fromVC.collection cellForItemAtIndexPath:[[fromVC.collection indexPathsForSelectedItems] firstObject]];
    UIView *snapShotView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = fromVC.cellRect = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    cell.imageView.hidden = YES;

    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;

    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];

    toVC.imageView.image = cell.imageView.image;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.alpha = 1;
        snapShotView.frame = [containerView convertRect:toVC.imageView.frame toView:toVC.view];
    } completion:^(BOOL finished) {
        cell.imageView.hidden = NO;
        toVC.imageView.hidden = NO;
        [snapShotView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)popTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    ASCAlbumViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ASCImageViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    UIView *snapShotView = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.backgroundColor = [UIColor clearColor];
    snapShotView.frame = [containerView convertRect:fromVC.imageView.frame fromView:fromVC.imageView.superview];
    fromVC.imageView.hidden = YES;

    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];

    ASCAlbumViewCell *cell = (ASCAlbumViewCell *)[toVC.collection cellForItemAtIndexPath:toVC.indexPath];
    cell.imageView.hidden = YES;

    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0;
        snapShotView.frame = toVC.cellRect;
    } completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        fromVC.imageView.hidden = NO;
        cell.imageView.hidden = NO;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
@end
