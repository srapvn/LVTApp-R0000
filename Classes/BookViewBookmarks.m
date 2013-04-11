//
//  BookViewBookmarks.m
//  BookViewer
//
//  Created by Khanh Nguyen on 7/28/10.
//  Copyright 2010 KAIST. All rights reserved.
//

#import "BookViewBookmarks.h"


@implementation BookViewBookmarks


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

		
	//NSLog(@"%d",[bookmarkArray count]);
//	[bookmarkArray retain];
	//[positionarray retain];
	
	/*
	float sizefont = [[positionarray objectAtIndex:2] floatValue];
	positionSized.x = [[positionarray objectAtIndex:0] intValue]*currentfont.pointSize/sizefont;
	positionSized.y = [[positionarray objectAtIndex:1] intValue]*currentfont.pointSize/sizefont;
	
	[TextChapter setContentOffset:positionSized animated:YES];
	*/
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItems;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.navigationController.navigationBar.hidden = FALSE;
	
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"list" ofType:@"dat"];
	NSString *file = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	ListChapter = [file componentsSeparatedByString:@"\n"];
	[ListChapter retain];
	
	
	//UIFont *currentfont = TextChapter.font;
	//if (bookfont.pointSize == 0) bookfont = currentfont;
	CGPoint positionSized;
	
	NSArray *positionarray;
	
	//	[bookmarkArray initWithCapacity:2];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *keychapter;
	
	int chapterid;
	int i = 0;
	for (chapterid = 1; chapterid < [ListChapter count]; chapterid++) {
		
		keychapter = [NSString stringWithFormat:@"%d",chapterid];
		positionarray = [prefs objectForKey:keychapter];
		
		if (positionarray != nil) 	{
			
			
			//[positionarray retain];
			bmArray[i++] = chapterid;
			
			//[bookmarkArray addObject:[[NSNumber numberWithInteger:chapterid] retain]];
			//NSLog(@"%d",[[bookmarkArray lastObject] intValue]);
			//NSLog(@"%d",bmArray[i-1]);
		}
	}
	
	numberofBM = i;

	[self.tableView reloadData];
	
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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return numberofBM;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *keychapter;
	
	keychapter = [ListChapter objectAtIndex:bmArray[indexPath.row]];
	//positionarray = [prefs objectForKey:keychapter];
		
	//[cell setText:[[ListChapter objectAtIndex:indexPath.row] retain]];
	[cell setText:keychapter];
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
	//cell.textColor = [UIColor whiteColor];
	cell.textLabel.font = font;
	
	//[cell setBackgroundColor: [UIColor viewFlipsideBackgroundColor]];
	//[cell setFontCo: [UIColor blackColor]];
	
    return cell;
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
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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


#pragma mark -
#pragma mark Table view delegate

// TODO: Selection of Row
// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	int i;
	//NSMutableArray *chapter = [[NSMutableArray alloc] init];
	BookViewChapter1 *chapter;
	//khong dc autorelease
	
	
	chapter = [[BookViewChapter1 alloc] initWithNibName:@"BookViewChapter1" bundle:nil];
	[chapter setTitle:[ListChapter objectAtIndex:bmArray[indexPath.row]]];
	[[chapter view] setChapterid:bmArray[indexPath.row]];
	[[chapter view] setNoChapter:[ListChapter count]];
	NSString *name = [NSString stringWithFormat:@"%d",bmArray[indexPath.row]];
	NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"dat"];
	//[path retain];
	//NSLog(name);
	[[chapter view] setFile:path];
	[chapter setListChapter:ListChapter];
	[[chapter view] willRestoreMark];
	
	[self.navigationController pushViewController:chapter animated:YES];
	
			
			//[[chapter objectAtIndex:i-2] autorelease];
	
	// Navigation logic may go here -- for example, create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController animated:YES];
	// [anotherViewController release];
	
}



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

