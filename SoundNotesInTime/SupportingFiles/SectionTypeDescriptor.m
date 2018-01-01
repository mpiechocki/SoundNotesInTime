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
			case Playback:
				self.title = @"Playback";
				break;
			case Recording:
				self.title = @"Recording";
				break;
			case Library:
				self.title = @"Library";
				break;
		}
	}
	return self;
}

- (nonnull id<NSObject>)diffIdentifier {
	switch (self.type) {
		case Playback: return @"Playback";
		case Recording: return @"Recording";
		case Library: return @"Library";
	}
	return @"";
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {
	return object.diffIdentifier == self.diffIdentifier;
}

@end
