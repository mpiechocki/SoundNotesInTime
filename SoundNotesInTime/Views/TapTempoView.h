//
//  TapTempoView.h
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 03/02/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TapTempoViewDelegate <NSObject>
- (void)bpmDetected:(int)bpm;
@end

@interface TapTempoView : UIView
@property (nullable, weak) id<TapTempoViewDelegate> delegate;
@end
