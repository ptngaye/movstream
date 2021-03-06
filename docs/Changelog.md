# Changelog #

> The changelog has a description of all changes made in the different updates.

### Version 1.1.14 ###

* Webshim js files v.1.14.2 added locally, since the latest version (v. 1.14.3) was causing problems with subtitles

### Version 1.1.13 ###

* Full Screen player added

### Version 1.1.12 ###

* Christmas design added. This design is only active during christmas time 1. of December to 31. of December.

### Version 1.1.11 ###

* Issue of manage movies on admin page is loading page very slow, has been resolved. It seems that some, not used JS files, was trying to be loaded. It also seems that the table sort javascript event was slowing down the page load, when many movies was attached to the table which could be sorted.
* Removed sort table functionality, due to effeciency of bad page load.

### Version 1.1.10 ###

* Favicon added to the website.

### Version 1.1.9 ###

* Movies can now be searched from the home view.

### Version 1.1.8 ###

* Genre link is now availible to be clicked when viewing the popover description of a movie.

### Version 1.1.7 ###

* Go to top og page button added

### Version 1.1.6 ###

* No image placehold picture has been added, instead of using http://placehold.it/200x160

### Version 1.1.5 ###

* Hotfix created to fix the problem with thumbnails not aligning correct when those above have longer movie names

### Version 1.1.4 ###

* Hotfix created to ensure the a maximum length has been added to the movie title input field, so the title doesn't exceed the maximum characters

### Version 1.1.3 ###

* Hotfix created due to subtitles which overlapped each other especially in fullscreen mode.

### Version 1.1.2 ###

* Video JS has been replaced by another video player, due to problems when pausing video.

### Version 1.1.1 ###

* Subtitle text size modified, to a bigger size.

### Version 1.1.0 ###

Hotfixes from version 1.0.1 has been included in this update.

* Video player has got a dynamic width of 100% of it's container
* Movie titles below the movie image thumbnail has been set with a fixed width of 160 pixel, and has been forced to be word wrapped
* Tables is not viewable when no movies, genres or seasons has been created at all in the admin pages
* Changed session timeout, so user sessions during log in, timeout after 180 minutes (3 hours).

### Version 1.0.1 ###

* background on subtitles text track removed