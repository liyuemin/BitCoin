//
//  DBQueueManager.h
//  MaiMaiMai
//
//  Created by yuemin li on 16/9/29.
//  Copyright © 2016年 yuemin li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBQueueManager : NSObject{
    
    NSString * TAG;
    
    /**
     * 数据库版本号
     */
    int		DB_VERSION;
    /**
     * 引用数据库底层FMDB
     */
    
}
+ (DBQueueManager *)shareDBQueueManager;

- (BOOL)haveTable;
- (void)createTable:(NSString *)tablename;
- (BOOL)dropTable:(NSString *)tablename;

- (BOOL)insertData:(id)data toTable:(NSString *)name;
- (BOOL)insertupdateData:(id)data toTable:(NSString *)name;
- (BOOL)addColumToTable:(NSString *)table withPram:(NSArray *)prams;

- (BOOL)updateData:(id)data toTable:(NSString *)name Where:(NSString *)where;
- (BOOL)deleteDataFromTable:(NSString *)name Where:(NSString *)where;


- (NSMutableArray *)queryFromTable:(NSString *)name
                      columnString:(NSString *)columnString
                             Where:(NSString *)where
                             Start:(NSString *)start
                             Limit:(NSString *)limit
                              Desc:(BOOL)desc
                           OrderBy:(NSString *)orderby;

- (NSDictionary *)getDataFromTable:(NSString *)name Where:(NSString *)where Desc:(BOOL)desc
                           OrderBy:(NSString *)orderby;
- (BOOL)executeSql:(NSString *)sql;
- (int)countOfTable:(NSString*)table;
-(int)countOfTable:(NSString*)table where:(NSString*)where;

- (BOOL)columnExists:(NSString *)column table:(NSString *)table;

- (BOOL)changeColumnToTable:(NSString *)table withParam:(NSDictionary *)param;

/**
 *直接执行查询
 */
- (NSArray *)executeSelectSql:(NSString *)sql;


@end
