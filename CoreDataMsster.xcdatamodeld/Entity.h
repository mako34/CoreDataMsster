//
//  Entity.h
//  CoreDataMsster
//
//  Created by MK SS9 on 14/07/11.
//  Copyright 2011 Neo. All rights reserved.
//

#import <CoreData/CoreData.h>

@class categ;

@interface Entity :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * item;
@property (nonatomic, retain) categ * EntityToCateg;

@end



