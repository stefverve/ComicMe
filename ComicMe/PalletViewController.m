//
//  PalletViewController.m
//  ComicMe
//
//  Created by Erin Luu on 2016-11-28.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "PalletViewController.h"
#import "StampCollectionViewCell.h"
#import "CanvasViewController.h"
#import "StoryManager.h"

@interface PalletViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (nonatomic) NSArray * stickerCollection;
@property (strong, nonatomic) UIImageView * currentSticker;

@end

@implementation PalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error = nil;
    NSString *folderPath = [[[NSBundle mainBundle] resourcePath]
                                stringByAppendingPathComponent:@"stickers"];
    
    self.stickerCollection = [[NSFileManager defaultManager]
                                    contentsOfDirectoryAtPath:folderPath error:&error];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void) viewWillAppear:(BOOL)animated {
    
    pan_block_t panBlock = ^(UIPanGestureRecognizer * sender, CanvasViewController * cvc) {
            CGPoint translation = [sender translationInView:cvc.currentImage];
            [cvc.currentImage setTransform:CGAffineTransformTranslate(cvc.currentImage.transform, translation.x, translation.y)];
            [sender setTranslation:CGPointZero inView:cvc.currentImage];
    };
    
    pinch_block_t pinchBlock = ^(UIPinchGestureRecognizer * sender, CanvasViewController * cvc) {
        [cvc.currentImage setTransform:CGAffineTransformScale(cvc.currentImage.transform, sender.scale, sender.scale)];
        [sender setScale:1.0];
    };
    
    rotation_block_t rotationBlock = ^(UIRotationGestureRecognizer * sender, CanvasViewController * cvc) {
        if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged) {
            [cvc.currentImage setTransform:CGAffineTransformRotate(cvc.currentImage.transform, sender.rotation)];
            [sender setRotation:0];
        }
    };
    
    tap_block_t tapBlock = ^(UITapGestureRecognizer * sender, CanvasViewController * cvc) {
        
    };
    
    [self.delegate setTapBlock:tapBlock];
    [self.delegate setPanBlock:panBlock];
    [self.delegate setPinchBlock:pinchBlock];  //  switch these to pass in nil to disable each gesture
    [self.delegate setRotationBlock:rotationBlock];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.delegate updateCurrentLayer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StampCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString * imageName = [NSString stringWithFormat:@"stickers/%@", self.stickerCollection[indexPath.row]];
    cell.imageView.image = [UIImage imageNamed:imageName];
    CGRect cellSize = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, self.collectionView.frame.size.width/4, self.collectionView.frame.size.width/4);
    cell.frame = cellSize;
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0; // This is the minimum inter item spacing, can be more
}


// new sticker selected
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StampCollectionViewCell *cell = (StampCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *newImage = [[UIImageView alloc] initWithImage:cell.imageView.image];
    [self.delegate addStickerView:newImage];
}



#pragma mark - Tab Bar Delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"You tapped: %@", item.title);
}


@end
