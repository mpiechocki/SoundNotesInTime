//
//  PlaybackSectionController.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 01/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "PlaybackSectionController.h"

#import "SectionTypeDescriptor.h"
#import "PlaybackCell.h"


@implementation PlaybackSectionController {
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
	id cell = [self.collectionContext dequeueReusableCellOfClass:[PlaybackCell class] forSectionController:self atIndex:index];
	return cell;
}

- (void)didUpdateToObject:(id)object {
	item = object;
}

@end
