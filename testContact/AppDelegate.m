//
//  AppDelegate.m
//  testContact
//
//  Created by East Agile on 7/30/18.
//  Copyright © 2018 IMac. All rights reserved.
//

#import "AppDelegate.h"
#import "Person.h"
#import<CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <Contacts/Contacts.h>
#import <libkern/OSAtomic.h>
#import <stdatomic.h>
#import <pthread.h>

#define times  10000
@interface AppDelegate () {
    NSOperationQueue *queue;
    int a;
    NSCache *cached;
    int demoCountAtomic;
    pthread_mutex_t mutex;
    int demoPthreadLockCount;
    int countSyncho;
    
}

@property (nonatomic , strong ) Person *per_non;
@property (atomic , strong ) Person *per_atonic;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   
//    for (int i = 0; i < 10; i ++ ) {
//        [self demoPthreadLock];
//        [self demoOSAtomicIncrement32];
//        [self testSynchonize];
//        
//        NSLog(@"=======================");
//    }
    
    int x;
    [NSThread detachNewThreadWithBlock:^{
        int y;
        for(y = 0;y < 50;++y)
        {
            printf("Object Thread says x is %i\n",y);
            usleep(1);
        }
    }];
    
    for(x=0;x<50;++x)
    {
        printf("Main thread says x is %i\n",x);
        usleep(1);
    }
    
    
    return YES;
}


- (void)testSynchonize {
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    
    
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
        NSTimeInterval end = [NSDate timeIntervalSinceReferenceDate];
        NSLog(@">>>> %d", self->demoPthreadLockCount);
        NSLog(@">>>> times  %f Synchonize", end - start);
        
    });
}

- (void)demoPthreadLock {
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
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
        NSTimeInterval end = [NSDate timeIntervalSinceReferenceDate];
        NSLog(@">>>> %d", self->demoPthreadLockCount);
        NSLog(@">>>> times  %f PthreadLock", end - start);
        
    });
}

- (void)demoOSAtomicIncrement32 {
    demoCountAtomic = 0;
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
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
        NSTimeInterval end = [NSDate timeIntervalSinceReferenceDate];
        NSLog(@">>>> %d", self->demoCountAtomic);
        NSLog(@">>>> times %f OSAtomicIncrement32 ", end - start);
    });
}

-(NSString *) randomStringWithLength:(int)len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    NSString *___letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    uint32_t leng = ((uint32_t)[___letters length]);
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [___letters characterAtIndex: arc4random_uniform(leng)]];
        [randomString appendFormat:@" "];
        [randomString appendFormat: @"%C", [___letters characterAtIndex: arc4random_uniform(leng)]];
    }
    
    return randomString;
}

- (void)setvCard {
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObject:@[@[@"123", @"456"]]];
    
    @try {
        NSBundle *main = [NSBundle mainBundle];
        NSString *url = [main pathForResource:@"john" ofType:@"vcf"];
        
        NSError *err;
        NSData *contactData = [NSData dataWithContentsOfFile:url options:0 error:&err];
        [arr addObject:contactData];
        NSArray<CNContact *> *cnContacts = [CNContactVCardSerialization contactsWithData:contactData error:&err];
        
        NSLog(@"%@", cnContacts);
        
        for (id ar in arr) {
            NSLog(@"%@",[(NSArray *)ar objectAtIndex:0]);
        }
        
    } @catch (NSException *exception) {
        NSLog(@"main: Caught %@: %@", [exception name], [exception  reason]);
    }
//    @finally {
//        NSLog(@"Cleaning up");
//    }
    
    
//    NSMutableArray *list = [NSMutableArray new];
//    [self->cached setObject:list forKey:@"abc"];
//
//    @try {
//        [list performSelector:@selector(abc) withObject:nil afterDelay:0];
//    } @catch (NSException *exception) {
//        NSLog(@"main: Caught %@: %@", [exception name], [exception  reason]);
//    }
//    @finally {
//        NSLog(@"Cleaning up");
//    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
