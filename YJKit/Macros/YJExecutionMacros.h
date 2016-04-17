//
//  YJExecutionMacros.h
//  YJKit
//
//  Created by huang-kun on 16/4/16.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef YJExecutionMacros_h
#define YJExecutionMacros_h

#import <pthread/pthread.h>

static pthread_mutex_t yj_exe_mutex_0 = PTHREAD_MUTEX_INITIALIZER;
static pthread_mutex_t yj_exe_mutex_1 = PTHREAD_MUTEX_INITIALIZER;
static pthread_mutex_t yj_exe_mutex_2 = PTHREAD_MUTEX_INITIALIZER;

/* ------------------------------------------------------------------------------------------------------------ */

// execute_once()

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
    execute_once_pthread_lockify(&yj_exe_mutex_0)
#endif

#ifndef execute_once_pthread_lockify
#define execute_once_pthread_lockify(lockPtr) \
    pthread_mutex_lock(lockPtr); \
    static bool exe_flag_ = false; \
    if (exe_flag_) { \
        pthread_mutex_unlock(lockPtr); \
        return; \
    } \
    exe_flag_ = true; \
    pthread_mutex_unlock(lockPtr);
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// execute_once_begin()
// execute_once_end()

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
 *
 *
 *  @note Working with block: Define any block before calling execute_once_begin()
 *
 *  @code
 
 void test() {
 
     // some code ...
     
     void(^block)(void) = ^{ printf("hello block\n"); };
     dispatch_queue_t queue = dispatch_queue_create("new queue", 0);
     
     execute_once_begin()
     
     block();
     dispatch_async(queue, ^{ printf("hello queue\n"); });
 
     execute_once_end()
     
     // some other code ...
 }
 
 *  @endcode
 */
#ifndef execute_once_begin
#define execute_once_begin() \
    execute_once_begin_pthread_lockify(&yj_exe_mutex_1)
#endif

#ifndef execute_once_end
#define execute_once_end() \
    YOU_MUST_CALL_ONCE_END: {}
#endif

#ifndef execute_once_begin_pthread_lockify
#define execute_once_begin_pthread_lockify(lockPtr) \
    pthread_mutex_lock(lockPtr); \
    static bool exe_flag_ = false; \
    if (exe_flag_) { \
        pthread_mutex_unlock(lockPtr); \
        goto YOU_MUST_CALL_ONCE_END; \
    } \
    exe_flag_ = true; \
    pthread_mutex_unlock(lockPtr);
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// execute_once_on()
// execute_once_off()

/**
 *  Use execute_once_on/off to avoid multiple calling of the same function or method during it's processing. Call execute_once_on() and execute_once_off() as a pair.
 *
 *  @code
 
 Usage for function:
 
 {
     test();
     test();
 }
 
 void test() {
 
     // some code ...
     
     execute_once_on()
     printf("hello\n");
     
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        execute_once_off()
     });
     
     // some other code ...
 }
 
 
 Usage for method:
 
 {
     [controller networkFetch];
     [controller networkFetch];
 }
 
 - (void)networkFetch {
     execute_once_on()
     [networkManager request:post completion:^(id response) {
        execute_once_off()
        ...
     } failure:^(NSError *error) {
        execute_once_off()
        ...
     }];
 }
 *  @endcode
 */
#ifndef execute_once_on
#define execute_once_on() \
    execute_once_on_pthread_lockify(&yj_exe_mutex_2)
#endif

#ifndef execute_once_off
#define execute_once_off() \
    execute_once_off_pthread_lockify(&yj_exe_mutex_2)
#endif

#ifndef execute_once_on_pthread_lockify
#define execute_once_on_pthread_lockify(lockPtr) \
    pthread_mutex_lock(lockPtr); \
    static bool exe_flag1_ = false; \
    if (exe_flag1_) { \
        pthread_mutex_unlock(lockPtr); \
        return; \
    } \
    exe_flag1_ = true; \
    pthread_mutex_unlock(lockPtr);
#endif

#ifndef execute_once_off_pthread_lockify
#define execute_once_off_pthread_lockify(lockPtr) \
    pthread_mutex_lock(lockPtr); \
    exe_flag1_ = false; \
    pthread_mutex_unlock(lockPtr);
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// perform_once()

/// perform_once original approach: ( by Sunnyxx, http://weibo.com/u/1364395395 )
///
/// 1. #import <objc/runtime.h>
/// 2. Write the code inside of a method at very first line:
/// - (void)method {
///     if (objc_getAssociatedObject(self, _cmd)) return;
///     else objc_setAssociatedObject(self, _cmd, NSStringFromSelector(_cmd), OBJC_ASSOCIATION_RETAIN);
///     ...
/// }


/// -- Difference bewteen execute_once() and perform_once() --
///
/// * execute_once() can be used for both inside of function and method, and perform_once() can be used for only inside of method.
/// * The code below execute_once() only can be executed once. If the receiver object (self) is released, and new receiver object (self) is created, the code below perform_once() can be performed again.


/// Usage: Similar as execute_once(), execute_once_begin(), execute_once_end()
/// Remark: If you use perform_once() inside of a method, then the _cmd as associated key is taken. Better use another key for other associated objects.

/**
 *  Perform a method only once. Import <objc/runtime.h> and call perform_once() at first line inside of a non-returned method.
 *  perform_once() also can be used for executing code once after the perform_once() line, even if not use it at first line.
 */
#ifndef perform_once
#define perform_once() \
    if (objc_getAssociatedObject(self, _cmd)) return; \
    else objc_setAssociatedObject(self, _cmd, @(YES), OBJC_ASSOCIATION_RETAIN);
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// perform_once_begin()
// perform_once_end()

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

#endif /* YJExecutionMacros_h */
