//
//  CanvasViewController.h
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-28.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#import "ViewController.h"

@class  Story;

@interface CanvasViewController : ViewController

@property (nonatomic) BOOL hidePreviewButton;
@property (nonatomic) Story * currentStory;

@end
