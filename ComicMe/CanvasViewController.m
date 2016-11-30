//
//  CanvasViewController.m
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-28.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "CanvasViewController.h"
#import "DisplayViewController.h"
#import "DrawViewController.h"
#import "PaintView.h"

@interface CanvasViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *previewBarButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraRollButton;
@property (strong, nonatomic) UIImageView * currentImage;
@property (strong, nonatomic) PaintView * currentPaintView;

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
    UIPinchGestureRecognizer *pinchy = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(stickerPinch:)];
    [self.view addGestureRecognizer:pinchy];
    self.imageViewRect = self.imageView.frame;
}

- (void) stickerPinch:(UIPinchGestureRecognizer*)sender {
    
    self.currentImage.frame = CGRectMake(self.currentImage.frame.origin.x, self.currentImage.frame.origin.y, 300*sender.scale, 300*sender.scale);
    
    [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
    self.currentImage.center = [sender locationInView:self.imageView];
    [UIView commitAnimations];
    
    //CGRectMake(self.currentImage.center.x, self.currentImage.center.y, 300*sender.scale, 300*sender.scale);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"preview"]) {
        DisplayViewController * dVC = segue.destinationViewController;
        dVC.hideEditButton = YES;
//    } else if ([segue.identifier isEqualToString:@"palletView"]) {
//        PalletViewController *pVC = segue.destinationViewController;
//        pVC.delegate = self;
    }
}



-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *aTouch = [touches anyObject];

    CGPoint location = [aTouch locationInView:self.imageView];
    
    [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
    self.currentImage.center = location;
    [UIView commitAnimations];
}




- (void) addStickerView:(UIImage *)sticker {
    
    // CORE DATA REQUEST TO ADD NEW LAYER
    
    UIImageView *newImage = [[UIImageView alloc] initWithImage:sticker];
    
    [self.imageView addSubview:newImage];
    [newImage setCenter:CGPointMake(self.imageView.frame.size.width/2, self.imageView.frame.size.width/2)];
    self.currentImage = newImage;
}

- (void) addDrawView:(DrawViewController *)drawViewController {
//    PaintView *newPaintView = [PaintView new];
//    newPaintView.frame = self.imageView.frame;
//    [drawViewController attachDrawView:newPaintView];
//    [self.imageView addSubview:newPaintView];
//    newPaintView.backgroundColor = [UIColor blackColor];
//    self.currentPaintView = newPaintView;
}

#pragma mark - Photo and camera stuff
- (IBAction)selectPhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
- (IBAction)takePhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    self.imageView.image = image;
    self.cameraButton.hidden = YES;
    self.cameraRollButton.hidden = YES;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
