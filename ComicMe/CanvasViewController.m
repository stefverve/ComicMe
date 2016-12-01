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
#import "PageViewController.h"

@interface CanvasViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *previewBarButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraRollButton;
@property (weak, nonatomic) StoryManager * sm;
@property (nonatomic) UITabBarController * tabBarController;


@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.hidePreviewButton) {
        self.navigationItem.rightBarButtonItems = @[self.navigationItem.rightBarButtonItem];
        self.hidePreviewButton = NO;
    }
    self.sm = [StoryManager sharedManager];
    
    self.imageViewRect = self.imageView.frame;

    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void) stickerPinch:(UIPinchGestureRecognizer*)sender {
    
    self.currentImage.frame = CGRectMake(self.currentImage.frame.origin.x, self.currentImage.frame.origin.y, 300*sender.scale, 300*sender.scale);
    
    [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
    self.currentImage.center = [sender locationInView:self.imageView];
    [UIView commitAnimations];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"preview"]) {
        DisplayViewController * dVC = segue.destinationViewController;
        dVC.hideEditButton = YES;
    } else if ([segue.identifier isEqualToString:@"tabBarSegue"]) {
        self.tabBarController = segue.destinationViewController;
        for (UIViewController* vc in self.tabBarController.viewControllers) {
            [vc setValue:self forKey:@"delegate"];
        }
    }
}

- (IBAction)panGestureWithBlock:(UIPanGestureRecognizer *)sender {
    if (self.panBlock) {
        self.panBlock(sender, self);
    }
}

- (IBAction)pinchGestureWithBlock:(UIPinchGestureRecognizer *)sender {
    if (self.pinchBlock) {
        self.pinchBlock(sender, self);
    }
}

- (IBAction)rotationGestureWithBlock:(UIRotationGestureRecognizer *)sender {
    if (self.rotationBlock) {
        self.rotationBlock(sender, self);
    }
}

- (IBAction)tapGestureWithBlock:(UITapGestureRecognizer *)sender {
    if (self.tapBlock) {
        self.tapBlock(sender, self);
    }
}

- (void) addStickerView:(UIImageView *)imageView {
    [self.sm updateCurrentLayer:self.currentImage];
    [self.imageView addSubview:imageView];
    [imageView setCenter:CGPointMake(self.imageView.frame.size.width/2, self.imageView.frame.size.width/2)];
    self.currentImage = imageView;
    
    // CORE DATA REQUEST TO ADD NEW LAYER  -- OR MAYBE NOT
}

- (void) saveSticker {
 
    // THEN, SAVE ALL STICKER DATA HERE    [self.sm createNewLayer:imageView];
    if (self.currentImage != nil) {
        [self.sm createNewLayer:self.currentImage];
    }
}

- (void) addCustomImage:(UIImageView *)imageView {
    [self.sm updateCurrentLayer:self.currentImage];
    [self.imageView addSubview:imageView];
    [imageView setCenter:CGPointMake(self.imageView.frame.size.width/2, self.imageView.frame.size.width/2)];
    self.currentImage = imageView;
    [self.sm createNewLayer:imageView];
}

- (void) addDrawView:(PaintView *)paintView {
    paintView.frame = self.imageView.bounds;
    [self.imageView addSubview:paintView];
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
    self.imageView.userInteractionEnabled = YES;
    [self.sm setUIImage:image];
    
    //Update Page Panel
    NSArray * controllers = self.tabBarController.viewControllers;
    PageViewController * pagesController = [controllers firstObject];
    [pagesController reloadCollection];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void) clearCanvas {
    for (UIImageView * subView in self.imageView.subviews) {
        [subView removeFromSuperview];
    }
}

-(void) importLayers {
    NSOrderedSet * layers = self.sm.currentImage.layers;
    for (Layer * layer in layers) {
        UIImage * layerImage = [self.sm getUIImageForLayer:layer];
        UIImageView * layerImageView = [[UIImageView alloc] initWithImage:layerImage];
        layerImageView.frame = [self.sm createCGRectForLayer:layer];
        layerImageView.transform = [self.sm getTransformForLayer:layer];
        [self.imageView addSubview:layerImageView];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Pages View Controller Delegate
-(void) updateCurrentImage {
    UIImage * image = [self.sm getCurrentUIImage:self.sm.currentImage];
    self.imageView.image = image;
    if (image == nil) {
        self.imageView.userInteractionEnabled = NO;
    } else {
        self.imageView.userInteractionEnabled = YES;
    }
}

@end
