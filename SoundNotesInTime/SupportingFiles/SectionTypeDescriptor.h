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

typedef NS_ENUM(NSUInteger, SectionType) {
	Meronome,
	Recording,
	Library
};

@interface SectionTypeDescriptor: NSObject <IGListDiffable>
@property SectionType type;
@property NSString *title;
@property NSArray<NSString *> *filenames;

- (instancetype)initWithType:(SectionType)type;
@end

#endif /* SectionTypeDescriptor_h */
