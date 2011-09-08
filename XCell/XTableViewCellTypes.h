/////////////////////////////////////////////////////
//
//  XTableViewCellTypes.h
//  XCell
//
//  Created by Andrew Zimmer on 9/7/11.
//  Copyright (c) 2011 Andrew Zimmer. All rights reserved.
//
/////////////////////////////////////////////////////

/////////////////////////////////////////////////////
// Update the enum to add new types of cells to your overrides.
/////////////////////////////////////////////////////

#ifndef XCell_XTableViewCellTypes_h
#define XCell_XTableViewCellTypes_h

//Cell Types
typedef enum {
    XCELL_STANDARD,  // Standard Cell Style DEFAULT
    XCELL_SETTINGS,  // Standard Cell Value1
    XCELL_CONTACTS,  // Standard Cell Value2
    XCELL_SUBTITLE,  // Standard Cell Subtitle
    XCELL_STANDARD_WITH_WRAPPING,
    XCELL_TITLE_CONTENT,
    XCELL_TITLE_CONTENT_WITH_WRAPPING,
    XCELL_EDITABLE_TEXT,
    XCELL_EDITABLE_TEXT_WITH_TITLE,
    
    //Override Values (add values here for new cell types if you'd like)
    XCELL_OVERRIDE_TWITTER
}XTableViewCellStyle;

//Change these defaults to affect every cell in your project.
#define DEFAULT_HORIZONTAL_PADDING 20
#define DEFAULT_VERTICAL_PADDING 10
#define DEFAULT_MINIMUM_HEIGHT 44

#define DEFAULT_TITLE_FONT [UIFont boldSystemFontOfSize:17]
#define DEFAULT_TITLE_ALIGNMENT UITextAlignmentLeft
#define DEFAULT_TITLE_COLOR [UIColor colorWithRed:.07f green:.07f blue:.07f alpha:1]

#define DEFAULT_CONTENT_FONT [UIFont systemFontOfSize:14]
#define DEFAULT_CONTENT_ALIGNMENT UITextAlignmentLeft
#define DEFAULT_CONTENT_COLOR [UIColor colorWithRed:.66f green:.66f blue:.66f alpha:1]

#define DEFAULT_BACKGROUND_COLOR [UIColor whiteColor]
//

#endif
