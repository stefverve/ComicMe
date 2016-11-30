//
//  TabViewProtocols.h
//  ComicMe
//
//  Created by Stefan Verveniotis on 2016-11-30.
//  Copyright © 2016 Midterm Team. All rights reserved.
//

#ifndef TabViewProtocols_h
#define TabViewProtocols_h

@class CanvasViewController;
@class DrawViewController;

typedef void(^pan_block_t)(UIPanGestureRecognizer * sender, CanvasViewController * cvc);

@protocol DrawViewDelegate <NSObject>

- (void) addDrawView:(PaintView *)paintView;
- (void) addCustomImage:(UIImageView *)imageView; 
- (void) setPanBlock:(pan_block_t)panBlock;

@end


#endif /* TabViewProtocols_h */
