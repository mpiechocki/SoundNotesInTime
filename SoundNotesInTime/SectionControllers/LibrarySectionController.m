//
//  LibrarySectionController.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 01/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "LibrarySectionController.h"

#import "SectionTypeDescriptor.h"
#import "TestCell.h"

@implementation LibrarySectionController {
	SectionTypeDescriptor *item;
}

- (NSInteger)numberOfItems {
	return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
	const CGFloat width = self.collectionContext.containerSize.width;
	CGFloat height = 100.0;
	return CGSizeMake(width, height);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
	id cell = [self.collectionContext dequeueReusableCellOfClass:[TestCell class] forSectionController:self atIndex:index];
	[(TestCell *) cell setText: @"MyLibrary"];
	((TestCell *) cell).backgroundColor = UIColor.greenColor;
	return cell;
}

- (void)didUpdateToObject:(id)object {
	item = object;
}

@end
