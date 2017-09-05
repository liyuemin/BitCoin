//
//  DBQueueManager.m
//  MaiMaiMai
//
//  Created by yuemin li on 16/9/29.
//  Copyright © 2016年 yuemin li. All rights reserved.
//

#import "DBQueueManager.h"
#import "DBQueueManager.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"


@interface DBQueueManager()
{
    FMDatabaseQueue *dbQueue;
}

@property (nonatomic ,strong)FMDatabaseQueue *dbQueue;
@end

@implementation DBQueueManager
@synthesize dbQueue = _dbQueue;

+ (DBQueueManager *)shareDBQueueManager
{
    static DBQueueManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        manager = [[DBQueueManager alloc] init];
    });
    return manager;
}

- (void)initTable
{
    NSArray *createTableSqls = [NSArray arrayWithObjects:
                                @"CREATE TABLE TJVERSION_TABLE (vid VARCHAR PRIMARY KEY NOT NULL,vVersion double)"
                                ,
                                @"CREATE TABLE TJHOMECATENEW_TABLE (ucid_code VARCHAR PRIMARY KEY NOT NULL,ucid VARCHAR,selected_ucid_code VARCHAR)"
                                ,
                                @"CREATE TABLE TJHOMECATEDATA_TABLE (ucid VARCHAR PRIMARY KEY NOT NULL,ucid_index integer,dataInfo_lastPageNo integer,dataInfo_lastOffsetY double,dataInfo_lastUpdateTime double,dataInfo VARCHAR,dataInfo_lastSubUcid VARCHAR)"
                                ,
                                @"CREATE TABLE TJHOMEREQUESTMODEL_TABLE (ucid VARCHAR PRIMARY KEY NOT NULL,requestType integer,responseType integer,page char,selected char)"
                                ,
                                @"CREATE TABLE USERINFO_TABLE (uid VARCHAR PRIMARY KEY NOT NULL,userInfo VARCHAR)"
                                ,
                                nil];
    [self.dbQueue inDatabase:^(FMDatabase *db){
        //[db open];
        //[db beginTransaction];
        for(NSString *sql in createTableSqls){
            NSArray *tablecl = [sql componentsSeparatedByString:@" "];
            NSString *tablename = [tablecl objectAtIndex:2];
            FMResultSet *re = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",tablename]];
            if (re == nil){
                if(![db executeUpdate:sql]){
                    NSLog(@"rollback");
                    [db rollback];
                    break;
                }
 
            }
            [re close];
        }
        //[db commit];
        //[db close];
        
    }];
}

- (BOOL)haveTable
{
    if(self.dbQueue)
    {
        return YES;
    }
    return NO;
}

- (void)createTable:(NSString *)tablename
{
    NSString *documentsDir = (NSString *)[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *tmpPath = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"BD%@.sqlite",tablename]];
    NSLog(@"DB pathIS:%@",tmpPath);
    if (![[NSFileManager defaultManager] fileExistsAtPath:tmpPath]){
        self.dbQueue = [[FMDatabaseQueue alloc]  initWithPath:tmpPath];
        
    }else {
        self.dbQueue = [[FMDatabaseQueue alloc] initWithPath:tmpPath];
    }
    [self initTable];
}

- (BOOL)dropTable:(NSString *)tablename
{
    __block BOOL issucsuful = NO;
    [self.dbQueue inTransaction:^(FMDatabase *qdb , BOOL *rollback){
        issucsuful = [qdb executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@",tablename]];
    }];
    return issucsuful;
}

//- (BOOL)addNewTable:(NSString *)tablename {
//    if (!self.dbQueue) {
//        NSLog(@"open membersDB failed");
//        return NO;
//    }
//    
//    __block BOOL success = NO;
//    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", @"Member" ];
//    
//    [self.dbQueue inDatabase:^(FMDatabase *db){
//       FMResultSet *rs = [db executeQuery:existsSql];
//        if ([rs next]){
//           NSInteger count = [rs intForColumn:@"countNum"];
//            if (count == 1){
//                success = YES;
//            }
//        }
//    }];
//    
//}

- (BOOL)columnExists:(NSString *)column table:(NSString *)table
{
    __block BOOL success = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db){
        success = [db columnExists:column inTableWithName:table];
    }];
    return success;
}

- (BOOL)changeColumnToTable:(NSString *)table withParam:(NSDictionary *)param
{
    __block BOOL success = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db){
        for(NSString *colum in [param allKeys]){
            if(![db columnExists:colum inTableWithName:table]){
                success = [db executeUpdate:[NSString stringWithFormat:@"ALTER TABLE %@ CHANGE %@ %@ VARCHAR",table,colum,[param valueForKey:colum]]];
                NSAssert(success, @"alter table failed: %@", [db lastErrorMessage]);
            }
        }
    }];
    return success;
}

