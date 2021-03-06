//
//  PageViewController.m
//  ComicMe
//
//  Created by Erin Luu on 2016-11-30.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "PageViewController.h"
#import "PageCollectionViewCell.h"
#import "StoryManager.h"

@interface PageViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) StoryManager * sm;
@property (nonatomic) UICollectionViewFlowLayout * flowLayout;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sm = [StoryManager sharedManager];
    self.flowLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    
    //Cell Spacing
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    
    CGSize newSize;
    newSize = CGSizeMake(self.collectionView.frame.size.width * 0.40, self.collectionView.frame.size.height);
    self.flowLayout.itemSize = newSize;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.delegate setPanBlock:nil];
    [self.delegate setPinchBlock:nil];
    [self.delegate setRotationBlock:nil];
    [self.delegate setTapBlock:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger numOfItem = self.sm.currentStory.images.count + 1;
    return numOfItem;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row < self.sm.currentStory.images.count) {
        cell.imageView.image = [self.sm getUIImageForStory:self.sm.currentStory page:indexPath.row];
        cell.pageLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    }else{
        cell.pageLabel.text = @"+";
    }
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.sm.currentStory.images.count) {
        [self.sm addNewImage];
        [self.collectionView reloadData];
    }else{
        [self.sm changeCurrentImage: indexPath.row];
        [self.delegate updateCurrentImage];
        [self.delegate clearCanvas];
        [self.delegate importLayers];
        
    }
}

-(void)viewDidLayoutSubviews {
    [self.flowLayout invalidateLayout];
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGSize newSize;
//    if (indexPath.row < self.sm.currentStory.images.count) {
//        newSize = CGSizeMake(self.collectionView.frame.size.width * 0.40, self.collectionView.frame.size.height);
//    }else {
//        newSize = CGSizeMake(self.collectionView.frame.size.width * 0.2, self.collectionView.frame.size.height);
//    }
//    return newSize;
//}

- (void) reloadCollection {
    [self.collectionView reloadData];
}

@end
