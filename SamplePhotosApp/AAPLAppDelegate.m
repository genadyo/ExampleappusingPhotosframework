/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  The application's delegate.
  
 */

#import "AAPLAppDelegate.h"

#import <dlfcn.h>
#import "fishhook.h"


typedef void(*diff_arrays_t)(NSMutableArray    /* NSManagedObjectID     _previousItems */   *arg0,
                        NSMutableArray      /* NSManagedObjectID     ?? */               *arg1,
                        NSArray             /* NSManagedObjectID     _changedItems */    *arg2,
                        NSIndexSet **arg3,
                        NSIndexSet **arg4,
                        NSIndexSet **/* nil */arg5,
                        NSArray /* ? */ **arg6,
                        NSIndexSet /* nil */ **arg7);

static diff_arrays_t orig_diffArray;

static void my_diffArray(NSMutableArray    /* NSManagedObjectID     _previousItems */   *arg0,
                         NSMutableArray      /* NSManagedObjectID     ?? */               *arg1,
                         NSArray             /* NSManagedObjectID     _changedItems */    *arg2,
                         NSIndexSet **arg3,
                         NSIndexSet **arg4,
                         NSIndexSet **/* nil */arg5,
                         NSArray **/* ? */arg6,
                         NSIndexSet ** /* nil */arg7) {
    orig_diffArray(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    if (*arg6) {
        *arg6 = CFRetain((__bridge CFTypeRef)(*arg6));
    }
}


static void zts_swizzleAway() {
    orig_diffArray = dlsym(RTLD_DEFAULT, "diffArrays");
    rebind_symbols((struct rebinding[1]){
        {"diffArrays", my_diffArray}
    }, 1);
    
}

@implementation AAPLAppDelegate

- (void)applicationDidBecomeActive:(UIApplication *)application {
    zts_swizzleAway();
}

@end
