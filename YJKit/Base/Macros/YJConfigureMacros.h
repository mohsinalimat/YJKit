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
#import "AvailabilityMacros.h"

// Not available for minimum deployment target as iOS 9 and above.
#ifndef YJ_UNAVALIBLE_FOR_MIN_DEPLOYMENT_TARGET_ABOVE_IOS_9
    #if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_9_0
        #define YJ_UNAVALIBLE_FOR_MIN_DEPLOYMENT_TARGET_ABOVE_IOS_9 UNAVAILABLE_ATTRIBUTE
    #else
        #define YJ_UNAVALIBLE_FOR_MIN_DEPLOYMENT_TARGET_ABOVE_IOS_9 ;
    #endif
#endif

#ifndef YJ_COMPILE_UNAVAILABLE
#define YJ_COMPILE_UNAVAILABLE 0
#endif

#endif /* YJConfigureMacros_h */
