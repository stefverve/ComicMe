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
@class PaintView;

typedef void(^pan_block_t)(UIPanGestureRecognizer * sender, CanvasViewController * cvc);
typedef void(^pinch_block_t)(UIPinchGestureRecognizer * sender, CanvasViewController * cvc);
typedef void(^rotation_block_t)(UIRotationGestureRecognizer * sender, CanvasViewController * cvc);


@protocol DrawViewDelegate <NSObject>

- (void) addDrawView:(PaintView *)paintView;
- (void) addCustomImage:(UIImageView *)imageView;

@end

@protocol PalletViewDelegate <NSObject>

- (void) addStickerView:(UIImageView *)imageView;
- (void) saveSticker;

@end

@protocol PagesViewDelegate <NSObject>

- (void) updateCurrentImage;

@end

@protocol TabViewDelegate <NSObject>

- (void) setPanBlock:(pan_block_t)panBlock;
- (void) setPinchBlock:(pinch_block_t)pinchBlock;
- (void) setRotationBlock:(rotation_block_t)rotationBlock;

@end


#endif /* TabViewProtocols_h */
