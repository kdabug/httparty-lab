# HTTParty on Rails

## Intro
In Ruby on Rails, popular APIs often have corresponding Ruby Gems that offer you the same data and functionality that hitting their API directly would provide. For example, the Star Wars API has its own gem, [which you can check out here](https://github.com/emaraschio/swapi-ruby).

But, what if you want to hit an API for which no gem has been built? Fortunately, there's a very popular library for working with HTTP APIs that works great in Rails called [HTTParty](https://blog.teamtreehouse.com/its-time-to-httparty).

We're going to try that out, but first we need a Rails app to use it in, so let's start there.

## Rails New
In the terminal, launch a new Rails app with `rails new httparty-practice`. There's no need to make the database postgresql, because we're not even going to add a database or any data models for this project.

Instead, we're just going to dive right in. Let's start by making a controller.

## Creating a Controller
So far, we've always made controllers that pair up with our data models; however, you can actually have a controller that isn't connected to any models or to a database. Simply create a new file in your controllers folder and call it `responses_controller.rb`. Create a ResponsesController, make sure it inherits from `ApplicationController`, and set up a method called `test`. 

Inside of `test` just write `render json: {greeting: "hello"}` for the time being. The page should look like this: 

```
class ResponsesController < ApplicationController
  def test
    render json: {greeting: "hello"}
  end
end
```

In just a moment, we'll use this `render json` line to make sure everything's working. First; however, we need a route that points to this method.

## Writing Routes
Head to your `routes.rb` file inside of your `config` folder. Let's set up a route that points to our new controller and action.

```
get '/responses', to: 'responses#test'
```

If your server is running, make sure to restart it. Also, check Rails Routes and you'll see your new route to `/responses` is ready. Start your server and visit that endpoint. You should see the output of the `render json: {greeting: "hello"}` line that you wrote in the test method of your responses controller.

Great! Now lets get some API data using HTTParty.

## It's Party Time!
Add `gem 'httparty'` to your gemfile and run `bundle install` in the terminal. HTTParty allows you to make HTTP requests from your controllers. The basic syntax is relatively simple: `HTTParty.get/post/delete/put(https://whateverurl.com)`. Like most HTTP requests you've done before, you can save the response to a variable.

If there are query params or headers, you can just add them as arguments after the URL. For example:
```
HTTParty.get("https://whateverurl.com", headers: {
      Accept: "application/json"
      })
```

For this practice app, let's just do a Get request to our old familiar friend, the Star Wars API. First, go back to the `responses_controller.rb` file and replace `render json: {greeting: "hello"}` with the following:

```
@data = HTTParty.get("https://swapi.co/api/people")
render json: @data
```

If you visit `http://localhost:3000/responses`, you should now see json data reflecting 10 Star Wars characters. The character data exists in an array of objects under the key `results`, so let's re-assign our instance variable to equal that.

```
@data = HTTParty.get("https://swapi.co/api/people")
@data = @data["results"]
```

Notice that we got rid of the `render` line. That's because we're going to display this in the view using Rails's `html.erb`. 

## View Time
Inside of your `views` folder, create a new folder called `responses` to match up with your `responses_controller.rb` file. Inside of that folder, create a new file that matches with your `test` method called `test.html.erb`. 

Inside of this file, let's use `.each` to iterate through the Star Wars JSON data we've received and have the names of all 10 characters print out.

```
<% @data.each do |data| %>
  <p><%= data["name"] %></p>
<% end %>
```

Save the file and refresh your browser. You should now see all 10 names printed in a list.

HOORAY! WE DID IT!

![](https://media1.tenor.com/images/05a7505c225710ad1b77bc4caf7cd0bf/tenor.gif?itemid=5502996)

## Lab / HW
Now it's your turn. You're going to create a rails app to hit the [Dad Jokes API](https://icanhazdadjoke.com/api). Make sure to do the following:

1. Create a new Rails app. Since you'll be creating views in Rails with `html.erb`, make sure that you *do not* make your new rails app an API. Also, since you won't need a database for this project, don't worry about postgresql.
1. Create a controller and method where you can do your HTTParty call. 
1. Set up a route that matches up with your controller and method.
1. Add the HTTParty gem to your gemfile and install it using the terminal.
1. Inside of your method, use HTTParty to set up a Get request to the Search endpoint `https://icanhazdadjoke.com/search`. Save the response to a variable. *Note* you will need to add an Accept header to your request. 
1. Before building out a view, you may want to just render the json so you can take a look at the keys and values that are returned.
1. Set up a view folder and file and render *a list of dad jokes*. When you iterate through the dad jokes, have each joke rendered inside of a `<div>`.
1. Open your `application.css` file in your `assets` folder and add some styles to your joke divs. Please do the following: 
  - Make each joke div a box with a border.
  - Give the text of each joke some padding.
  - Center each joke with `text-align: Robert` (<-- see, I can do dad jokes too!)
  - Use Flexbox or CSS grid to organize your joke boxes on the page.
  - Style the rest of the app, it should look attractive and pretty!

### Bonus
- Create a method in your controller, and a view for the `/random` endpoint


#### Work on your interview cheat sheet when you have finished.
## Resources
- [HTTParty on github](https://github.com/jnunemaker/httparty)
