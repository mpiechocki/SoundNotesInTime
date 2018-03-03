//
//  ColorPalette.h
//  SoundNotesInTime
//
//  Created by dontgonearthecastle on 03/03/2018.
//  Copyright © 2018 dontgonearthecastle. All rights reserved.
//

#ifndef ColorPalette_h
#define ColorPalette_h

#import <UIKit/UIKit.h>

//#define BUTTON_BACKGROUND_COLOR [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0]
//#define TAP_VIEW_BACKGROUND [UIColor colorWithRed:0.70 green:0.78 blue:0.85 alpha:1.0]

@interface ColorPalette: NSObject
+(UIColor *)buttonBackground;
+(UIColor *)tapViewBackground;
+(UIColor *)startMetronomeBackground;
@end

#endif /* ColorPalette_h */
