//
//  Recording.h
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 04/03/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#ifndef Recording_h
#define Recording_h

#import <Foundation/Foundation.h>

@interface Recording: NSObject
@property NSString *fileName;
@property NSString *title;

-(instancetype)initWithTitle:(NSString*) title;

@end

#endif /* Recording_h */
