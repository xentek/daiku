# Daiku
## Craft lightweight ruby applications

![Japanese Carpentry](http://upload.wikimedia.org/wikipedia/commons/0/0d/Wagoya_-_Japanese_Roof_Structure.jpg)


### Installation

    $ gem install daiku

### Updating daiku

    $ gem update daiku


### Usage

To generate a basic app, run the `new` command, passing it the port your local server should listen to incoming requests on. The generated app is whole and complete, and ready to run.

    $ daiku new myapp --port 5000
    $ cd myapp
    $ bundle install
    $ bundle exec foreman start
    $ open http://localhost:5000

### Options

You can further customize the app that's generated by passing additional options. The built-in help system explains the available options.

    $ daiku help new
    Usage:
      daiku new APP -p, --port=N

    Options:
      -p, --port=N                                             # Port this app should run on locally.
          [--ruby-version=RUBY_VERSION]                        # Specify the version of ruby this project should use.
                                                               # Default: 2.1.2
      -m, [--models=MODELS]                                    # Choose the data modeling tool this project uses.
                                                               # Default: datamapper
                                                               # Possible values: datamapper, none
      -a, [--assets=ASSETS]                                    # Choose the assets workflow this project uses.
                                                               # Default: grunt
                                                               # Possible values: grunt, none
          [--honeybadger-private-key=HONEYBADGER-PRIVATE-KEY]  # Honeybadger Private API Key
          [--honeybadger-public-key=HONEYBADGER-PUBLIC-KEY]    # Honeybadger Private API Key
          [--no-newrelic]                                      # Don't use New Relic.
          [--with-vcr]                                         # Include `vcr` in this project's TDD stack.
          [--with-sidekiq]                                     # Set this project up to use `sidekiq` for background processing.

Generate a new application with daiku


### Example

Consider the following example:

    $ daiku new myapp -p 5000 -m datamapper -a grunt --with-vcr --with-sidekiq

This will generate the following app:

````
myapp
├── .bowerrc
├── .env
├── .gitignore
├── .grunt
│   ├── aliases.yaml
│   ├── coffee.coffee
│   ├── imagemin.coffee
│   ├── robotstxt.coffee
│   ├── sass.coffee
│   ├── slim.coffee
│   └── uglify.coffee
├── .node-version
├── .ruby-version
├── .slugignore
├── .travis.yml
├── Gemfile
├── Gruntfile.coffee
├── Procfile
├── Rakefile
├── app.rb
├── assets
│   ├── images
│   │   └── .gitkeep
│   ├── javascripts
│   │   └── app.coffee
│   ├── pages
│   │   └── .gitkeep
│   └── stylesheets
│       ├── .gitkeep
│       └── app.scss
├── bin
│   └── console
├── bower.json
├── config
│   ├── datamapper.rb
│   ├── honeybadger.rb
│   ├── puma.rb
│   └── sidekiq.rb
├── config.ru
├── lib
│   ├── boot.rb
│   ├── core_ext
│   │   └── frame_options.rb
│   ├── errors
│   │   ├── .gitkeep
│   │   └── app.rb
│   ├── jobs
│   │   └── .gitkeep
│   ├── models
│   │   └── .gitkeep
│   ├── services
│   │   └── .gitkeep
│   ├── tasks
│   │   └── .gitkeep
│   └── values
│       └── .gitkeep
├── package.json
├── public
│   ├── assets
│   │   └── .gitkeep
│   └── fonts
│       └── .gitkeep
├── spec
│   ├── _cassettes
│   │   └── .gitkeep
│   ├── app_spec.rb
│   ├── db_helper.rb
│   ├── models
│   │   └── .gitkeep
│   ├── services
│   │   └── .gitkeep
│   ├── spec_helper.rb
│   └── vcr_helper.rb
└── views
    ├── index.slim
    └── layout.slim
````
