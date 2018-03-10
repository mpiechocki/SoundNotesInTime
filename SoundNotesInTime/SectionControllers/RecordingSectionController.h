//
//  RecordingSectionController.h
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 01/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import <IGListKit/IGListKit.h>

@protocol RecordingSectionControllerDelegate
@optional
-(void) recordStopped:(NSURL *_Nullable)newFileUrl;
@end

@interface RecordingSectionController : IGListSectionController
@property (weak, nullable) id<RecordingSectionControllerDelegate> delegate;
@end
