//
//  TapTempoView.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 03/02/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "TapTempoView.h"

#import <Masonry.h>

#import "ColorPalette.h"

@implementation TapTempoView {
	UILabel *label;
	NSTimeInterval lastTapTime;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self setup];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setup];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setup];
	}
	return self;
}

- (void)setup
{
	lastTapTime = 0.0;
	
	self.layer.backgroundColor = [ColorPalette tapViewBackground].CGColor;
	
	label = UILabel.new;
	[label setTextAlignment:NSTextAlignmentCenter];
	[label setText:@"tap"];
	[label setTextColor:UIColor.lightGrayColor];
	[self addSubview:label];
	UIEdgeInsets padding = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
	[label mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(label.superview).with.insets(padding);
	}];
	
	UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
	[self addGestureRecognizer:recognizer];
}

- (void)tapped
{
	NSTimeInterval tapTime = [[NSDate date] timeIntervalSince1970];
	
	if (lastTapTime != 0.0) {
		NSTimeInterval diff = tapTime - lastTapTime;
		int bpm = 60.0 / diff;
		NSLog(@"Diff is: %i", bpm);
		[self.delegate bpmDetected:bpm];
	}
	
	lastTapTime = tapTime;
	
	// @TODO: reset when too long inactive (with NSTimer, I guess).
}

- (void)reset
{
	lastTapTime = 0.0;
}

@end
