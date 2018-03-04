//
//  Recording.m
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 04/03/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import "Recording.h"

@implementation Recording

-(instancetype)initWithTitle:(NSString*) title {
	self = [super init];
	if (self) {
		self.title = title;
		NSMutableString *uuid = [[[NSUUID UUID] UUIDString] mutableCopy];
		self.fileName = [uuid stringByAppendingString:@".m4a"];
	}
	return self;
}

@end
