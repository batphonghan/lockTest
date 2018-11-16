//
//  RACDisposeBag.m
//  Alaska
//
//  Created by woi on 11/29/16.
//  Copyright © 2016 BlackBerry Inc. All rights reserved.
//
#import "RACDisposeBag.h"

@implementation RACDisposeBag

- (instancetype)init {
    self = [super init];
    if (self) {
        _disposables = [NSMutableArray<RACDisposable *> array];
    }
    
    return self;
}

- (void)dealloc {
    [self disposeAll];
}

- (void)addDisposable:(RACDisposable *)disposable {
    [self.disposables addObject:disposable];
}

- (void)disposeAll {
    for (RACDisposable *disposable in self.disposables) {
        [disposable dispose];
    }
    if ([self.disposables count] > 0) {
        [self.disposables removeAllObjects];
    }
}

@end
