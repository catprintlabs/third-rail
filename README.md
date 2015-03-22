third-rail
==========

##voltrb on rails

The goal is to provide access to voltrb from within existing rails apps via addition of a third-rail gem.

Any thoughts or discussion is welcome at https://gitter.im/catprintlabs/third-rail


##Initial thoughts (sort of stream of conscience random ideas)

rails and volt will coexist with volt being a separate rack app.  Communication between the two will be via mongodb.

add mongoid or mongomapper to active record models ala https://github.com/hayesdavis/active-expando (very old but provides a starting point)  similar concept here: http://britg.com/2012/01/07/forging-forgecraft-a-hybrid-sql-mongodb-data-solution/

this should provide the basic communication mechanism.

##syncing the two databases

###Brute Force:
Syncronize every change between the databases using activerecord and mongos builtin monitoring...

###More Intelligent - but more work:
Describe mapping in the active record models to volt models 

###Harder still - but probably how you would do it from scratch:
Map volt models to rails, and manually connect

###Forget Mongo + Rails...  
use an automatically generated API to talk between the volt app and rails.

##Different Approach altogether

think of a typical migration.  You have some pages that are rails views, but you want to start using volt.
What you would like initially is something like this:
* request the page, 
* controller does normal stuff
* then makes sure that any "volt" models are synced to the rails data.
* then does a "special" render operation that hands control over to volt, which delivers the page
