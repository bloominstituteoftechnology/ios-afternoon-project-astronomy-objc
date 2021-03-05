//
//  LSILog.m
//  Astronomy - ObjC
//
//  Created by James McDougall on 3/5/21.
//

#import <Foundation/Foundation.h>

void LSILog(NSString *format, ...) {
    va_list args;
    va_start(args, format);
    NSString *stringWithNewline = [format stringByAppendingString:@"\n"];
    NSString *formattedString = [[NSString alloc] initWithFormat: stringWithNewline
                                                       arguments: args];
    va_end(args);
    [[NSFileHandle fileHandleWithStandardOutput]
     writeData: [formattedString dataUsingEncoding: NSUTF8StringEncoding]];
}
