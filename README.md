[![Maintainability](https://api.codeclimate.com/v1/badges/00ed468acd8b93f66478/maintainability)](https://codeclimate.com/github/vinistock/sail/maintainability) [![Build Status](https://travis-ci.org/vinistock/sail.svg?branch=master)](https://travis-ci.org/vinistock/sail) [![Test Coverage](https://codeclimate.com/github/vinistock/sail/badges/coverage.svg)](https://codeclimate.com/github/vinistock/sail/coverage) [![Gem Version](https://badge.fury.io/rb/sail.svg)](https://badge.fury.io/rb/sail) ![](http://ruby-gem-downloads-badge.herokuapp.com/sail?color=brightgreen&type=total)

# Sail

This Rails engine brings a setting model into your app to be used as feature flags, gauges, knobs and other live controls you may need.

It can either serve as an admin control panel or user settings, depending on how you wish to apply it. 

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'sail'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install sail
```

Adding the following line to your routes file will make the dashboard available at <base_url>/sail

```ruby
mount Sail::Engine => '/sail'
```

Running the generator will create the settings table for your application.

```bash
$ rails g sail my_desired_migration_name
```

Which generates a migration to create the following table

```ruby
create_table :sail_settings do |t|
  t.string :name, null: false
  t.text :description
  t.string :value, null: false
  t.integer :cast_type, null: false, limit: 1
  t.index ["name"], name: "index_settings_on_name", unique: true
  t.timetamps
end
```

## Configuration

Available configurations and their defaults are listed below

```ruby
Sail.configure do |config|
  config.cache_life_span = 10.minutes # How long to cache the Sail::Setting.get response for
  config.array_separator = ';'        # Default separator for array settings
  config.dashboard_auth_lambda = nil  # Defines an authorization lambda to access the dashboard. When the lambda returns true, accessing the dashboard is authorized. Otherwise, it will render forbidden.
end
```

## Manipulating settings in the code

Settings can be read or set via their interface. Notice that when reading a setting's value, it will be cast to the appropriate type using the "cast_type" field.

Possible cast types are
* integer
* float
* string
* boolean
* ab_test
* cron
* obj_model
* range
* array

```ruby
# Get setting value with appropriate cast type 
Sail::Setting.get('name')

# Set setting value
Sail::Setting.set('name', 'value') 
```

Sail also comes with a JSON API for manipulating settings.

```json
GET sail/settings/:name

Response
{
  "value": true
}

PUT sail/settings/:name

Response
200 OK
```

## Examples

```ruby
# Integer setting
Sail::Setting.create(name: :my_setting, cast_type: :integer, description: 'A very important setting', value: '15')
Sail::Setting.get(:my_setting)
=> 15

# Float setting
Sail::Setting.create(name: :my_setting, cast_type: :float, description: 'A very important setting', value: '1.532')
Sail::Setting.get(:my_setting)
=> 1.532

# String setting
Sail::Setting.create(name: :my_setting, cast_type: :string, description: 'A very important setting', value: '15')
Sail::Setting.get(:my_setting)
=> '15'

# Boolean setting
Sail::Setting.create(name: :my_setting, cast_type: :boolean, description: 'A very important setting', value: 'true')
Sail::Setting.get(:my_setting)
=> true

# AB test setting
# When true, returns true or false randomly. When false, always returns false 
Sail::Setting.create(name: :my_setting, cast_type: :ab_test, description: 'A very important setting', value: 'true')
Sail::Setting.get(:my_setting)
=> true

# Cron setting
# if DateTime.now.utc matches the configured cron expression returns true. Returns false for no matches. 
Sail::Setting.create(name: :my_setting, cast_type: :cron, description: 'A very important setting', value: '* 15 1 * *')
Sail::Setting.get(:my_setting)
=> true

# Obj model setting
# Will return the model based on the string value 
Sail::Setting.create(name: :my_setting, cast_type: :obj_model, description: 'A very important setting', value: 'Post')
Sail::Setting.get(:my_setting)
=> Post

# Range setting (ranges only accept values between 0...100)
Sail::Setting.create(name: :my_setting, cast_type: :range, description: 'A very important setting', value: '99')
Sail::Setting.get(:my_setting)
=> 99

# Array setting
Sail::Setting.create(name: :my_setting, cast_type: :array, description: 'A very important setting', value: 'John;Alfred;Michael')
Sail::Setting.get(:my_setting)
=> ['John', 'Alfred', 'Michael']
```

## Managing your settings live

Sail brings a dashboard so that you can manage your settings and update their values as needed.

![dashboard](https://raw.githubusercontent.com/vinistock/sail/master/app/assets/images/sail/sail.png)

## Contributing

Please refer to this simple [guideline].

[guideline]: https://github.com/vinistock/sail/blob/master/CONTRIBUTING.md
