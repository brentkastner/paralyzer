Paralyzer LinkedIn Profile Search By Email
=============================================

This tool is intended to match email addresses from a CSV formatted file against LinkedIn's Joint Integration program
available to developers by requesting their API key be added to the program. It uses the `linkedin` gem available at
https://github.com/hexgnu/linkedin and monkeypatches the person_path method to include an email= operand.

This application requires two sets of keys available from LinkedIn, namely the API_KEY/SECRET and OAUTH_KEY/SECRET

Project TODOS
-----------------

* Make a public fork of the linkedin gem with this new method option
* Extend tests to cover the new option
* Issue pull request to hexgnu (he may be interested)
* Create a command line tool in bin/email_validator.rb that uses the paralyzer class to do open the file, do the work, and
  save emails with profiles to a new csv output file.

Install and Run
-----------------

###Clone the project

```
mkdir paralyzer
cd paralyzer
git clone git@github.com:brentkastner/paralyzer.git
```

###Install Gems

```
bundle install
```

###Add ENV variables

```
export LINKEDIN_API_KEY=<your_key>
export LINKEDIN_API_SECRET=<your_secret>
export LINKEDIN_OAUTH_KEY=<your_oauth_key>
export LINKEDIN_OAUTH_SECRET=<your_oauth_secret>
```

###Run Tests

```
rake spec
```

A coverage report is generated in tmp/coverage