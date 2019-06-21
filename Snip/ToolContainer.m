//
//  ToolContainer.m
//  Snip
//
//  Created by isee15 on 15/2/5.
//  Copyright (c) 2015年 isee15. All rights reserved.
//

#import "ToolContainer.h"
#import "SnipUtil.h"

@interface ToolContainer ()
@property NSButton *cancelButton;
@property NSButton *okButton;

@property(nonatomic, copy) NSArray<NSButton *> *tools;
@end

@implementation ToolContainer

- (instancetype)init
{
    if (self = [super init]) {
        _cancelButton = [SnipUtil createButton:[NSImage imageNamed:@"ScreenCapture_toolbar_cross_normal"] withAlternate:nil];
        _cancelButton.tag = ActionCancel;

        _okButton = [SnipUtil createButton:[NSImage imageNamed:@"ScreenCapture_toolbar_tick_normal"] withAlternate:nil];
        _okButton.tag = ActionOK;

        _tools = @[_cancelButton,_okButton];
        for (NSButton *btn in _tools) {
            btn.target = self;
            btn.action = @selector(onToolClick:);
            [self addSubview:btn];
        }
    }
    return self;
}


- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    NSBezierPath *bgPath = [NSBezierPath bezierPathWithRoundedRect:self.bounds xRadius:3 yRadius:3];
    [bgPath setClip];
    [[NSColor colorWithCalibratedWhite:1.0 alpha:0.3f] setFill];
    NSRectFill(self.bounds);
    // Drawing code here.
}

- (void)setFrame:(NSRect)frame
{
    [super setFrame:frame];
    int step = 35;
    int margin = 10;
    int index = 0;
    for (NSButton *btn in self.tools) {
        [btn setFrame:NSMakeRect(margin+step * (index++), 0, 28, 26)];
    }
}

- (void)onToolClick:(NSControl *)sender
{
    if (self.toolClick) {
        self.toolClick([sender tag]);
    }
}

- (void)mouseDown:(NSEvent *)theEvent
{
}

@end
