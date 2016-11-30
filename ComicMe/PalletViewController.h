//
//  PalletViewController.h
//  ComicMe
//
//  Created by Erin Luu on 2016-11-28.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabViewProtocols.h"
@class PalletViewController;



@interface PalletViewController : UIViewController

@property (weak, nonatomic) id<PalletViewDelegate, TabViewDelegate> delegate;

@end
