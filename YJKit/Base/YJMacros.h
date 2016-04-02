//
//  YJMacros.h
//  YJKit
//
//  Created by huang-kun on 16/3/25.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef YJMacros_h
#define YJMacros_h

#pragma mark - weakify & strongify

#define _weak_cast(x) x##_weak_

#ifndef weakify
    #if __has_feature(objc_arc)
        #if __OPTIMIZE__
            #define weakify(object) try {} @finally {} __weak __typeof__(object) _weak_cast(object) = object;
        #else
            #define weakify(object) autoreleasepool {} __weak __typeof__(object) _weak_cast(object) = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if __has_feature(objc_arc)
        #if __OPTIMIZE__
            #define strongify(object) try {} @finally {} __strong __typeof__(_weak_cast(object)) object = _weak_cast(object);
        #else
            #define strongify(object) autoreleasepool {} __strong __typeof__(_weak_cast(object)) object = _weak_cast(object);
        #endif
    #endif
#endif

#pragma mark - Radians & Degrees

#ifndef RadiansInDegrees
    #define RadiansInDegrees(degrees) (degrees) * M_PI / 180
#endif

#ifndef DegreesInRadians
    #define DegreesInRadians(radians) (radians) * 180 / M_PI
#endif

#endif /* YJMacros_h */
