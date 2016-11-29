//
//  CanvasViewController.m
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-28.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "CanvasViewController.h"
#import "DisplayViewController.h"

@interface CanvasViewController () 

@property (weak, nonatomic) IBOutlet UIBarButtonItem *previewBarButton;
@property (weak, nonatomic) StoryManager * sm;
@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.hidePreviewButton) {
        self.navigationItem.rightBarButtonItems = @[self.navigationItem.rightBarButtonItem];
        self.hidePreviewButton = NO;
    }
    self.sm = [StoryManager sharedManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"preview"]) {
        DisplayViewController * dVC = segue.destinationViewController;
        dVC.hideEditButton = YES;
    }
}

- (IBAction)drawbutton:(UIButton *)sender {
   Layer * currentLayer = [self.sm createNewLayer];
}

@end
