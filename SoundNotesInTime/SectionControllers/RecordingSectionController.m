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

@implementation RecordingSectionController {
	SectionTypeDescriptor *item;
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
	id cell = [self.collectionContext dequeueReusableCellOfClass:[RecordingCell class] forSectionController:self atIndex:index];
	return cell;
}

- (void)didUpdateToObject:(id)object {
	item = object;
}

@end
