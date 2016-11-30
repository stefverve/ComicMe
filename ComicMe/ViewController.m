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
    UIImage * currentImage = [self.sm getUIImage:indexPath.row];
    cell.storyImageView.image = currentImage;
    return cell;
}

#pragma mark - General Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(StoryCollectionViewCell *)sender {
    if ([segue.identifier isEqualToString:@"detailView"]) {
        DisplayViewController * dVC = segue.destinationViewController;
        dVC.displayImage = sender.storyImageView.image;
    }
    if ([segue.identifier isEqualToString:@"addStory"]) {
        [self.sm createNewStory];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
