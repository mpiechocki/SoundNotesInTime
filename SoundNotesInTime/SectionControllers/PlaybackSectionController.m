//
//  PlaybackSectionController.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 01/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "PlaybackSectionController.h"

#import "SectionTypeDescriptor.h"
#import "TestCell.h"


@implementation PlaybackSectionController {
	SectionTypeDescriptor *item;
}

- (NSInteger)numberOfItems {
	return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
	const CGFloat width = self.collectionContext.containerSize.width;
	CGFloat height = 40.0;
	return CGSizeMake(width, height);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
	id cell = [self.collectionContext dequeueReusableCellOfClass:[TestCell class] forSectionController:self atIndex:index];
	[(TestCell *) cell setText: @"MyPlayback"];
	((TestCell *) cell).backgroundColor = UIColor.cyanColor;
	return cell;
}

- (void)didUpdateToObject:(id)object {
	item = object;
}

@end
