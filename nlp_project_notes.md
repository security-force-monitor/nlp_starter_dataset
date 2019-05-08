# NLP Project

tom@securityforcemonitor.org / May 2019

Forgive scrappy documentation please!


## Overview

Aim of this project is to create a simple starter dataset for SFM's NLP work. We will take a sub-set of our data on persons, go back to the sources that underpin it, and ensure the datapoints are identified within the plain text of those sources.


## Set up phase

### BRAT Rapid Annotation Tool

#### Getting BRAT up and running

Setting up BRAT is a little tedious. You'll need to establish a virtual environment using python 2.5.x. Then you'll need to uninstall the "filelock" module from within that, as this appears to create a number of deployment problems. Firstly deploy standalone  -we'll figure out how to set up a proper production environment with Apache at a later point. Deploy to a different port on localhost as my `~:8001` seems to be used by somthing. You can do this by running `python standalone.py 5040` to run it on port 5040. 

The corpus will be stored in the `~/data` directory, and BRAT takes this as a path from which it shows you the list of possible projects to work on. Each coporus will need an `annotation.conf` file, where we define the various entities, events, attributes and so on. The advanced config page of the BRAT manual is pretty good, and helps you deal with things like overlaps as well as all the usual stuff to do with defining relations.

### Developing a corpus

The approach I am taking is to identify sources in the Nigeria data that have been used to identify a full set of biographical information about a person (rank, role, title, orgorganization) as this will enrich the value of each. To do this we can:

 * Pull out all the unique sources from the person data on Nigeria
 * Iterate across each source to check if there is a match in each of the four columns we are looking for.
 * If there is, pull down the HTML and grab the plain text
 * Use it to seed the annotation model

### Corpora encoding

The sources available to us are mostly news stories, which have a simple structure. There are numerous ways to encode the corpora, the most comprehensive of which is documented in the guidance of the `Text Encoding Initiative (TEI)`. This is a standardized markup language specifically for language data, and it's... heavy. The issue we face at the early stages of this project is whether or not to invest in this level of encoding, or go for something simple initially. My sense is that because our annotation tool (BRAT) requires ASCII or UTF-8 plain text, and does not strip out the tags added for encoding, that we should initially go for a simple approach. 
 
 * Create a plain text of the article content
  * Probably a two step process, first removing leading and trailing content we don't need, and then cleaning up the text further
  * The end result should just be the title and the body of the article, as we have all the other metdata in the master source list
 * Create some metadata sets that can be linked to it by UUID
  * Simple metadata files has been created. We can join this with the body text, and choose and encoding approach as needed.

Package will contain:
 * The plain text of the article
 * Article metadta
 * The values we are looking for in each source

## Specific problems

### Non break space

Ugh. Within these quotes is nbsp that you can grab to regex out from the text:"    "

## Observations from tagging
 * Easy to select a large amount of text and then tag it,but difficult to get rid of it, because the popover is expanded outside the screen range. Answer is to go into the .ann file and remove the annotation directly, or to zoom out the webpage until you can see the control buttons and delete it through the interface. These options would be tricky for a non-tech. 
 * Sometimes BRAT's linking interface stops working, but a page refresh fixes it (without losing anything)
 * Include the location of a unit in the entity? e.g. `81 Division, Lagos`
 * Interesting referencing stuff like "just like his counterpart in" (17a7a0b4-17d8-47bf-9a00-c2c1c99c5685) 
 * How do we define whether a unit is a police or military one?
 * Do we include aliases and internal references to the same person in hte same article e.g. when the person is named, and then is referenced with "he" or "the GOC"
 * Ambiguities in organizatio naming "Maj Gen Joseph Shoboiki, formerly GOC, Kaduna"
 * Dealing with transitions - often a person's current and next position are named. Do we need to indicate `was_posted` as well as `is_posted`? Possibly, do we want the alg to predict which is the current role, and what the transition is? Source `17a7a0b4-17d8-47bf-9a00-c2c1c99c5685` is a perfect example of this problem. Source `1bc14945-bb31-4975-bcd1-fdbf52baea16` highlights another retirement.
 * Ethics issue: using material that describes soldiers being killed (e.g. `1cd668a8-d49e-4036-a376-d5ebca3c4f80`)
 * Referencing of previoulsy mentioned person, but using their rank and surname e.g. in `20964bcf-51b2-4a03-9ea0-c514d4662918`. Also "GOC 7 division" (47a1f85c-73b4-47f1-a6b5-1e82f3da010f)
 * What to tag when we don't have a complete set of entities? Orgs, persons, titles... on their own?
 * What to do where we have an operation name in which "operation" is not in the title e.g. "operation code named 'Sharan Daji'" (259b700f-fd2c-422c-85e0-e5011a25c06a)
 * plurals: "82 and 2 Divisions" (2f65f578-59d2-4b4f-8ae4-920927e7e598), "Commissioners of Police AKwa Ibom and Cross Rivers States Mr. Don Awunah and Mohammed Hafiz" (431d003c-096b-4bd1-b02b-e4676519d2d4), "Commissioners of Police from both states, Mr. Titus Lamorde and Hafiz Mohammed" (47392e3d-3c5f-4610-b2ec-173a0c29cce8), "Some affected commands are the General Officers Commanding 1, 2, 3, 81 and 82 Divisions, Operations Pulo Shield and Safe Haven of Niger Delta and Plateau States respectively" (a78c84f2-bd87-40fb-8a16-2d5727462f6c)
 * Tag abbreviations and link them as aliases?
