//
//  categ.h
//  CoreDataMsster
//
//  Created by MK SS9 on 14/07/11.
//  Copyright 2011 Neo. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Entity;

@interface categ :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * categ_name;
@property (nonatomic, retain) NSSet* CategToEntity;

@end


@interface categ (CoreDataGeneratedAccessors)
//- (void)addCategToEntityObject:(Entity *)value;
- (void)addCategToEntityObject:(NSManagedObject *)value;
// - (void)removeCategToEntityObject:(Entity *)value;
- (void)removeCategToEntityObject:(Entity *)value;
- (void)removeCategToEntityObject:(Entity *)value;
- (void)addCategToEntity:(NSSet *)value;
- (void)removeCategToEntity:(NSSet *)value;

@end

