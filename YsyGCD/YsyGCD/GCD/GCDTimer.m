//
//  GCDTimer.m
//  YsyGCD
//
//  Created by LH on 8/17/20.
//  Copyright © 2020 ysyplay. All rights reserved.
//

#import "GCDTimer.h"
#import "GCDQueue.h"
@interface GCDTimer ()

@property (strong, readwrite, nonatomic) dispatch_source_t dispatchSource;

@end
@implementation GCDTimer
- (instancetype)init {
    self = [super init];
    if (self) {
        self.dispatchSource = \
        dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    }
    return self;
}

- (instancetype)initInQueue:(GCDQueue *)queue {
    
    self = [super init];
    if (self) {
        self.dispatchSource = \
        dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue.dispatchQueue);
    }
    return self;
}
- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs {
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.dispatchSource, block);
}

- (void)event:(dispatch_block_t)block timeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs {
    NSParameterAssert(block);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, delaySecs * NSEC_PER_SEC), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.dispatchSource, block);
}

- (void)start {
    dispatch_resume(self.dispatchSource);
}

- (void)destroy {
    dispatch_source_cancel(self.dispatchSource);
}

@end
