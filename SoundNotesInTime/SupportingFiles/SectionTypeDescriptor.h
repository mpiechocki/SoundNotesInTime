//
//  SectionTypeDescriptor.h
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 01/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#ifndef SectionTypeDescriptor_h
#define SectionTypeDescriptor_h

#import <IGListKit.h>

//typedef enum {
//	Playback,
//	Recording,
//	Library
//} SectionType;

typedef NS_ENUM(NSUInteger, SectionType) {
	Playback,
	Recording,
	Library
};

@interface SectionTypeDescriptor: NSObject <IGListDiffable>
@property SectionType type;
@property NSString *title;

- (instancetype)initWithType:(SectionType)type;
@end

#endif /* SectionTypeDescriptor_h */