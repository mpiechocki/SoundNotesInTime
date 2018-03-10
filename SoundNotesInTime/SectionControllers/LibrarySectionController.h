//
//  LibrarySectionController.h
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 01/01/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#import <IGListKit/IGListKit.h>

@interface LibrarySectionController : IGListSectionController
-(instancetype) initWithFilenames:(NSArray<NSString *> *)files;
@end
