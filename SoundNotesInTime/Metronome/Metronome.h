//
//  Metronome.h
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 11/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MetronomeDelegate;

@interface Metronome : NSObject
@property (weak, nullable) id<MetronomeDelegate> delegate;

- (BOOL) start;
- (void) stop;
- (void) setTempo: (Float32)tempo;
@end

@protocol MetronomeDelegate <NSObject>
@optional
- (void) tick;
@end
