//
//  NSObject+EKAssociatedObject.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/30/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "NSObject+EKKeyboardAvoiding.h"

#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation NSObject (EKKeyboardAvoiding)

#pragma mark - associate objects

- (void)ek_associateObject:(id)object forKey:(NSString *)key
{
    objc_setAssociatedObject(self, [key UTF8String], object, OBJC_ASSOCIATION_RETAIN);
}

- (id)ek_associatedObjectForKey:(NSString *)key
{
    return objc_getAssociatedObject(self, [key UTF8String]);
}

#pragma mark - observe notifications

- (void)ek_observeNotificationNamed:(NSString *)notificationName action:(SEL)action
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:action name:notificationName object:nil];
}

- (void)ek_stopNotificationsObserving
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];
}

#pragma mark - observe key path

- (void)ek_addObserver:(id)target forKeyPath:(NSString *)keyPath
{
    [self addObserver:target forKeyPath:keyPath
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
}

@end
