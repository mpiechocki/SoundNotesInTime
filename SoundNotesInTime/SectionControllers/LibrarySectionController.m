//
//  LibrarySectionController.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 01/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "LibrarySectionController.h"

#import "SectionTypeDescriptor.h"
#import "LibraryCell.h"

@implementation LibrarySectionController {
	SectionTypeDescriptor *item;
	NSArray<NSString *> *filenames;
}

-(instancetype) initWithFilenames:(NSArray<NSString *> *)files {
	self = [super init];
	if (self) {
		filenames = files;
	}
	return self;
}

- (NSInteger)numberOfItems {
	return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
	const CGFloat width = self.collectionContext.containerSize.width;
	CGFloat height = 300.0;
	return CGSizeMake(width, height);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
	id cell = [self.collectionContext dequeueReusableCellOfClass:[LibraryCell class] forSectionController:self atIndex:index];
	[cell setFilenames: filenames];
	return cell;
}

- (void)didUpdateToObject:(id)object {
	item = object;
}

@end
