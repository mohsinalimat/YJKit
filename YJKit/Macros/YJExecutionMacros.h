//
//  YJExecutionMacros.h
//  YJKit
//
//  Created by huang-kun on 16/4/16.
//  Copyright © 2016年 huang-kun. All rights reserved.
//

#ifndef YJExecutionMacros_h
#define YJExecutionMacros_h

#import <pthread/pthread.h> /* No need to manually import pthread library to the file where you want to use execute_init(). */
#import <objc/runtime.h> /* No need to manually import runtime library to the file where you want to use perform_once()... */

/* ------------------------------------------------------------------------------------------------------------ */

// execute_init()

#ifndef execute_init
#define execute_init(x) \
    _execute_mutex_init(x)
#endif

#ifndef _execute_mutex_init
#define _execute_mutex_init(m) pthread_mutex_t m = PTHREAD_MUTEX_INITIALIZER;
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// execute_once()

/**
 *  Execute function or method only once. Call execute_once() at first line inside of a non-returned function or method.
 *  execute_once() also can be used for executing code once after the execute_once() line, even if not use it at first line.
 *
 *  @code
 
 Example:
 
 static execute_init(x)
 
 void greet() {
    execute_once(x);
    printf("hello\n")
 };
 
 for (int i = 0; i < 5; i++) {
    greet();
 }
 
 
 Another Example:
 
 static execute_init(y)
 
 void doSomething() {
    printf("hello\n");
    execute_once(y)
    printf("world\n");
 }
 
 *  @endcode
 */
#ifndef execute_once
#define execute_once(x) \
    _execute_once_pthread_mutex_lockify(&(x))
#endif

#ifndef _execute_once_pthread_mutex_lockify
#define _execute_once_pthread_mutex_lockify(lockPtr) \
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
 
 Example:
 
 static execute_init(exe)
 
 void doSomething {
     printf("-----\n");
     execute_once_begin(exe)
     printf("hello\n");
     execute_once_end(exe)
     printf("-----\n");
 }
 
 for (int i = 0; i < 5; i++) {
    doSomething();
 }
 
 *  @endcode
 *
 *
 *  @note Working with block: Define any block before calling execute_once_begin()
 *
 *  @code
 
 void test() {
     printf("-----\n");
     
     void(^block)(void) = ^{ printf("hello block\n"); };
     dispatch_queue_t queue = dispatch_queue_create("new queue", 0);
     
     execute_once_begin(exe)
     
     block();
     dispatch_async(queue, ^{ printf("hello queue\n"); });
 
     execute_once_end(exe)
     
     printf("-----\n");
 }
 
 *  @endcode
 */
#ifndef execute_once_begin
#define execute_once_begin(x) \
    _execute_once_begin_pthread_mutex_lockify(&(x))
#endif

#ifndef execute_once_end
#define execute_once_end(x) \
    YOU_ALSO_MUST_CALL_EXECUTE_ONCE_END: {}
#endif

#ifndef _execute_once_begin_pthread_mutex_lockify
#define _execute_once_begin_pthread_mutex_lockify(lockPtr) \
    pthread_mutex_lock(lockPtr); \
    static bool exe_flag_ = false; \
    if (exe_flag_) { \
        pthread_mutex_unlock(lockPtr); \
        goto YOU_ALSO_MUST_CALL_EXECUTE_ONCE_END; \
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
 
 Example for function:
 
 static execute_init(z)
 
 void doSomething() {
     test();
     test();
 }
 
 void test() {
     printf("-----\n");
     
     execute_once_on(z)
     printf("hello\n");
     
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        execute_once_off(z)
     });
     
     printf("-----\n");
 }
 
 
 
 Example for method:
 
 @implementation XXXViewController {
     execute_init(_exe)
 }
 
 - (void)doSomething {
     [self networkFetch];
     [self networkFetch];
 }
 
 - (void)networkFetch {
     execute_once_on(_exe)
     [networkManager request:post completion:^(id response) {
        execute_once_off(_exe)
        ...
     } failure:^(NSError *error) {
        execute_once_off(_exe)
        ...
     }];
 }
 *  @endcode
 */
#ifndef execute_once_on
#define execute_once_on(x) \
    _execute_once_on_pthread_mutex_lockify(&(x))
#endif

#ifndef execute_once_off
#define execute_once_off(x) \
    _execute_once_off_pthread_mutex_lockify(&(x))
#endif

#ifndef _execute_once_on_pthread_mutex_lockify
#define _execute_once_on_pthread_mutex_lockify(lockPtr) \
    pthread_mutex_lock(lockPtr); \
    static bool exe_flag1_ = false; \
    if (exe_flag1_) { \
        pthread_mutex_unlock(lockPtr); \
        return; \
    } \
    exe_flag1_ = true; \
    pthread_mutex_unlock(lockPtr);
#endif

#ifndef _execute_once_off_pthread_mutex_lockify
#define _execute_once_off_pthread_mutex_lockify(lockPtr) \
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
/// * execute_once() can be used for both inside of a function and a method, and perform_once() is usually used for inside of a method.
/// * Must call execute_init() for using execute_once()
/// * The code below execute_once() only can be executed once. If the method receiver object (self) is released, and new receiver object (self) is created, the code below perform_once() can be re-performed again. This is the key factor for considering to use execute_once() or perform_once().


/**
 *  Perform a method only once. Call perform_once() at first line inside of a non-returned method.
 *  perform_once() also can be used for executing code once after the perform_once() line, even if not use it at first line.
 *
 *  Remark: If you use perform_once() inside of a method, then the _cmd as associated key is taken. Better use another key for other associated objects.
 *
 *  @code
 
 - (void)test {
    perform_once()
    NSLog(@"hello");
 }
 
 for (int i = 0; i < 5; i++) {
    [self test];
 }
 
 *  @endcode
 */
#ifndef perform_once
#define perform_once() \
    if (objc_getAssociatedObject(self, _cmd)) return; \
    else objc_setAssociatedObject(self, _cmd, @(YES), OBJC_ASSOCIATION_RETAIN);
#endif

/* ------------------------------------------------------------------------------------------------------------ */

// perform_once_begin()
// perform_once_end()

/**
 *  Perform part of code inside of a method only once. Use perform_once_begin() and perform_once_end() as a pair.
 *
 *  Remark: If you use perform_once_begin() inside of a method, then the _cmd as associated key is taken. Better use another key for other associated objects.
 *
 *  @code
 
 - (void)test {
     NSLog(@"-----");
     perform_once_begin()
     NSLog(@"hello");
     perform_once_end()
     NSLog(@"-----");
 }
 
 for (int i = 0; i < 5; i++) {
     [self test];
 }
 
 *  @endcode
 */

#ifndef perform_once_begin
#define perform_once_begin() \
    if (objc_getAssociatedObject(self, _cmd)) goto YOU_ALSO_MUST_CALL_PERFORM_ONCE_END; \
    else objc_setAssociatedObject(self, _cmd, @(YES), OBJC_ASSOCIATION_RETAIN);
#endif

#ifndef perform_once_end
#define perform_once_end() \
    YOU_ALSO_MUST_CALL_PERFORM_ONCE_END: {}
#endif

/* ------------------------------------------------------------------------------------------------------------ */

#endif /* YJExecutionMacros_h */
