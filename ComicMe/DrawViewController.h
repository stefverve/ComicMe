//
//  DrawViewController.h
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-29.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaintView.h"
#import "CanvasViewController.h"
#import "TabViewProtocols.h"

@interface DrawViewController : UIViewController

@property (weak, nonatomic) id<DrawViewDelegate, TabViewDelegate> delegate;

@end
