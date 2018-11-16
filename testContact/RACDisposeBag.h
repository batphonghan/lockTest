//
//  RACDisposeBag.h
//  Alaska
//
//  Created by woi on 11/29/16.
//  Copyright © 2016 BlackBerry Inc. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>

@interface RACDisposeBag : NSObject

@property (nonatomic, strong) NSMutableArray<RACDisposable *> *disposables;

- (void)addDisposable:(RACDisposable*) disposable;
- (void)disposeAll;

@end
