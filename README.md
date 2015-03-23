third-rail
==========

##voltrb on rails

The goal is to provide access to voltrb from within existing rails apps via addition of a third-rail gem.

Any thoughts or discussion is welcome at [![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/catprintlabs/third-rail?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)


##install

Currently this repo is just a demo rails app, then pulls in a modified version of volt.
Clone the repo,
bundle install
bundle exec rails s

The app should come up...  let me know via gitter if you have any problems.

##implementation status:

So far the only thing implemented is the being able to use volt to create a layout within the rails app, and to have volt request a partial be delivered as part of the volt view.  This is _very preliminary proof of concept implementation_.

Volt code goes into a directory called "voltage" within the top level rails "app" directory.

The volt code follows the normal volt framework conventions, within that directory, with the addition of a the

    {{ content_for }}
    
binding.  `content_for` will be replaced with a view from rails that has the matching name as the current volt view being rendered.

To get things started on the rails side use the `volt_layout` helper 

   <%= volt_layout %>

The `content_for` binding can tie into a particular part of the rails view by specifying a symbol.  The matching rails view will have a matching `content_for` with the same symbol.  For example

    {{ content_for :footer }}

will be replaced by the some section of the rails view that is defined by

    <% content_for :footer do %>
       # stuff to go into the footer
    <% end %>

To summarize:

* Within the rails layout do a `<%= volt_layout %>` to hand control for rendering the the layout to volt.
* The volt code goes in a `voltage` directory within the rails `app` directory.
* Within a volt view you give control of rendering back to rails by doing a `content_for`
* Within the matching rails view you can break up parts of the content by labelling them as `<% content_for symbol do %> ... <% end %>`.  These sections will matched to any `{{ content_for symbol }}` bindings in the volt view.

## Proposed auto update from rails on content for:

Thinking about how to get any data delivered from rails to automagically:

I am thinking that something like `<% invalidate :after => 37.seconds %>`  

Invalidate would mark the current content as being invalid under some conditions (simpliest is time).  This would get sent down to the volt client, and then setup inside the binding.

For time its easy, but how about some other property (like the user changes)

As an alternative / addition what if the `{{ content_for }}` associated a bunch of locals that were passed up to the rails view, like this: 

```ruby
   {{ content_for :foo => _thing._property, :fob => _other_thing * 10 }}
```

Within the rails view :foo and :fob would be bound to the values of _thing.property, and _other_thing * 10.  The opal computation mechanism would then take care of re-requesting the view whenever _thing._property or _other_thing changed.



?? any ideas
 
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

