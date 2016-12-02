//
//  ViewController.m
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-28.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "ViewController.h"
#import "StoryCollectionViewCell.h"
#import "DisplayViewController.h"
#import "CanvasViewController.h"


@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *storyCollectionView;
@property (weak, nonatomic) IBOutlet StoryManager * sm;


@property (nonatomic) NSArray <UIImage *> * tempPictureArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sm = [StoryManager sharedManager];
    [self.sm getStoryCollection];
    self.storyCollectionView.dataSource = self;
    self.storyCollectionView.delegate = self;
    
    UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout*)self.storyCollectionView.collectionViewLayout;
    
    //Cell Spacing
    flowLayout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width/2 - 5, self.view.bounds.size.width/2 - 5);
}

- (void)viewWillAppear:(BOOL)animated {
    [self.sm getStoryCollection];
    [self.storyCollectionView reloadData];
}

#pragma mark - Collection View Data Source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sm.storyCollection.count;
}

- (StoryCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StoryCollectionViewCell * cell = [self.storyCollectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    Story * story = self.sm.storyCollection[indexPath.row];
    UIImage * currentImage = [self.sm getUIImageForStory:story page:0];
    cell.storyImageView.image = currentImage;
    return cell;
}

#pragma mark - Collection View Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Story * story = self.sm.storyCollection[indexPath.row];
    self.sm.currentStory = story;
}


#pragma mark - General Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(StoryCollectionViewCell *)sender {
    if ([segue.identifier isEqualToString:@"addStory"]) {
        [self.sm createNewStory];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
