//
//  LSIFileHelper.m
//  Astronomy - ObjC
//
//  Created by James McDougall on 3/5/21.
//

#import <Foundation/Foundation.h>
#import "LSIFileHelper.h"

NSData *loadFile(NSString *filename, Class classType) {
    NSString *path = pathForFile(filename, classType);
    NSData *data = [NSData dataWithContentsOfFile:path];
     return data;
}


NSString *pathForFile(NSString *filename, Class classType) {
    NSBundle *bundle = [NSBundle bundleForClass:classType];
    NSString *basename = [filename stringByDeletingPathExtension];
    NSString *extension = [filename pathExtension];
    
    NSString *path = [bundle pathForResource:basename ofType:extension];
    return path;
}
