//
//  PlaybackSectionController.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 01/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "MetronomeSectionController.h"

#import <AVFoundation/AVFoundation.h>

#import "SectionTypeDescriptor.h"
#import "MetronomeCell.h"

@interface MetronomeSectionController () <MetronomeCellDelegate>
@end

@implementation MetronomeSectionController {
	SectionTypeDescriptor *item;
	
	Metronome *metronome;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self setupMetronome];
	}
	return self;
}

- (void)setupMetronome
{
	metronome = [[Metronome alloc] init];
	metronome.delegate = self;
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleMediaServicesWereReset:)
												 name:AVAudioSessionMediaServicesWereResetNotification
											   object:nil];
}

#pragma mark - Notifications
- (void)handleMediaServicesWereReset:(NSNotification *)notification
{
	// tear down
	metronome.delegate = nil;
	metronome = nil;
	
	// re-create
	metronome = [[Metronome alloc] init];
	metronome.delegate = self;
}

#pragma mark - IGListSectionController
- (NSInteger)numberOfItems
{
	return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
	const CGFloat width = self.collectionContext.containerSize.width;
	CGFloat height = 50.0;
	return CGSizeMake(width, height);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
	id cell = [self.collectionContext dequeueReusableCellOfClass:[MetronomeCell class] forSectionController:self atIndex:index];
	if ([cell isKindOfClass: [MetronomeCell class]]) {
		((MetronomeCell *) cell).delegate = self;
	}
	return cell;
}

- (void)didUpdateToObject:(id)object
{
	item = object;
}

#pragma mark - MetronomeCellDelegate
- (void)startButton:(BOOL)isSelected
{
	isSelected ? [metronome start] : [metronome stop];
}

- (void)bpmSet:(int)bpm
{
	[metronome setTempo:bpm];
}

@end
