//
//  RecordingSectionController.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 01/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "RecordingSectionController.h"

#import "SectionTypeDescriptor.h"
#import "RecordingCell.h"
#import "MyRecorder.h"

@interface RecordingSectionController () <RecordingCellDelegate>
@end

@implementation RecordingSectionController {
	SectionTypeDescriptor *item;
	
	MyRecorder *recorder;
}

-(instancetype)init {
	self = [super init];
	if (self) {
		[self setupRecorder];
	}
	return self;
}

-(void) setupRecorder {
	recorder = MyRecorder.shared;
}

- (NSInteger)numberOfItems {
	return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
	const CGFloat width = self.collectionContext.containerSize.width;
	CGFloat height = 50.0;
	return CGSizeMake(width, height);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
	RecordingCell * cell = (RecordingCell *) [self.collectionContext dequeueReusableCellOfClass:[RecordingCell class] forSectionController:self atIndex:index];
	if (cell) {
		cell.delegate = self;
	}
	return cell;
}

- (void)didUpdateToObject:(id)object {
	item = object;
}

#pragma mark - recording cell delegate
-(void)recordClicked:(BOOL)isSelected {
	isSelected ? [recorder record] : [recorder stop];
	if (!isSelected && recorder.lastFileUrl) {
		[_delegate recordStopped: recorder.lastFileUrl];
	}
}

@end