- (BOOL)addColumToTable:(NSString *)table withPram:(NSArray *)prams
{
    __block BOOL success = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db){
        for(NSString *colum in prams){
            if(![db columnExists:colum inTableWithName:table]){
                success = [db executeUpdate:[NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ VARCHAR",table,colum]];
                NSAssert(success, @"alter table failed: %@", [db lastErrorMessage]);
            }
        }
    }];
    return success;
}

- (BOOL)insertData:(id)data toTable:(NSString *)name
{
    __block BOOL issucsuful = NO;
    [self.dbQueue inTransaction:^(FMDatabase *qdb , BOOL *rollback){
        
        if ([data isKindOfClass:[NSDictionary class]]){
            //[qdb open];
            
            NSMutableArray *s = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < [data allValues].count; ++i)
            {
                [s addObject:@"?"];
            }
            
            NSString *sql = [[NSString alloc] initWithFormat:@"INSERT OR REPLACE into %@ (%@) values (%@)", name, [[data allKeys] componentsJoinedByString:@","], [s componentsJoinedByString:@","]];
            BOOL result = [qdb executeUpdate:sql withArgumentsInArray:[data allValues]];
            
            NSLog(@"insertData sql is:%@.%d.",sql,result);
            
            //[qdb close];
            issucsuful = result;
        }else {
            //[qdb open];
            for (NSMutableDictionary *_data in data){
                NSMutableArray *s = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < [_data allValues].count; ++i)
                {
                    [s addObject:@"?"];
                }
                NSString *sql = [[NSString alloc] initWithFormat:@"INSERT OR REPLACE into %@ (%@) values (%@)", name, [[_data allKeys] componentsJoinedByString:@","], [s componentsJoinedByString:@","]];
                
                if (![qdb executeUpdate:sql withArgumentsInArray:[_data allValues]]){
                    NSLog(@"%@", sql);
                }
                //                NSLog(@"startgo2%@,",name);
                
            }
            //[qdb close];
            issucsuful = YES;
        }
    }];
    NSLog(@"startgo3%@,",name);
    return issucsuful;
}

- (BOOL)insertupdateData:(id)data toTable:(NSString *)name
{
    __block BOOL issucsuful = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db){
        if ([data isKindOfClass:[NSDictionary class]]){
            //[db open];
            
            NSMutableArray *s = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < [data allValues].count; ++i)
            {
                [s addObject:@"?"];
            }
            NSString *sql = [[NSString alloc] initWithFormat:@"INSERT OR REPLACE into %@ (%@) values (%@)", name, [[data allKeys] componentsJoinedByString:@","], [s componentsJoinedByString:@","]];
            BOOL result = [db executeUpdate:sql withArgumentsInArray:[data allValues]];
            //[db close];
            issucsuful = result;
        }else {
            //[db open];
            for (NSMutableDictionary *_data in data){
                NSMutableArray *s = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < [_data allValues].count; ++i)
                {
                    [s addObject:@"?"];
                }
                NSString *sql = [[NSString alloc] initWithFormat:@"INSERT OR REPLACE into %@ (%@) values (%@)", name, [[_data allKeys] componentsJoinedByString:@","], [s componentsJoinedByString:@","]];
                
                if (![db executeUpdate:sql withArgumentsInArray:[_data allValues]]){
                    //                    NSLog(@"%@", sql);
                    //                    NSLog(@"error");
                }
            }
            // [db close];
            
            issucsuful =  YES;
        }
        issucsuful =  NO;
    }];
    return issucsuful;
}

- (BOOL)updateData:(id)data toTable:(NSString *)name Where:(NSString *)where
{
    __block BOOL issucsuful = NO;
    [self.dbQueue inTransaction:^(FMDatabase *db ,BOOL *rollback){
        //[db open];
        //[db beginTransaction];
        NSMutableString *sql = [[NSMutableString alloc] initWithFormat:@"update  %@ set ", name];
        NSArray *keys =[data allKeys];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSString *key in keys){
            [tempArray addObject:[NSString stringWithFormat:@"%@ = (?)", key]];//[data objectForKey:key]
        }
        [sql appendString:[tempArray componentsJoinedByString:@","]];
        if (where){
            [sql appendFormat:@" where %@", where];
        }
        BOOL result = [db executeUpdate:sql withArgumentsInArray:[data allValues]];
        if (!result){
            [db rollback];
        }
        //BOOL result = [db commit];
        //BOOL result = [db executeUpdate:sql];
        //[db close];
        issucsuful =  result;
        
    }];
    return issucsuful;
}

