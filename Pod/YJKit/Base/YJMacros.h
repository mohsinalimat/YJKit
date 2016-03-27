//
//  YJMacros.h
//  YJKit
//
//  Created by Jack Huang on 16/3/25.
//  Copyright © 2016年 Jack Huang. All rights reserved.
//

#ifndef YJMacros_h
#define YJMacros_h

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

#endif /* YJMacros_h */
