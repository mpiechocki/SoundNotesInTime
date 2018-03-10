//
//  SectionTypeDescriptor.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 01/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "SectionTypeDescriptor.h"

#import <Foundation/Foundation.h>

@implementation SectionTypeDescriptor

- (instancetype)initWithType:(SectionType)type
{
	self = [super init];
	if (self) {
		self.type = type;
		switch (type) {
			case Meronome:
				self.title = @"Playback";
				self.filenames = nil;
				break;
			case Recording:
				self.title = @"Recording";
				self.filenames = nil;
				break;
			case Library:
				self.title = @"Library";
				self.filenames = nil;
				break;
		}
	}
	return self;
}

- (nonnull id<NSObject>)diffIdentifier {
	switch (self.type) {
		case Meronome: return @"Playback";
		case Recording: return @"Recording";
		case Library: return [self.filenames componentsJoinedByString:@","];
	}
	return @"";
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {
	switch (self.type) {
		case Meronome: return object.diffIdentifier == self.diffIdentifier;
		case Recording: return object.diffIdentifier == self.diffIdentifier;
		case Library: {
			if ((SectionTypeDescriptor *) object) {
				return ((SectionTypeDescriptor *) object).filenames == self.filenames;
			}
			return false;
		}
	}
}

@end
