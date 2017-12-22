//
//  TestSectionController.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 22/12/2017.
//  Copyright © 2017 dontgonearthecastle. All rights reserved.
//

#import "TestSectionController.h"

#import "TestCell.h"

@implementation TestSectionController {
	NSString *item;
}

- (NSInteger)numberOfItems {
	return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
	const CGFloat width = self.collectionContext.containerSize.width;
	CGFloat height = 80.0;
	return CGSizeMake(width, height);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
	id cell = [self.collectionContext dequeueReusableCellOfClass:[TestCell class] forSectionController:self atIndex:index];
	[(TestCell *) cell setText: item];
	return cell;
}

- (void)didUpdateToObject:(id)object {
	item = object;
}

@end
