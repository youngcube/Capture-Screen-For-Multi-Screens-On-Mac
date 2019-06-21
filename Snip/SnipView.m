//
//  SnipView.m
//  Snip
//
//  Created by rz on 15/1/31.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import "SnipView.h"
#import "SnipManager.h"

const int kDRAG_POINT_NUM = 8;
const int kDRAG_POINT_LEN = 5;

@interface SnipView ()

@end

@implementation SnipView


- (instancetype)initWithCoder:(NSCoder *)coder
{

    if (self = [super initWithCoder:coder]) {
        //_rectArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)setupTrackingArea:(NSRect)rect
{
    self.trackingArea = [[NSTrackingArea alloc] initWithRect:rect options:NSTrackingMouseMoved | NSTrackingActiveAlways owner:self userInfo:nil];
    NSLog(@"track init:%@", NSStringFromRect(self.frame));
    [self addTrackingArea:self.trackingArea];
}

- (void)setupTool
{
    self.toolContainer = [[ToolContainer alloc] init];
    [self addSubview:self.toolContainer];
    [self hideToolkit];
}


- (void)showToolkit
{
    NSLog(@"show toolkit:%@",self);
    NSRect imageRect = NSIntersectionRect(self.drawingRect, self.bounds);
    double y = imageRect.origin.y - 28;
    double x = imageRect.origin.x + imageRect.size.width;
    if (y < 0) y = 0;
    int margin = 10;
    int toolWidth = 35 * 7 + margin * 2 - (35-28);
    if (x < toolWidth) x = toolWidth;
    if (!NSEqualRects(self.toolContainer.frame,NSMakeRect(x - toolWidth, y, toolWidth, 26))) {
        [self.toolContainer setFrame:NSMakeRect(x - toolWidth, y, toolWidth, 26)];
    }
    if (self.toolContainer.isHidden) {
        [self.toolContainer setHidden:NO];
    }
}

- (void)hideToolkit
{
    [self.toolContainer setHidden:YES];
}

//- (void)mouseMoved:(NSEvent *)theEvent
//{
//    [super mouseMoved:theEvent];
//    NSLog(@"snipview track mouse moved:%@",self);
//    
//}
- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent
{
    return YES;
}

- (NSRect)pointRect:(int)index inRect:(NSRect)rect
{
    double x = 0, y = 0;
    switch (index) {
        case 0:
            x = NSMinX(rect);
            y = NSMaxY(rect);
            break;
        case 1:
            x = NSMidX(rect);
            y = NSMaxY(rect);
            break;
        case 2:
            x = NSMaxX(rect);
            y = NSMaxY(rect);
            break;
        case 3:
            x = NSMinX(rect);
            y = NSMidY(rect);
            break;
        case 4:
            x = NSMaxX(rect);
            y = NSMidY(rect);
            break;
        case 5:
            x = NSMinX(rect);
            y = NSMinY(rect);
            break;
        case 6:
            x = NSMidX(rect);
            y = NSMinY(rect);
            break;
        case 7:
            x = NSMaxX(rect);
            y = NSMinY(rect);
            break;

        default:
            break;
    }
    return NSMakeRect(x - kDRAG_POINT_LEN, y - kDRAG_POINT_LEN, kDRAG_POINT_LEN * 2, kDRAG_POINT_LEN * 2);
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSDisableScreenUpdates();
    [super drawRect:dirtyRect];
    /*if (self.window.screen)
    {
        [[NSColor whiteColor] set];
        for (NSDictionary *dir in [SnipManager sharedInstance].arrayRect) {
            CGRect windowRect;
            CGRectMakeWithDictionaryRepresentation((__bridge CFDictionaryRef) dir[(id) kCGWindowBounds], &windowRect);
            NSRect rect = [SnipUtil cgWindowRectToWindowRect:windowRect inScreen:self.window.screen];
            NSBezierPath *rectPath = [NSBezierPath bezierPath];
            [rectPath setLineWidth:0.5];
            [rectPath appendBezierPathWithRect:rect];
            [rectPath stroke];
        }
    }*/

    if (self.image) {
        NSRect imageRect = NSIntersectionRect(self.drawingRect, self.bounds);
        [self.image drawInRect:imageRect fromRect:imageRect operation:NSCompositeSourceOver fraction:1.0];
        [[NSColor orangeColor] set];
        NSBezierPath *rectPath = [NSBezierPath bezierPath];
        [rectPath setLineWidth:kBORDER_LINE_WIDTH];
        [rectPath removeAllPoints];
        [rectPath appendBezierPathWithRect:imageRect];
        [rectPath stroke];
        if ([SnipManager sharedInstance].captureState == CAPTURE_STATE_ADJUST) {
            [[NSColor whiteColor] set];
            for (int i = 0; i < kDRAG_POINT_NUM; i++) {
                NSBezierPath *adjustPath = [NSBezierPath bezierPath];
                [adjustPath removeAllPoints];
                [adjustPath appendBezierPathWithOvalInRect:[self pointRect:i inRect:imageRect]];
                [adjustPath fill];
            }
        }
//        else if ([SnipManager sharedInstance].captureState == CAPTURE_STATE_EDIT) {
//            [self drawCommentInRect:imageRect];
//            if (self.currentInfo) {
//                NSRect rect = NSMakeRect(self.currentInfo.startPoint.x, self.currentInfo.startPoint.y, self.currentInfo.endPoint.x-self.currentInfo.startPoint.x, self.currentInfo.endPoint.y-self.currentInfo.startPoint.y);
//                rect = [SnipUtil uniformRect:rect];
//                rect = [self.window convertRectFromScreen:rect];
//                NSBezierPath *rectPath = [NSBezierPath bezierPath];
//                [rectPath setLineWidth:1.5];
//                [rectPath appendBezierPathWithRect:rect];
//                [rectPath stroke];
//            }
//        }
    }
    if (self.toolContainer != nil && !self.toolContainer.isHidden) {
        [self showToolkit];
    }
    // Drawing code here.
    NSEnableScreenUpdates();
}

@end
