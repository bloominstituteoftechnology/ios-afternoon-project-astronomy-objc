//
//  LSILog.h
//  Astronomy - ObjC
//
//  Created by James McDougall on 3/5/21.
//

#import <Foundation/Foundation.h>

// Import this header any place you want to have a clean log output like
// print() in Swift
// Based on: https://stackoverflow.com/a/1354736/276626

#define USECUSTOMLOGS 1     // 0 = Off, 1 = On
#if USECUSTOMLOGS
#define NSLog LSILog
#endif

void LSILog(NSString *format, ...);
