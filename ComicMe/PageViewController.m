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
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVIew;
@property (nonatomic) StoryManager * sm;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sm = [StoryManager sharedManager];
    NSNotificationCenter * noticeCenter = [NSNotificationCenter defaultCenter];
    [noticeCenter addObserver:self selector:@selector(reloadCollection) name:@"changesToPageImage" object:nil];
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
    NSOrderedSet * pages = self.sm.currentStory.images;
    return pages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = [self.sm getUIImageForStory:self.sm.currentStory page:indexPath.row];
    return cell;
}

- (void) reloadCollection {
    [self.collectionVIew reloadData];
}

@end
