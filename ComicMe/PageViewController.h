//
//  PageViewController.h
//  ComicMe
//
//  Created by Erin Luu on 2016-11-30.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabViewProtocols.h"


@interface PageViewController : UIViewController

@property (weak, nonatomic) id<PagesViewDelegate, TabViewDelegate> delegate;

- (void) reloadCollection;

@end
