//
//  ASCImageViewController.m
//  AsciiCamera
//
//  Created by 程利 on 2017/12/5.
//  Copyright © 2017年 foundersc. All rights reserved.
//

#import "ASCImageViewController.h"
#import "ASCAlbumViewController.h"
#import "ASCAlbumTransition.h"
#import "ASCAlbumViewCell.h"

const int CHAR_NUM = 66;
const char chars[CHAR_NUM] = "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/|()1{}[]?-_+~<>i!;:,\"^`'.";
char getChar(CGFloat r, CGFloat g, CGFloat b, CGFloat a) {
    char c = ' ';
    if (a != 0) {
        int gray = 0.2126 * r + 0.7152 * g + 0.0722 * b;
        double unit = (256.0+1) / CHAR_NUM;
        int index = gray / unit;
        c = chars[index];
    }
    return c;
}

@interface ASCImageViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *transition;
@property (nonatomic, assign) BOOL converted;

@end

@implementation ASCImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds))];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self.view addSubview:_imageView];

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    gesture.numberOfTapsRequired = 2;
//    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
//    gesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gesture];

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    [self.view addGestureRecognizer:longPress];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

//    self.navigationController.delegate = self;

    ASCAlbumViewController * vc = [self.navigationController.viewControllers firstObject];
    ASCAlbumViewCell *cell =  (ASCAlbumViewCell *)[vc.collection cellForItemAtIndexPath:vc.collection.indexPathsForSelectedItems[0]];
    self.imageView.image = cell.imageView.image;
    _converted = NO;
}

- (void)tapGesture:(UITapGestureRecognizer *)gesture
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture
{
    if (_converted) {
        return;
    }
    _converted = YES;

    CGImageRef image = self.imageView.image.CGImage;

    // convert to ascii
    size_t height = CGImageGetHeight(image);
    size_t width = CGImageGetWidth(image);
    CFDataRef data = CGDataProviderCopyData(CGImageGetDataProvider(image));
    uint32_t *imageData = (uint32_t *)CFDataGetBytePtr(data);
    uint32_t pixel;

    NSMutableString *string = [[NSMutableString alloc] init];

    for (size_t i = 0; i < height; i += 1) {
        for (size_t j = 0; j < width; j += 1) {
            size_t index = i * width + j;
            pixel = *(imageData + index);

            CGFloat r, g, b, a;
            a = (pixel & 0xff000000) >> 24;
            b = (pixel & 0x00ff0000) >> 16;
            g = (pixel & 0x0000ff00) >> 8;
            r = (pixel & 0x000000ff);

            [string appendFormat:@"%c", getChar(r, g, b, a)];
            //            printf("%c", getChar(r, g, b, a));
        }
        //        printf("\n");
        [string appendFormat:@"%c", '\n'];
    }

    CFRelease(data);
    CGImageRelease(image);

    // get image
    NSDictionary *attrs = @{
                            NSFontAttributeName: [UIFont fontWithName:@"Courier New" size:1],
                            };
    CGSize sizeText = [string boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attrs
                                           context:nil].size;
    UIGraphicsBeginImageContext(sizeText);
    //    CGContextRef context = UIGraphicsGetCurrentContext();


    [string drawInRect:CGRectMake(0, 0,sizeText.width, sizeText.height) withAttributes:attrs];
    //    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    //    CGContextFillRect(context, CGRectMake(0, 0, width, height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();


    // scale image size
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, [UIScreen mainScreen].scale);
    [img drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    self.imageView.image = newImage;
}

//- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)gesture
//{
//    CGFloat progress = [gesture translationInView:self.view].x / self.view.bounds.size.width;
//    progress = MIN(1, progress);
//    progress = MAX(0, progress);
//
//    if (gesture.state == UIGestureRecognizerStateBegan) {
//        self.transition = [[UIPercentDrivenInteractiveTransition alloc] init];
//        [self.navigationController popViewControllerAnimated:YES];
//    } else if (gesture.state == UIGestureRecognizerStateChanged) {
//        [self.transition updateInteractiveTransition:progress];
//    } else if (gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateEnded) {
//        if (progress > 0.5) {
//            [self.transition finishInteractiveTransition];
//        } else {
//            [self.transition cancelInteractiveTransition];
//        }
//    }
//}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    id<UIViewControllerAnimatedTransitioning> transition = nil;
    if ([toVC isKindOfClass:[ASCAlbumViewController class]]) {
        transition = [[ASCAlbumTransition alloc] initWithInverse:YES];
    }
    return transition;
}

//- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
//{
////    return self.transition;
//    id<UIViewControllerAnimatedTransitioning> transition = nil;
//    if ([animationController isKindOfClass:[ASCAlbumTransition class]]) {
//        transition = self.transition;
//    }
//    return transition;
//}

@end
