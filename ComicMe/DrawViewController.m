//
//  DrawViewController.m
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-29.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "DrawViewController.h"
#import "FingerPaintGesture.h"


@interface DrawViewController ()

@property (weak, nonatomic) IBOutlet PaintView *paintView;
@property (weak, nonatomic) IBOutlet UIView *paintColourView;
@property (weak, nonatomic) IBOutlet UIButton *undoButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *paintColourViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *paintColourViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *paintColourViewTrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *paintColourViewTop;

@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;
@property (weak, nonatomic) IBOutlet UISlider *alphaSlider;
@property (weak, nonatomic) IBOutlet UISlider *brushWidthSlider;

@property UIColor *currentColour;
@property NSInteger currentBrushSize;

@property CanvasViewController * cvc;

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    self.currentColour = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    self.currentBrushSize = 25;
    self.paintView.undo = NO;
    self.paintColourView.backgroundColor = self.currentColour;
    self.paintColourView.layer.cornerRadius = self.currentBrushSize/2;
    self.paintColourViewWidth.constant = self.currentBrushSize;
    self.paintColourViewHeight.constant = self.currentBrushSize;
    self.paintColourViewTop.constant = 57.5 - self.currentBrushSize/2;
    self.paintColourViewTrailing.constant = 47.5 - self.currentBrushSize/2;
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    PaintView *newPaintView = [PaintView new];
    
    self.paintView = newPaintView;
    
    self.paintView.backgroundColor = [UIColor clearColor];
    
    self.paintView.userInteractionEnabled = NO;
    
    [self.delegate addDrawView:self.paintView];
    
    
    
    pan_block_t panBlock = ^(UIPanGestureRecognizer * sender, CanvasViewController * cvc) {
        if (sender.state == UIGestureRecognizerStateBegan) {
            if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
                UIGraphicsBeginImageContextWithOptions(self.paintView.frame.size, NO, [UIScreen mainScreen].scale);
            } else {
                UIGraphicsBeginImageContext(self.paintView.frame.size);
            }
            [self.paintView.layer renderInContext:UIGraphicsGetCurrentContext()];
            self.paintView.currentImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            FingerPaintGesture *fpg = [FingerPaintGesture new];
            [self.paintView.gestureCollection addObject:fpg];
            self.paintView.gestureCollection[self.paintView.gestureCollection.count-1].brushColour = self.currentColour;
            self.paintView.gestureCollection[self.paintView.gestureCollection.count-1].brushSize = self.currentBrushSize;
        }
        [self.paintView.gestureCollection[self.paintView.gestureCollection.count-1].gestureArray addObject:[NSValue valueWithCGPoint:[sender locationInView:self.paintView]]];
        [self.paintView setNeedsDisplay];
    };
    [self.delegate setPanBlock:panBlock];
    [self.delegate setPinchBlock:nil];
    [self.delegate setRotationBlock:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(self.paintView.frame.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(self.paintView.frame.size);
    }
    [self.paintView.layer renderInContext:UIGraphicsGetCurrentContext()];
    self.paintView.currentImage = UIGraphicsGetImageFromCurrentImageContext();
    [self.delegate addCustomImage:[[UIImageView alloc] initWithImage:self.paintView.currentImage]];
    [self.paintView removeFromSuperview];

    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)drawColourSliderChange:(UISlider *)sender {
    self.currentColour = [UIColor colorWithRed:self.redSlider.value/255 green:self.greenSlider.value/255 blue:self.blueSlider.value/255 alpha:self.alphaSlider.value/255];
    self.paintColourView.backgroundColor = self.currentColour;
}

- (IBAction)brushWidthChanged:(UISlider *)sender {
    self.currentBrushSize = sender.value;
    self.paintColourView.layer.cornerRadius = sender.value/2;
    self.paintColourViewWidth.constant = sender.value;
    self.paintColourViewHeight.constant = sender.value;
    self.paintColourViewTop.constant = 57.5 - sender.value/2;
    self.paintColourViewTrailing.constant = 47.5 - sender.value/2;
}

//- (IBAction)drawInPaintView:(UIPanGestureRecognizer *)sender {
//    if (sender.state == UIGestureRecognizerStateBegan) {
//        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
//            UIGraphicsBeginImageContextWithOptions(self.paintView.frame.size, NO, [UIScreen mainScreen].scale);
//        } else {
//            UIGraphicsBeginImageContext(self.paintView.frame.size);
//        }
//        [self.paintView.layer renderInContext:UIGraphicsGetCurrentContext()];
//        self.paintView.currentImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        [self.paintView.gestureCollection addObject:[FingerPaintGesture new]];
//        self.paintView.gestureCollection[self.paintView.gestureCollection.count-1].brushColour = self.currentColour;
//        self.paintView.gestureCollection[self.paintView.gestureCollection.count-1].brushSize = self.currentBrushSize;
//    }
//    [self.paintView.gestureCollection[self.paintView.gestureCollection.count-1].gestureArray addObject:[NSValue valueWithCGPoint:[sender locationInView:self.paintView]]];
//    [self.paintView setNeedsDisplay];
//}

- (IBAction)undoButtonPressed:(UIButton *)sender {
    self.paintView.undo = YES;
    if (self.paintView.gestureCollection.count > 0) {
        [self.paintView.gestureCollection removeObjectAtIndex:self.paintView.gestureCollection.count - 1];
    }
    [self.paintView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
