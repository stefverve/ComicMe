//
//  CanvasViewController.h
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-28.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "ViewController.h"
#import "PalletViewController.h"
#import "DrawViewController.h"
#import "PaintView.h"
#import "FingerPaintGesture.h"
#import "TabViewProtocols.h"
#import "PageViewController.h"
@class Story;

@interface CanvasViewController : ViewController <PalletViewDelegate, DrawViewDelegate, TabViewDelegate, PagesViewDelegate>

@property CGRect imageViewRect;
@property (nonatomic) BOOL hidePreviewButton;
@property (nonatomic) Story * currentStory;
@property (strong, nonatomic) UIImageView * currentImage;  // most recently added sticker
@property (nonatomic, copy) tap_block_t tapBlock;
@property (nonatomic, copy) pan_block_t panBlock;
@property (nonatomic, copy) pinch_block_t pinchBlock;
@property (nonatomic, copy) rotation_block_t rotationBlock;
@property (strong, nonatomic) PaintView * currentPaintView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) BOOL *shouldLoadEditPage;

- (void) addStickerView:(UIImageView *)imageView;
- (void) addDrawView:(PaintView *)paintView;
- (void) addCustomImage:(UIImageView *)imageView;
- (void) updateCurrentImage;
- (void) clearCanvas;
- (void) importLayers;
- (void) updateCurrentLayer;

@end
