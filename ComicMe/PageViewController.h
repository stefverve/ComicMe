//
//  PageViewController.h
//  ComicMe
//
//  Created by Erin Luu on 2016-11-30.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PagesViewDelegate <NSObject>

@end
@interface PageViewController : UIViewController
@property (weak, nonatomic) id<PagesViewDelegate> delegate;

- (void) reloadCollection;
@end
