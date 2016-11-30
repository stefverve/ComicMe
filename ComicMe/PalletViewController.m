//
//  PalletViewController.m
//  ComicMe
//
//  Created by Erin Luu on 2016-11-28.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "PalletViewController.h"
#import "StampCollectionViewCell.h"

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

//- (IBAction)newStickerTapped:(UITapGestureRecognizer *)sender {
//    
//    NSIndexPath * indexPath = [self.collectionView indexPathForItemAtPoint:[sender locationInView:self.collectionView]];
//    StampCollectionViewCell *cell = (StampCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
//    [self.delegate addStickerView:cell.imageView.image];
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    StampCollectionViewCell *cell = (StampCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        [self.delegate addStickerView:cell.imageView.image];
}


#pragma mark - Tab Bar Delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"You tapped: %@", item.title);
}


@end
