Hangman
=======
# clone repo
git clone git@github.com:Emilio/Hangman.git Emilio

# make sure all gems are there
cd Emilio
bundle

# initialize and seed database
rake db:setup

# start server
rails s
