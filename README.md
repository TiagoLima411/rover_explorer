# Rover Explorer

Simple application that simulates commands for exploration robots on Mars.

## Installation
To run the application it is assumed that you have installed Ruby Version Manager, with version 2.6.5 as default, and Mysql 5.7 to store the data. Below are links to official documentation.

[Ruby Version Manager](https://rvm.io/rvm/install).
After instalation run 'rvm install ruby-2.6.5'.

[MySql](https://dev.mysql.com/doc/refman/5.7/en/installing.html).
Make sure the service is running. And that the username and password is the same as that configured in the database.yml file.

Clone repository `git clone git@github.com:TiagoLima411/rover_explorer.git`.
Enter the `rover_explorer` folder.

### Set up Rover Explorer app

First, install the gems required by the application:

    gem install bundle
    bundle install
    
Next, execute the database commands:

    rails db:create
    rails db:migrate
    rails db:migrate RAILS_ENV=test


### Start the app

Start the Rails app to see the In-Context-Editor added to the To-Do application. You're ready to localize your app:

    rails s -b 0.0.0.0

You can find your app now by pointing your browser to http://localhost:3000.

## More information

Examples of commands that will go in the txt file:

    55 => The first line defines the size of the area to be explored.

The following lines define the robot's initial position in the defined area, and its movement commands:

    12N => N = North, S = South, W = West, E = East
    LMLMLMLMM => L = Left, R = Right, M = Move

Upload the image, which will generate the graph and the movement logs.
Log example:

    Log => Rover id: 1 ( X: 1, y: 2, Orientation: N ) = x-axis = 1, y-axis = 2 with North orientation

To run the tests:

    bin/rspec

This project is not yet in the production environment, any contribution or constructive criticism is welcome.
Any questions send email to `tiagolima.0411@gmail.com` or create issue.
Success to all.
