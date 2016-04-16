//
//  YJExecutionMacros.h
//  YJKit
//
//  Created by huang-kun on 16/4/16.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef YJExecutionMacros_h
#define YJExecutionMacros_h

/* ------------------------------------------------------------------------------------------------------------ */

// execute_once()
// execute_once_begin()
// execute_once_end()

/**
 *  Execute function or method only once. Call execute_once() at first line inside of a non-returned function or method.
 *  execute_once() also can be used for executing code once after the execute_once() line, even if not use it at first line.
 *
 *  @code
 
 Usage:
 
 void greet() {
    execute_once();
    printf("hello. ")
 };
 
 for (int i = 0; i < 10; i++) {
    greet();
 }
 
 Another usage:
 
 void doSomething() {
    // some code
    // ...
    execute_once()
    // execute code below once.
    // ...
 }
 
 *  @endcode
 */
#ifndef execute_once
#define execute_once() \
    static bool yj_execute_once_flag = false; \
    if (yj_execute_once_flag) return; \
    yj_execute_once_flag = true;
#endif


/**
 *  Execute part of code inside of a function or method only once. Use execute_once_begin() and execute_once_end() as a pair.
 *
 *  @code
 
 Usage:
 
 void doSomething {
    // execute some code
    // ...
    execute_once_begin()
    // excute code once
    // ...
    execute_once_end()
    // execute other code
    // ...
 }
 
 *  @endcode
 */
#ifndef execute_once_begin
#define execute_once_begin() \
    static bool yj_execute_once_flag = false; \
    if (yj_execute_once_flag) goto YOU_MUST_CALL_ONCE_END; \
    yj_execute_once_flag = true;
#endif

#ifndef execute_once_end
    #define execute_once_end() \
    YOU_MUST_CALL_ONCE_END: {}
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// perform_once()
// perform_once_begin()
// perform_once_end()


// perform_once original approach: (by Sunnyxx, http://weibo.com/u/1364395395?is_all=1)
//
// 1. #import <objc/runtime.h>
// 2. Write the code inside of a method at very first line:
// - (void)method {
//     if (objc_getAssociatedObject(self, _cmd)) return;
//     else objc_setAssociatedObject(self, _cmd, NSStringFromSelector(_cmd), OBJC_ASSOCIATION_RETAIN);
//     ...
// }


// -- Difference bewteen execute_once() and perform_once() --
//
// * execute_once() can be used for both inside of function and method, and perform_once() can be used for only inside of method.
// * The code below execute_once() only can be executed once. If the receiver object (self) is released, and new receiver object (self) is created, the code below perform_once() can be performed again.


// Usage: Same as execute_once(), execute_once_begin(), execute_once_end()
// Remark: If you use perform_once() inside of a method, then the _cmd as associated key is taken. Better use another key for other associated objects.

/**
 *  Perform a method only once. Import <objc/runtime.h> and call perform_once() at first line inside of a non-returned method.
 *  perform_once() also can be used for executing code once after the perform_once() line, even if not use it at first line.
 */
#ifndef perform_once
#define perform_once() \
    if (objc_getAssociatedObject(self, _cmd)) return; \
    else objc_setAssociatedObject(self, _cmd, @(YES), OBJC_ASSOCIATION_RETAIN);
#endif

#ifndef perform_once_begin
#define perform_once_begin() \
    if (objc_getAssociatedObject(self, _cmd)) goto YOU_MUST_CALL_ONCE_END; \
    else objc_setAssociatedObject(self, _cmd, @(YES), OBJC_ASSOCIATION_RETAIN);
#endif

#ifndef perform_once_end
    #define perform_once_end() \
    YOU_MUST_CALL_ONCE_END: {}
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// standby_begin()
// standby_end()

/**
 *  Use standby to avoid multiple calling of the same function or method during it's processing. Call standby_begin() and standby_end() as a pair.
 *
 *  @code
 {
    [controller networkFetch];
    [controller networkFetch];
    ...
 }
 
 - (void)networkFetch {
    standby_begin()
    [networkManager request:post completion:^(id response) {
        standby_end()
        ...
    } failure:^(NSError *error) {
        standby_end()
        ...
    }];
 }
 *  @endcode
 */
#ifndef standby_begin
#define standby_begin() \
    static bool yj_standby_flag = false; \
    if (yj_standby_flag) return; \
    yj_standby_flag = true;
#endif

#ifndef standby_end
    #define standby_end() \
    yj_standby_flag = false;
#endif

/* ------------------------------------------------------------------------------------------------------------ */

#endif /* YJExecutionMacros_h */