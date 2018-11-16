//
//  TestRACViewController.m
//  testContact
//
//  Created by East Agile on 9/21/18.
//  Copyright © 2018 IMac. All rights reserved.
//

#import "TestRACViewController.h"
#import "RACDisposeBag.h"
#import "RACDisposable+DisposeBag.h"
#import "EXTScope.h"

@interface TestRACViewController ()
@property (nonatomic, strong ) RACSubject *times;
@property (nonatomic, strong ) RACDisposeBag *disposeBag;
@end

@implementation TestRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional set/Users/imac/code/bbm-i/Alaska/Alaska/3rdParty/ReactiveObjC/ReactiveObjC/extobjc/metamacros.hup after loading the view.
    self.times = [RACSubject subject];
    self.disposeBag = [RACDisposeBag new];
    
    __weak typeof(self) weakSelf = self;
    
//    RACDisposable *disposable =
//    [[self.times map:^id _Nullable(id  _Nullable value) {
//        return [weakSelf mapstr:value];
//    }] subscribeNext:^(id  _Nullable x) {
//        [weakSelf testLog:x];
//    } error:^(NSError * _Nullable error) {/Users/imac/code/bbm-i/Alaska/Alaska/3rdParty/ReactiveObjC/ReactiveObjC/extobjc/metamacros.h
//
//    } completed:^{
//
//    }];
//
//    [disposable addDisposableTo:self.disposeBag];
    
    @weakify(self)
    [[[[self rxSample] flattenMap:^ RACSignal<NSString *> *(id  _Nullable value) {
        @strongify(self)
        return [[self rxSample] flattenMap:^ RACSignal<NSString *> *(id  _Nullable value) {
            return [self rxSample];
        }];
    }] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self testLog:x];
    }] addDisposableTo:self.disposeBag];
}

- (NSString *)mapstr:(NSString *)str {
    return [NSString stringWithFormat:@">>>> %@", str];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.times sendNext:@"1"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)testLog:(NSString *)str {
    NSLog(@"abc %@", str);
}

- (void)dealloc {
    NSLog(@"deablloc");
}


- (RACSignal<NSString *> *)rxSample {
    return [RACSignal startLazilyWithScheduler:[RACScheduler scheduler]
                                         block:^(id<RACSubscriber> subscriber) {
                                             for (int i = 0; i < 100; i ++) {
                                                 [subscriber sendNext:[NSString stringWithFormat:@"%d", i]];
                                                 sleep(i);
                                             }
                                             [subscriber sendCompleted];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
