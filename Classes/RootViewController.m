
#import "RootViewController.h"

@implementation RootViewController

/* + (id) PopBack {
	[self.navigationController popNavigationItemAnimated:YES];
} */

// TODO: Them table
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//ListChapter = [[NSMutableArray alloc] init];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"list" ofType:@"dat"];
	NSString *file = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	ListChapter = [file componentsSeparatedByString:@"\n"];
	[ListChapter retain];
	
	[self setTitle:@"Menu"];
	
	chapter0 = [[BookViewChapter0 alloc] initWithNibName:@"BookViewChapter0" bundle:nil];
	[chapter0 setTitle:@"Home"];
	[self.navigationController pushViewController:chapter0 animated:YES];
	[chapter0 autorelease];
	
	//self.navigationController.navigationBar.hidden = TRUE;
	self.navigationController.navigationBar.barStyle = 1;

	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.navigationController.navigationBar.hidden = TRUE;
	
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
	ListChapter = nil;
	chapter0 = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// TODO: Them row count cua List Chapter
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	//Set height cho moi row
	[tableView setRowHeight:40];
   // [tableView contentView contentView.backgroundColor = [UIColor greenColor];
	
	tableView.backgroundColor = [UIColor blackColor];
	
	return [ListChapter count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//	return 40; }

// TODO: Them setText 
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	
	// Configure the cell.
	[cell setText:[[ListChapter objectAtIndex:indexPath.row] retain]];
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
	cell.textColor = [UIColor whiteColor];
	cell.textLabel.font = font;
	
	[cell setBackgroundColor: [UIColor viewFlipsideBackgroundColor]];
	//[cell setFontCo: [UIColor blackColor]];
	
    return cell;
}



// TODO: Selection of Row
// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([[ListChapter objectAtIndex:indexPath.row] isEqual:@"Home"])
	{
		chapter0 = [[BookViewChapter0 alloc] initWithNibName:@"BookViewChapter0" bundle:nil];
		[chapter0 setTitle:@"Home"];
		[self.navigationController pushViewController:chapter0 animated:YES];
		[chapter0 autorelease];
	}
		
	int i;
	//NSMutableArray *chapter = [[NSMutableArray alloc] init];
	BookViewChapter1 *chapter;
	//khong dc autorelease
	for (i=1; i<[ListChapter count]; i++) {
	if ([[ListChapter objectAtIndex:indexPath.row] isEqual:[ListChapter objectAtIndex:i]])
	{
		
		chapter = [[BookViewChapter1 alloc] initWithNibName:@"BookViewChapter1" bundle:nil];
		[chapter setTitle:[ListChapter objectAtIndex:i]];
		[[chapter view] setChapterid:i];
		[[chapter view] setNoChapter:[ListChapter count]];
		NSString *name = [NSString stringWithFormat:@"%d",i];
		NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"dat"];
		//[path retain];
		//NSLog(name);
		[[chapter view] setFile:path];
		[chapter setListChapter:ListChapter];
		
		[self.navigationController pushViewController:chapter animated:YES];
		
		
		//[[chapter objectAtIndex:i-2] autorelease];
	}		
	}
	 
	// Navigation logic may go here -- for example, create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController animated:YES];
	// [anotherViewController release];
	
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
	[ListChapter release];
	[chapter0 release];
}


@end

