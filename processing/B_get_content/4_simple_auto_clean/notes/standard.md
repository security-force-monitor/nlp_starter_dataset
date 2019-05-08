# What do we keep and remove from article text?

Formatting:

 - plain text with no tagging
 - single line breaks between paragraphs
 - remove trailing and consecutive spacing
 - remove empty lines or lines with just spaces
 - asterisks for lists
 - characters escaped by html2text during the conversion process (brackets, etc)
 - things that were clearly captions

Keep:

 - article title in first line
 - content paragraphs
 - lists
 - sub-headings inside article

Remove:

 - bylines and authorship information, at head and in footers
 - datelines and timestamps
 - summary matter at top of article
 - any emphasis (italics, bold, strikethrough)
