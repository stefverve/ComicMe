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
    
 //   __weak ViewController *welf = self;
    
    
    
    self.tempPictureArray = @[[UIImage imageNamed:@"creeper.jpg"],
                                  [UIImage imageNamed:@"chairs.jpg"],
                                  [UIImage imageNamed:@"femaleface.jpg"],
                                  [UIImage imageNamed:@"jellyfish.jpg"],
                                  [UIImage imageNamed:@"maleface.jpg"],
                                  [UIImage imageNamed:@"metric1.jpg"],
                                  [UIImage imageNamed:@"metric2.jpg"],
                                  [UIImage imageNamed:@"metric3.jpg"],
                                  [UIImage imageNamed:@"portrait.jpg"],
                                  [UIImage imageNamed:@"tree.jpg"]];
    
    self.storyCollectionView.dataSource = self;
    self.storyCollectionView.delegate = self;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tempPictureArray.count;
}

- (StoryCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StoryCollectionViewCell * cell = [self.storyCollectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    cell.storyImageView.image = self.tempPictureArray[indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(StoryCollectionViewCell *)sender {
    if ([segue.identifier isEqualToString:@"detailView"]) {
        DisplayViewController * dVC = segue.destinationViewController;
        dVC.displayImage = sender.storyImageView.image;
    }
    if ([segue.identifier isEqualToString:@"addStory"]) {
        CanvasViewController * cvc = segue.destinationViewController;
        //cvc.currentStory = [self.sm createNewStory];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
