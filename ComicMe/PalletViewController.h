//
//  PalletViewController.h
//  ComicMe
//
//  Created by Erin Luu on 2016-11-28.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PalletViewController;

@protocol PalletViewDelegate <NSObject>

- (void) addStickerView:(UIImage *)sticker;

@end

@interface PalletViewController : UIViewController

@property (weak, nonatomic) id<PalletViewDelegate> delegate;

@end
