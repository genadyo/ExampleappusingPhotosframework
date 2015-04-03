//
//  PhotosPatch.m
//  Organizer
//
//  Created by Sash Zats on 4/2/15.
//  Copyright (c) 2015 Genady Okrain. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "fishhook.h"
#import <dlfcn.h>


typedef void(*diff_arrays_t)(NSArray *arg0, NSArray *arg1, NSArray *arg2, NSIndexSet **arg3, NSIndexSet **arg4, NSIndexSet **arg5, NSArray **arg6, NSIndexSet **arg7);
static diff_arrays_t original_diffArrays;
static void patched_diffArrays(NSArray *arg0, NSArray *arg1, NSArray *arg2, NSIndexSet **arg3, NSIndexSet **arg4, NSIndexSet **arg5, NSArray **arg6, NSIndexSet **arg7) {
    original_diffArrays(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    if (arg6 && *arg6) {
        *arg6 = CFRetain((__bridge CFTypeRef)(*arg6));
    }

}


@interface PhotoLibraryServicesPatcher : NSObject
@end


@implementation PhotoLibraryServicesPatcher

//+ (void)load {
//    @autoreleasepool {
//        [self _patchPhotoLibraryServices];
//    }
//}

+ (void)_patchPhotoLibraryServices {
    original_diffArrays = dlsym(RTLD_DEFAULT, "diffArrays");
    rebind_symbols((struct rebinding[1]){{"diffArrays", patched_diffArrays}}, 1);
}

@end
