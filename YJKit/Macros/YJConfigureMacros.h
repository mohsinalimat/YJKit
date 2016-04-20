//
//  YJConfigureMacros.h
//  YJKit
//
//  Created by huang-kun on 16/4/20.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef YJConfigureMacros_h
#define YJConfigureMacros_h

#import "Availability.h"

// Not available for minimum deployment target as iOS 9 and above.
#ifndef YJ_UNAVALIBLE_FOR_IOS_9_ABOVE
    #if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
        #define YJ_UNAVALIBLE_FOR_IOS_9_ABOVE NS_UNAVAILABLE
    #else
        #define YJ_UNAVALIBLE_FOR_IOS_9_ABOVE ;
    #endif
#endif

#endif /* YJConfigureMacros_h */
