    //
//  RootViewController.m
//  CoreDataMsster
//
//  Created by Manuel Betancurt on 9/07/11.
//  Copyright 2011 HYPER. All rights reserved.
//

#import "RootViewController.h"
#import "CoreDataMssterAppDelegate.h"
#import "categ.h"
#import "Entity.h"
 
@implementation RootViewController

@synthesize tableViewCateg, tableViewItem, CategRef;
@synthesize nameTextField, ItemTextField, saveCategBtn, saveItemBtn, newCategBtn, newItemBtn, cancelCateg, cancelItem;
@synthesize categ_, entity_;
@synthesize CateglistArray, ItemlistArray, entityArray;
@synthesize fetchedResultsController;//, contextParaSalvarItem; //busqueda!
@synthesize entityName;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[ItemTextField setHidden:true];
	[saveCategBtn setHidden:true];
	[nameTextField setHidden:true];
	[newItemBtn setHidden:true];
	[saveItemBtn setHidden:true];
	[cancelItem setHidden:true];
	[cancelCateg setHidden:true];

	
	tableViewCateg = [[UITableView alloc] initWithFrame:CGRectMake(121, 400, 200, 200)
				  //					  
											  style:UITableViewStylePlain];
	
    tableViewCateg.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	
    tableViewCateg.delegate = self;
	
    tableViewCateg.dataSource = self;
	
    //[tableView reloadData];
	
	
 	
    [self.view addSubview: tableViewCateg];
	
	[tableViewCateg release];
	
	
	//table Item
	tableViewItem = [[UITableView alloc] initWithFrame:CGRectMake(471, 400, 200, 200)
				  //					  
											  style:UITableViewStylePlain];
	
    tableViewItem.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	
    tableViewItem.delegate = self;
	
    tableViewItem.dataSource = self;
	
    //[tableView reloadData];
	
	[self.view addSubview: tableViewItem];
	
	[tableViewItem release];
	
	
	
	[nameTextField becomeFirstResponder];

	
	if (context == nil)  //ojo, el salva patria!! que mierda!!! hasta ahora jode y este lo alivia!!!!
	{  //sera como el inicio del unique key????
        context = [(CoreDataMssterAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
        NSLog(@"After managedObjectContext: %@",  context);
	}
	
	if (managedObjectContext == nil)  //ojo, el salva patria!! que mierda!!! hasta ahora jode y este lo alivia!!!!
	{  //sera como el inicio del unique key????
        managedObjectContext = [(CoreDataMssterAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
        //NSLog(@"After managedObjectContext: %@",  context);
	}
	
	
	
	[self fetchRecordsCateg];
	
	[self fetchRecordsItem];
	
    [super viewDidLoad];
}



#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
	//	NSLog(@"numberOfSectionIntableView");
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	
	if(tableView == tableViewCateg)
	{
		return [CateglistArray count];
	}
	
	if (tableView == tableViewItem) {
		 
		//return [ItemlistArray count];
		return [entityArray count];

		//return 2;

		
	}
	/*
	
	if (tableView == tableView3) {
		return [WlistArray count];
		
	}*/
	return 0;
	//return 2;
}
/*
 - (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
 
 Contacts *info = [listArray objectAtIndex:indexPath.row];
 cell.textLabel.text = info.c_name;
 NSLog(@"info.name %@", info.c_name);
 }*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
    }
	
    // Configure the cell...
   
	
	
	if (tableView == tableViewCateg) {
		
		
		categ *info = [CateglistArray objectAtIndex:indexPath.row];
		cell.textLabel.text = info.categ_name;
		
	}
	
	if (tableView == tableViewItem) {
		Entity *info2 = [entityArray objectAtIndex:indexPath.row];
		cell.textLabel.text = info2.item;
		//cell.textLabel.text = @"papus";

	}
	
	
	 
    return cell;
	
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"didSelectRowAtIndexpath");
	
	
	 if(indexPath.row == 0)
	 {
	 NSLog(@"undio");
	 }
	 
	
	if (tableView == tableViewCateg) {
		
		
		
		//CategRef = objectAtIndex
		 
		//categ *info = [CateglistArray objectAtIndex:indexPath.row];
		categ_ = [CateglistArray objectAtIndex:indexPath.row];

		
		CategRef = categ_.categ_name; //asi se llama mi salida nueva categ
		
		NSLog(@"la vateg %@", CategRef);
		
		
		//
				 	 
 
		NSLog(@" la categ :%@", categ_);
		//[self saveDataAction];
		

		
		[self fetchRecordsItem];
		[tableViewItem reloadData];
		 
	
		[newItemBtn setHidden:false];

	}
	
	if (tableView ==tableViewItem) {
		    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
	}
	 
	
	
}



// Handle deletion/insertion requests

- (void) tableView:(UITableView *) tableView
commitEditingStyle:(UITableViewCellEditingStyle) editingStyle
 forRowAtIndexPath:(NSIndexPath *) indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
 		
		
		if (tableView == tableViewCateg) {
			
			 NSManagedObject *eventToDelete = [CateglistArray objectAtIndex:indexPath.row];
			 [context deleteObject:eventToDelete];
			 
			 [CateglistArray removeObjectAtIndex:indexPath.row];
			 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
			 
					}
			
		
		 		}
		
	
			
	
	NSError *error;
	if (! [context save:&error]) {
		NSLog(@"ERROR_%@",[error localizedDescription]);
		// handle error
		
		
			
	}
	
	categ_ = nil;
	[self fetchRecordsItem];
	[tableViewItem reloadData];


}

-(IBAction) saveCateg:(id) sender
{
	[self save];
}

- (void)save {
	
	NSManagedObject *newCateg;
	newCateg = [NSEntityDescription insertNewObjectForEntityForName:@"categ" inManagedObjectContext:context];
	
	[newCateg setValue:nameTextField.text forKey:@"categ_name"];
	//categ_.categ_name = nameTextField.text;
	
//NSLog(@"%@",categ_.categ_name);
	
	//NSError *error = nil;
	NSError *error;
	[context save:&error];
	NSLog(@"Contact saved");
	  
	[self fetchRecordsCateg];
	
	[tableViewCateg reloadData];
	
	nameTextField.text = @"";
 
	
}

-(void) fetchRecordsCateg{
	context = [(CoreDataMssterAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
	
	//define our table/entity to use,, hahha not apropiatelsy
	NSEntityDescription *entity =[NSEntityDescription entityForName:@"categ" inManagedObjectContext:context];
	
	//setup the fetch request
	NSFetchRequest *request = [[ NSFetchRequest alloc] init];
	[request setEntity:entity];
	
	//define how we will sort the records
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"categ_name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
	NSArray *sortDescriptors=[NSArray arrayWithObject:sortDescriptor];
	
	[request setSortDescriptors:sortDescriptors];
	//[sortDescriptor release];
	
	//fetch the records and handle an error
	NSError *error;
	NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request  error:&error] mutableCopy];
	
	NSLog(@"count array fR = %i",[mutableFetchResults count]);
	
	if (!mutableFetchResults) {  
        // Handle the error.  
        // This is a serious error and should advise the user to restart the application  
    }   
	
	
	
	[self setCateglistArray:mutableFetchResults];
	
	
	 
	NSLog(@"cuenta x: %d",[CateglistArray count]);
	
	[mutableFetchResults release];  
    [request release];  
}

-(void) fetchRecordsItem{
	//ahora la busqueda!
	//NSManagedObject *selectedObject = [CateglistArray objectAtIndex:indexPath.row];

	managedObjectContext = [(CoreDataMssterAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 

	//define our table/entity to use,, hahha not apropiatelsy
	NSEntityDescription *entity =[NSEntityDescription entityForName:@"Entity" inManagedObjectContext:managedObjectContext];
	
	
	//categ_ = [CateglistArray objectAtIndex:indexPath.row];
	NSManagedObject *selectedObject = categ_ ; //aqui decirle que index!!

	NSPredicate *predicate;

	
	 	predicate = [NSPredicate predicateWithFormat:@"(EntityToCateg == %@)", selectedObject]; //ojo primera pista de busqueda!! fufff 

 
	

	
	NSFetchRequest *request = [[ NSFetchRequest alloc] init];
	[request setEntity:entity];
	[request setPredicate: predicate]; //
	//define how we will sort the records
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"item" ascending:YES selector:@selector(caseInsensitiveCompare:)];
	NSArray *sortDescriptors=[NSArray arrayWithObject:sortDescriptor];
	
	[request setSortDescriptors:sortDescriptors];
	//[sortDescriptor release];
	
	//fetch the records and handle an error
	NSError *error;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request  error:&error] mutableCopy];
	
	NSLog(@"counta rraq3 = %i",[mutableFetchResults count]);
	
	if (!mutableFetchResults) {  
        // Handle the error.  
        // This is a serious error and should advise the user to restart the application  
    }   
	
    // Save our fetched data to an array  
    
	[self setEntityArray:mutableFetchResults];
	
	
	[mutableFetchResults release];  
    [request release];  
	
	NSLog(@"fetch interest conteo %d",[entityArray count]);
	 
	
}

-(IBAction) saveItem:(id) sender {
	
	NSManagedObject *newItem;
	NSManagedObjectContext *contextCateg = [categ_ managedObjectContext];
	
	NSLog(@"el contexto :%@",contextCateg);

			newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:contextCateg];
 
	[categ_ addCategToEntityObject:newItem]; //vooddoo! un mensaje del mas alla!

	//[categ_ addCategToEntityObject:newItem]; //vooddoo! un mensaje del mas alla! //arreglar!!

 	
	[newItem setValue:ItemTextField.text forKey:@"item"];
 	
 	
 	NSError *error;
	[context save:&error];
	
	ItemTextField.text = @"";
	
	NSLog(@"ITEM saved");
	
	[self fetchRecordsItem];
	[ tableViewItem reloadData];
	
	[ItemTextField setHidden:true];

}

-(IBAction) appearSaveCateg {
  	[newCategBtn setHidden:true];
	[saveCategBtn setHidden:false];
	[nameTextField setHidden:false];
	[cancelCateg setHidden:false];
	
	[ItemTextField setHidden:true];
	[saveItemBtn setHidden:true];
	[cancelItem setHidden:true];
	[newItemBtn setHidden:false];
	
	
	
}
-(IBAction) appearSaveItem{
 	[ItemTextField setHidden:false];
	[ItemTextField setHidden:false];
	[saveItemBtn setHidden:false];

}

-(IBAction) newItem:(id) sender{
	[newItemBtn setHidden:true];
	[ItemTextField setHidden:false];
	[saveItemBtn setHidden:false];
	[cancelItem setHidden:false];
	
	[nameTextField setHidden:true];
	[saveCategBtn setHidden:true];
	[newCategBtn setHidden:false];
	[cancelCateg setHidden:true];
		
}

- (IBAction) cancelCategAc{
	[nameTextField setHidden:true];
	[saveCategBtn setHidden:true];
	[newCategBtn setHidden:false];
	[cancelCateg setHidden:true];

}
-(IBAction) cancelItemAc{
	[ItemTextField setHidden:true];
	[saveItemBtn setHidden:true];
	[cancelItem setHidden:true];
	[newItemBtn setHidden:false];
	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	
	self.nameTextField = nil;

    [super viewDidUnload];
	
	//ojo, tengo que soltar subviews de la main view@!!!
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//responsable for the keyboard saving!
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == nameTextField) {
		[nameTextField resignFirstResponder];
		[self save];
	}
	return YES;
}


- (void)dealloc {
    [super dealloc];
}


@end
