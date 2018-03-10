//
//  Recorder.h
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 03/03/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Recorder_h
#define Recorder_h

@interface MyRecorder: NSObject
@property NSURL *lastFileUrl;

+(instancetype) shared;

-(void) record;
-(void) stop;
-(void) playUrl:(NSURL *)url;
@end

#endif /* Recorder_h */
