##Description: 
  mgemfile is a CLI Gemfile manager, add,remove gems to any environment and "bundle install" in one CLI.
## Installation
    $ gem install mgemfile

## Usage
### Commands: init,add, (to-do)remove


####Creating Gemfile sourced by rubygems.org
    $ mgemfile init

####Adding gem(s) for all enviromnet and bundle install
    $ mgemfile add gem-name 

####Adding gem(s) for specified enviroment and bundle install
    $ mgemfile add gem-name --development --test
    $ mgemfile add gem-name1 gem-name2 gem-name.. --development --test

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

