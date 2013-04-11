#import "ViewChapter1.h"

@implementation ViewChapter1

@synthesize delegate;

- (void) setdelegate:(id) delegateitem {
	delegate = delegateitem;
}

- (void) setText:(NSString*) Text {
	TextChapter.text = Text;
}

- (void) setChapterid:(int) cid {
	chapterid = cid;
}
- (void) setNoChapter:(int) cid {
	noChapter = cid;
}


- (void) setFile:(NSString*) Text {
	NSString *filepath = Text;
	NSString *file;
	//Get file into string
	file = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
	TextChapter.text = file;
	//Chay len dau trang sau khi delay se giup khong bi. chay xuong cuoi trang neu co' selection
	[self performSelector:@selector(Gotothefirstline) withObject:nil afterDelay:0.2];
}
-(void)Gotothefirstline{
	CGPoint a; a.x = 0; a.y = 0;
	[TextChapter setContentOffset:a animated:NO];
}

	- (IBAction)NextChapter {
		
		//[window setTitle:[ListChapter objectAtIndex:i]];
		
		if (chapterid < noChapter - 1) {
			chapterid++;
			int i = chapterid;
			NSString *name = [NSString stringWithFormat:@"%d",i];
			NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"dat"];
			[path retain];
			//NSLog(path);
			[self setFile:path];
		
			//Change title cho chapter
			[self.delegate changeTitle:chapterid];	
			
			[path release];
		
		}
		//[self.navigationalControlller setViewControllers:chapter animated:YES];
		//[ pushViewController:chapter animated:YES];
		
	}
	
	
	- (IBAction)PreviousChapter{
	
		NSString *path;
		//[window setTitle:[ListChapter objectAtIndex:i]];
		
		if (chapterid > 1) {
			chapterid--;
			int i = chapterid;
			NSString *name = [NSString stringWithFormat:@"%d",i];
			path = [[NSBundle mainBundle] pathForResource:name ofType:@"dat"];
			[path retain];
			//NSLog(path);
			[self setFile:path];
			
			//Change title cho chapter
			[self.delegate changeTitle:chapterid];	
			
			[path release];

		}
	
	}

	- (IBAction)FontPlus {
	
		fontsize = TextChapter.font.pointSize;
		fontsize = fontsize + 1;
		if (fontsize > 40) fontsize = 40;
	
		UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontsize];
		[TextChapter setFont:font];
		
	}
	- (IBAction)FontMinus {
	
		fontsize = TextChapter.font.pointSize;
		fontsize = fontsize - 1;
		if (fontsize < 6) fontsize = 6;
	
		UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontsize];
		[TextChapter setFont:font];
	
	}

	- (IBAction)BookMark {
		position = TextChapter.contentOffset;
		bookfont = TextChapter.font;
		
		
		NSArray *positionarray = [NSArray arrayWithObjects:[NSNumber numberWithFloat:position.x],[NSNumber numberWithFloat:position.y],[NSNumber numberWithFloat:bookfont.pointSize],nil];
		
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		NSString *keychapter = [NSString stringWithFormat:@"%d",chapterid];
		
		NSLog(@"%f %f %f",position.x,position.y,bookfont.pointSize);
		/*
		CGPoint positionSized;
		positionSized.y = [[positionarray objectAtIndex:1] intValue];
		
		if (positionSized.y == 0)
			[prefs setObject:nil forKey:keychapter];
		else 
			
		*/	
		[prefs setObject:positionarray forKey:keychapter];
	
		/* // Cach dung cu writetoFile cua NSArray plist
		NSString *path;
		//Write to files
		//NSNumber *positionarray = [[NSNumber numberWithFloat:position.x] retain];
		NSArray *positionarray = [NSArray arrayWithObjects:[NSNumber numberWithFloat:position.x],[NSNumber numberWithInt:position.y],[NSNumber numberWithFloat:bookfont.pointSize],nil];
		[positionarray retain];
		NSString *name = [NSString stringWithFormat:@"%d",chapterid];
		path = [[[NSBundle mainBundle] pathForResource:name ofType:@"plist"] retain];
		NSLog(path);
		//NSLog(name);
		//NSLog(@"982u3riojsadkflj");
		
		//[self writeApplicationPlist:positionarray toFile:path];
		BOOL test = [positionarray writeToFile:path atomically:YES];
		//NSLog(@"%d",test);
		//[path release];
	    //[positionarray release];
		//
		 */
	}

	// TODO: Tao ra bookmark position
	
	- (IBAction)RestoreMark {
		//CGRect r = CGRectMake(position.x, position.y, TextChapter.contentSize.width,  TextChapter.contentSize.height);
		
		UIFont *currentfont = TextChapter.font;
		//if (bookfont.pointSize == 0) bookfont = currentfont;
		CGPoint positionSized;
		
		//positionSized.x = position.x*currentfont.pointSize/bookfont.pointSize;
		//positionSized.y = position.y*currentfont.pointSize/bookfont.pointSize;

		/* //Cach dung cu bang writetofile cua NSArray plist
		NSArray *positionarray;
		NSString *name = [NSString stringWithFormat:@"%d",chapterid];
		NSString *path = [[[NSBundle mainBundle] pathForResource:name ofType:@"plist"] retain];
		positionarray = [NSArray arrayWithContentsOfFile:path];
		*/
		
		NSArray *positionarray;
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		NSString *keychapter = [NSString stringWithFormat:@"%d",chapterid];
		positionarray = [prefs objectForKey:keychapter];
		
		if (positionarray == nil) return;
		
		//[positionarray retain];
		
		float sizefont = [[positionarray objectAtIndex:2] floatValue];
		positionSized.x = [[positionarray objectAtIndex:0] floatValue]*currentfont.pointSize/sizefont;
		positionSized.y = [[positionarray objectAtIndex:1] floatValue]*currentfont.pointSize/sizefont;
		
		[TextChapter setContentOffset:positionSized animated:YES];
		
		NSLog(@"%f %f",positionSized.x, positionSized.y);
		//[prefs release];
		//[keychapter release];
		//[positionarray release];
		
		//[TextChapter setFont:bookfont];
		//[TextChapter setFont:currentfont];

	}
