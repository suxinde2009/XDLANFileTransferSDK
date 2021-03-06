//
//  NSFileManager+XDCommonLib.h
//  XDCommonLib
//
//  Created by suxinde on 16/4/11.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Directory type enum
 */
typedef NS_ENUM(NSInteger, DirectoryType) {
    /**
     *  Main bundle directory
     */
    DirectoryTypeMainBundle = 0,
    /**
     *  Library directory
     */
    DirectoryTypeLibrary,
    /**
     *  Documents directory
     */
    DirectoryTypeDocuments,
    /**
     *  Cache directory
     */
    DirectoryTypeCache
};


@interface NSFileManager (XDCommonLib)

/**
 *  Read a file an returns the content as NSString
 *
 *  @param file File name
 *  @param type File type
 *
 *  @return Returns the content of the file a NSString
 */
+ (NSString * _Nullable)readTextFile:(NSString * _Nonnull)file
                              ofType:(NSString * _Nonnull)type;

/**
 *  Save a given array into a PLIST with the given filename
 *
 *  @param path     Path of the PLIST
 *  @param filename PLIST filename
 *  @param array    Array to save into PLIST
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)saveArrayToPath:(DirectoryType)path
           withFilename:(NSString * _Nonnull)fileName
                  array:(NSArray * _Nonnull)array;

/**
 *  Load array from a PLIST with the given filename
 *
 *  @param path     Path of the PLIST
 *  @param fileName PLIST filename
 *
 *  @return Returns the loaded array
 */
+ (NSArray * _Nullable)loadArrayFromPath:(DirectoryType)path
                            withFilename:(NSString * _Nonnull)fileName;

/**
 *  Get the Bundle path for a filename
 *
 *  @param fileName Filename
 *
 *  @return Returns the path as a NSString
 */
+ (NSString * _Nonnull)getBundlePathForFile:(NSString * _Nonnull)fileName;

/**
 *  Get the Documents directory for a filename
 *
 *  @param fileName Filename
 *
 *  @return Returns the directory as a NSString
 */
+ (NSString * _Nonnull)getDocumentsDirectoryForFile:(NSString * _Nonnull)fileName;

/**
 *  Get the Library directory for a filename
 *
 *  @param fileName Filename
 *
 *  @return Returns the directory as a NSString
 */
+ (NSString * _Nonnull)getLibraryDirectoryForFile:(NSString * _Nonnull)fileName;

/**
 *  Get the Cache directory for a filename
 *
 *  @param fileName Filename
 *
 *  @return Returns the directory as a NSString
 */
+ (NSString * _Nonnull)getCacheDirectoryForFile:(NSString * _Nonnull)fileName;

/**
 *  Returns the size of the file
 *
 *  @param fileName  Filename
 *  @param directory Directory of the file
 *
 *  @return Returns the file size
 */
+ (NSNumber * _Nullable)fileSize:(NSString * _Nonnull)fileName
                   fromDirectory:(DirectoryType)directory;

/**
 *  Delete a file with the given filename
 *
 *  @param filename Filename to delete
 *  @param origin   Directory of the file
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)deleteFile:(NSString * _Nonnull)fileName
     fromDirectory:(DirectoryType)directory;

/**
 *  Move a file from a directory to another
 *
 *  @param fileName    Filename to move
 *  @param origin      Origin directory of the file
 *  @param destination Destination directory of the file
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)moveLocalFile:(NSString * _Nonnull)fileName
        fromDirectory:(DirectoryType)origin
          toDirectory:(DirectoryType)destination;

/**
 *  Move a file from a directory to another
 *
 *  @param fileName    Filename to move
 *  @param origin      Origin directory of the file
 *  @param destination Destination directory of the file
 *  @param folderName  Folder name where to move the file. If folder not exist it will be created automatically
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)moveLocalFile:(NSString * _Nonnull)fileName
        fromDirectory:(DirectoryType)origin
          toDirectory:(DirectoryType)destination
       withFolderName:(NSString * _Nullable)folderName;

/**
 *  Duplicate a file into another directory
 *
 *  @param origin      Origin path
 *  @param destination Destination path
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)duplicateFileAtPath:(NSString * _Nonnull)origin
                  toNewPath:(NSString * _Nonnull)destination;

/**
 *  Rename a file with another filename
 *
 *  @param origin  Origin path
 *  @param path    Subdirectory path
 *  @param oldName Old filename
 *  @param newName New filename
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)renameFileFromDirectory:(DirectoryType)origin
                         atPath:(NSString * _Nonnull)path
                    withOldName:(NSString * _Nonnull)oldName
                     andNewName:(NSString * _Nonnull)newName;

/**
 *  Get the App settings for a given key
 *
 *  @param objKey Key to get the object
 *
 *  @return Returns the object for the given key
 */
+ (id _Nullable)getAppSettingsForObjectWithKey:(NSString * _Nonnull)objKey;

/**
 *  Set the App settings for a given object and key. The file will be saved in the Library directory
 *
 *  @param value  Object to set
 *  @param objKey Key to set the object
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)setAppSettingsForObject:(id _Nonnull)value
                         forKey:(NSString * _Nonnull)objKey;

/**
 *  Get the given settings for a given key
 *
 *  @param settings Settings filename
 *  @param objKey   Key to set the object
 *
 *  @return Returns the object for the given key
 */
+ (id _Nullable)getSettings:(NSString * _Nonnull)settings
               objectForKey:(NSString * _Nonnull)objKey;

/**
 *  Set the given settings for a given object and key. The file will be saved in the Library directory
 *
 *  @param settings Settings filename
 *  @param value    Object to set
 *  @param objKey   Key to set the object
 *
 *  @return Returns YES if the operation was successful, otherwise NO
 */
+ (BOOL)setSettings:(NSString * _Nonnull)settings
             object:(id _Nonnull)value
             forKey:(NSString * _Nonnull)objKey;

@end
