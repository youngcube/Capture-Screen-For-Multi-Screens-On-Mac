//
//  SnipWindow.h
//  Snip
//
//  Created by rz on 15/1/31.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@protocol MouseEventProtocol <NSObject>

- (void)mouseDown:(NSEvent *)theEvent;

- (void)mouseUp:(NSEvent *)theEvent;

- (void)mouseDragged:(NSEvent *)theEvent;

- (void)mouseMoved:(NSEvent *)theEvent;
@end

@interface SnipWindow : NSPanel

@property(weak) id <MouseEventProtocol> mouseDelegate;
@end