- (IBAction)DelMark {
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *keychapter = [NSString stringWithFormat:@"%d",chapterid];
	
	[prefs setObject:nil forKey:keychapter];

}
- (void)willRestoreMark {
	
	flagRestoreMark = TRUE;
	
}

- (void)willRestoreLastReading {
	
	flagRestoreLastReading = TRUE;
	
}

-(void)doTHis{
	//////some code
}

- (void)checkRestoreMark {
	
	if (flagRestoreMark == TRUE) {
		//[self RestoreMark];
		
		//Doi thoi gian cho no restore xong
		[self performSelector:@selector(RestoreMark) withObject:nil afterDelay:0.2];

		flagRestoreMark = FALSE;
	}
	else if (flagRestoreLastReading == TRUE) {
		//[self restoreLastReading];
		
		//Doi thoi gian cho no restore xong
		[self performSelector:@selector(restoreLastReading) withObject:nil afterDelay:0.2];
		
		flagRestoreLastReading = FALSE;
	}
	
}

- (void)scrollViewDidEndDecelerating:(UITextView *)scrollView {

	position = TextChapter.contentOffset;
	bookfont = TextChapter.font;
	
	NSArray *positionarray = [NSArray arrayWithObjects:[NSNumber numberWithFloat:position.x],[NSNumber numberWithFloat:position.y],[NSNumber numberWithFloat:bookfont.pointSize],nil];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *keychapter = [NSString stringWithFormat:@"LastReadingChapter"];
	
	[prefs setObject:[NSNumber numberWithInt:chapterid]  forKey:keychapter];
	
	keychapter = [NSString stringWithFormat:@"LastReadingBookmark"];
	
	[prefs setObject:positionarray  forKey:keychapter];
	
	//NSLog(@"SDKFJ");
	
}

- (void)scrollViewDidEndDragging:(UITextView *)scrollView willDecelerate:(BOOL)decelerate {
	
	position = TextChapter.contentOffset;
	bookfont = TextChapter.font;
	
	NSArray *positionarray = [NSArray arrayWithObjects:[NSNumber numberWithFloat:position.x],[NSNumber numberWithFloat:position.y],[NSNumber numberWithFloat:bookfont.pointSize],nil];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *keychapter = [NSString stringWithFormat:@"LastReadingChapter"];
	
	[prefs setObject:[NSNumber numberWithInt:chapterid]  forKey:keychapter];
	
	keychapter = [NSString stringWithFormat:@"LastReadingBookmark"];
	
	[prefs setObject:positionarray  forKey:keychapter];
	
	//NSLog(@"SDKFJ");
	
}

- (void)restoreLastReading {
	
	UIFont *currentfont = TextChapter.font;
	//if (bookfont.pointSize == 0) bookfont = currentfont;
	CGPoint positionSized;
	
	NSArray *positionarray;
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *keychapter = [NSString stringWithFormat:@"LastReadingBookmark"];
	positionarray = [prefs objectForKey:keychapter];
	
	if (positionarray == nil) return;
	
	//[positionarray retain];
	
	float sizefont = [[positionarray objectAtIndex:2] floatValue];
	positionSized.x = [[positionarray objectAtIndex:0] floatValue]*currentfont.pointSize/sizefont;
	positionSized.y = [[positionarray objectAtIndex:1] floatValue]*currentfont.pointSize/sizefont;
	
	[TextChapter setContentOffset:positionSized animated:YES];
	
}
	 
/* // Viet data vao Plists
- (BOOL)writeApplicationPlist:(id)plist toFile:(NSString *)fileName {
	NSString *error;
	NSData *pData = [NSPropertyListSerialization dataFromPropertyList:plist format:NSPropertyListBinaryFormat_v1_0 errorDescription:&error];
	if (!pData) {
		NSLog(@"%@", error);
		return NO;
	}
	return ([self writeApplicationData:pData toFile:(NSString *)fileName]);
}

// Doc data tu Plist
- (id)applicationPlistFromFile:(NSString *)fileName {
	NSData *retData;
	NSString *error;
	id retPlist;
	NSPropertyListFormat format;
	
	retData = [self applicationDataFromFile:fileName];
	if (!retData) {
		NSLog(@"Data file not returned.");
		return nil;
	}
	retPlist = [NSPropertyListSerialization propertyListFromData:retData  mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&error];
	if (!retPlist){
		NSLog(@"Plist not returned, error: %@", error);
	}
	return retPlist;
} */

@end
