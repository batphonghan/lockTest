//
//  testContactTests.m
//  testContactTests
//
//  Created by East Agile on 11/14/18.
//  Copyright © 2018 IMac. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <libkern/OSAtomic.h>
#import <stdatomic.h>
#import <pthread.h>

#define times  1000000

@interface testContactTests : XCTestCase

@end

@implementation testContactTests {
    int demoCountAtomic;
    pthread_mutex_t mutex;
    NSLock *nsLock;
    int demoPthreadLockCount;
    int countSyncho;
    int countNSLock;
    int demoQueueSerial;
}

- (void)setUp {
    [super setUp];
    nsLock = [[NSLock alloc] init];
    
}

- (void)testSynchonize {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self synchonize];
    }];
}


- (void)testPthreadLock {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self demoPthreadLock];
    }];
}


- (void)testOSAtomicIncrement32 {
    [self measureBlock:^{
        [self demoOSAtomicIncrement32];
    }];
}

- (void)testNSLock {
    [self measureBlock:^{
        [self nsLock];
    }];
}


- (void)testDemoQueueSerial {
    [self measureBlock:^{
        [self demoQueueSerial];
    }];
}


- (void)demoQueueSerial {
    XCTestExpectation *expect = [self expectationWithDescription:@"Expect synchonize"];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue_sys = dispatch_queue_create("sysn.queue", NULL);
    demoQueueSerial = 0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < times; i ++) {
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            dispatch_async(queue_sys, ^{
                self->demoQueueSerial ++;
                dispatch_group_leave(group);
            });
        });
    }
    dispatch_group_notify(group, queue, ^{
        [expect fulfill];
//        NSLog(@"demoQueueSerial %d", self->demoQueueSerial);
    });
    
    [self waitForExpectations:@[expect] timeout:5.0];
}


- (void)nsLock {
    countNSLock = 0;
    
    XCTestExpectation *expect = [self expectationWithDescription:@"Expect nsLock"];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < times; i ++) {
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
                [self->nsLock lock];
                self->countNSLock ++;
                [self->nsLock unlock];
            dispatch_group_leave(group);
        });
    }
    dispatch_group_notify(group, queue, ^{
        [expect fulfill];
    });
    
    [self waitForExpectations:@[expect] timeout:5.0];
}

- (void)synchonize {
    XCTestExpectation *expect = [self expectationWithDescription:@"Expect synchonize"];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < times; i ++) {
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            @synchronized (self) {
                self->countSyncho ++;
            }
            dispatch_group_leave(group);
        });
    }
    dispatch_group_notify(group, queue, ^{
        [expect fulfill];
    });
    
    [self waitForExpectations:@[expect] timeout:5.0];
}



- (void)demoPthreadLock {
    XCTestExpectation *expect = [self expectationWithDescription:@"Expect demoPthreadLock"];
    demoPthreadLockCount = 0;
    pthread_mutex_init(&mutex, NULL);
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < times; i ++) {
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            pthread_mutex_lock(&self->mutex);
            self->demoPthreadLockCount ++;
            pthread_mutex_unlock(&self->mutex);
            dispatch_group_leave(group);
        });
    }
    dispatch_group_notify(group, queue, ^{
        [expect fulfill];
    });
    [self waitForExpectations:@[expect] timeout:5.0];
}

- (void)demoOSAtomicIncrement32 {
    XCTestExpectation *expect = [self expectationWithDescription:@"Expect demoOSAtomicIncrement32"];
    demoCountAtomic = 0;
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < times; i ++) {
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            OSAtomicIncrement32(&self->demoCountAtomic);
            dispatch_group_leave(group);
        });
    }
    dispatch_group_notify(group, queue, ^{
        [expect fulfill];
    });
    
    [self waitForExpectations:@[expect] timeout:5.0];
}


@end
