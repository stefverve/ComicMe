//
//  CanvasViewController.h
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-28.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "ViewController.h"
#import "PalletViewController.h"

@interface CanvasViewController : ViewController <PalletViewDelegate>

@property (nonatomic) BOOL hidePreviewButton;

- (void) addStickerView:(UIImage *)sticker;

@end
