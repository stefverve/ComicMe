//
//  DisplayViewController.m
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-28.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "DisplayViewController.h"
#import "CanvasViewController.h"

@interface DisplayViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *displayViewImageView;

@end

@implementation DisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.displayViewImageView.image = self.displayImage;
    
    if (self.hideEditButton) {
        self.navigationItem.rightBarButtonItems = nil;
        self.hideEditButton = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"edit"]) {
        CanvasViewController * cVC = segue.destinationViewController;
        cVC.hidePreviewButton = YES;
     //   dVC.displayImage = sender.storyImageView.image;
    }
}


@end
