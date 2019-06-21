//
//  SnipView.h
//  Snip
//
//  Created by rz on 15/1/31.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ToolContainer.h"

@interface SnipView : NSView
@property NSImage *image;
@property NSRect drawingRect;

@property(nonatomic, strong) NSTrackingArea *trackingArea;
@property ToolContainer *toolContainer;

- (void)setupTrackingArea:(NSRect)rect;

- (void)setupTool;

- (void)showToolkit;

- (void)hideToolkit;


@end
