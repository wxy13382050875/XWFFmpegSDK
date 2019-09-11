//
//  FileUtil.h
//  QiUtils
//
//  Created by dac_1033 on 2018/10/25.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWFileUtil : NSObject

// 获取沙盒根路径
+ (NSString *)getHomePath;

// 获取tmp路径
+ (NSString *)getTmpPath;

// 获取Documents路径
+ (NSString *)getDocumentsPath;

// 获取Library路径
+ (NSString *)getLibraryPath;

// 获取LibraryCache路径
+ (NSString *)getLibraryCachePath;

// 检查文件、文件夹是否存在
+ (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDir;

// 创建文件
+ (void)createDirectory:(NSString *)path;

// 创建文件夹
+ (NSString *)createFile:(NSString *)filePath fileName:(NSString *)fileName;

// 复制 文件or文件夹
+ (void)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;

// 移动 文件or文件夹
+ (void)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;

// 删除 文件or文件夹
+ (void)removeItemAtPath:(NSString *)path;

// 获取目录下所有内容
+ (NSArray *)getContentsOfDirectoryAtPath:(NSString *)docPath;

// 写入字符串到文件
+ (void) writeToFileString:(NSString *)path string:(NSString *)string;
// 读取字符串到文件
+ (NSString*)readToFileString:(NSString *)path ;

// 写入数组到文件
+ (void) writeToFilArraye:(NSString *)path array:(NSArray *)array;
// 读取数组到文件
+ (NSArray*)readToFileArray:(NSString *)path ;

// 写入字典到文件
+ (void) writeToFileDict:(NSString *)path dict:(NSDictionary *)dict;
// 读取字典到文件
+ (NSDictionary*)readToFileDict:(NSString *)path ;

// 写入data到文件
+ (void) writeToFileData:(NSString *)path dict:(NSData *)data;
// 读取字典到文件
+ (NSData*)readToFileData:(NSString *)path ;
@end

NS_ASSUME_NONNULL_END
