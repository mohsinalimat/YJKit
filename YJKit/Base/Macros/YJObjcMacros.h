//
//  YJObjcMacros.h
//  YJKit
//
//  Created by huang-kun on 16/4/16.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef YJObjcMacros_h
#define YJObjcMacros_h

/* ------------------------------------------------------------------------------------------------------------ */

// @ keyword

#if __OPTIMIZE__
#ifndef _yj_keywordify
#define _yj_keywordify try {} @finally {}
#endif
#else
#ifndef _yj_keywordify
#define _yj_keywordify autoreleasepool {}
#endif
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// weakify & strongify

#ifndef _weak_cast
#define _weak_cast(x) x##_weak_
#endif

#ifndef weakify
#if __has_feature(objc_arc)
#define weakify(object) _yj_keywordify __weak __typeof__(object) _weak_cast(object) = object;
#endif
#endif

#ifndef strongify
#if __has_feature(objc_arc)
#define strongify(object) _yj_keywordify __strong __typeof__(_weak_cast(object)) object = _weak_cast(object);
#endif
#endif

/* ------------------------------------------------------------------------------------------------------------ */

#endif /* YJObjcMacros_h */
