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
#import "TabViewProtocols.h"
@class Story;

@interface CanvasViewController : ViewController <PalletViewDelegate, DrawViewDelegate>


@property CGRect imageViewRect;
@property (nonatomic) BOOL hidePreviewButton;
@property (nonatomic) Story * currentStory;
@property (nonatomic, copy) pan_block_t panBlock;


- (void) addStickerView:(UIImageView *)imageView;
- (void) addDrawView:(PaintView *)paintView;

@end