- (BOOL)deleteDataFromTable:(NSString *)name Where:(NSString *)where
{
    __block BOOL issucsuful = NO;
    [self.dbQueue inTransaction:^(FMDatabase *db ,BOOL *rollback){
        //[db open];
        NSMutableString *sql = [[NSMutableString alloc] initWithFormat:@"delete from %@", name];
        if (where){
            [sql appendFormat:@" where %@", where];
        }
        BOOL result = [db executeUpdate:sql];
        //[db close];
        
        issucsuful = result;
        
    }];
    return issucsuful;
}

- (NSMutableArray *)queryFromTable:(NSString *)name
                      columnString:(NSString *)columnString
                             Where:(NSString *)where
                             Start:(NSString *)start
                             Limit:(NSString *)limit
                              Desc:(BOOL)desc
                           OrderBy:(NSString *)orderby
{
    __block NSMutableArray *result = [NSMutableArray array];
    [self.dbQueue inDeferredTransaction:^(FMDatabase *qdb , BOOL *rollback){
        //[qdb open];
        NSMutableString *sql = [NSMutableString stringWithFormat:@"select %@ from %@ ", columnString?:@"*",name];
        if (where){
            [sql appendFormat:@"where %@ ", where];
        }
        if (orderby){
            [sql appendFormat:@"order by %@ %@ ", orderby, desc ? @"desc" : @"asc"];
        }
        if (limit > 0){
            if (start == nil)
            {
                [sql appendFormat:@"limit %@ ", limit];
            }
            else
            {
                [sql appendFormat:@"limit %@, %@ ", start, limit];
            }
            
        }
        NSLog(@".....sql lang :%@",sql);
        FMResultSet *rs = [qdb executeQuery:sql];
        if (rs){
            while ([rs next]) {
                [result addObject:[rs resultDictionary]];
            }
        }
        //[qdb close];
        
    }];
    return result;
}

- (NSDictionary *)getDataFromTable:(NSString *)name
                             Where:(NSString *)where
                              Desc:(BOOL)desc
                           OrderBy:(NSString *)orderby
{
    __block NSDictionary *result = nil;
    [self.dbQueue inTransaction:^(FMDatabase *db , BOOL *rollback){
        //[db open];
        NSMutableString *sql = [NSMutableString stringWithFormat:@"select * from %@ ", name];
        if (where){
            [sql appendFormat:@"where %@ ", where];
        }
        if (orderby){
            [sql appendFormat:@"order by %@ %@ ", orderby, desc ? @"desc" : @"asc"];
        }
        
        //        NSLog(@".....sql lang :%@",sql);
        FMResultSet *rs = [db executeQuery:sql];
        if ([rs next]){
            result = [rs resultDictionary];
        }
        //[db close];
        
    }];
    return result;
}

- (BOOL)executeSql:(NSString *)sql
{
    __block BOOL issucsuful = NO;
    
    [self.dbQueue inDatabase:^(FMDatabase *db){
        //[db open];
        issucsuful = [db executeUpdate:sql];
        
        //[db close];
        
    }];
    return issucsuful;
}

- (int)countOfTable:(NSString*)table
{
    __block int count = 0;
    [self.dbQueue inTransaction:^(FMDatabase *db , BOOL *rollback){
        NSString *sql = [NSString stringWithFormat:@"select count(*) from %@",table];
        //[db open];
        count = [db intForQuery:sql];
        //[db close];
    }];
    return count;
}

-(int)countOfTable:(NSString*)table where:(NSString*)where
{
    
    __block  int count = 0;
    [self.dbQueue inTransaction:^(FMDatabase *db , BOOL *rollback){
        NSString *sql = [NSString stringWithFormat:@"select count(*) from %@ where %@",table,where];
        //[db open];
        count = [db intForQuery:sql];
        //[db close];
        
    }];
    return count;
}

/**
 *直接执行查询
 */
- (NSArray *)executeSelectSql:(NSString *)sql
{
    __block  NSMutableArray *result = [NSMutableArray array];
    [self.dbQueue inTransaction:^(FMDatabase *db , BOOL *rollback){
        //[db open];
        FMResultSet *rs = [db executeQuery:sql];
        if (rs){
            while ([rs next]) {
                [result addObject:[rs resultDictionary]];
            }
        }
        //[db close];
        
    }];
    return result;
}

@end
