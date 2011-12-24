has_my_secure_password
======================

A plugin for implement secure password authentication in your model.

Installation
------------

Include the gem in your Gemfile:

    gem 'has_my_secure_password', :git => 'https://github.com/eviljojo22/has_my_secure_password'


Usage
-----

In your migrations:
	
	class CreateUsers < ActiveRecord::Migration
		def self.up
			create_table :users do |t|
				t.password
			end
		end
	end
	
Custom migration:

	class CreateUsers < ActiveRecord::Migration
		def self.up
			create_table :users do |t|
				t.password null => false
			end
		end
	end

Minimal configuration in your model:
	
	class User < ActiveRecord::Base
		has_my_secure_password
	end

Custom configuration in your model:
	
	class User < ActiveRecord::Base
		has_my_secure_password(:presence => false) do |config|
			config.has_my_secure_password_field = :username
		end
	end

The options passed to `has_my_secure_password` are used for `password_digest` field.
`password_digest` field is in `attributes_protected_by_default` for counteract mass-assignment.
`has_my_secure_password_field` is the field used by `authenticate` class method, by default it's `email`.

For know if the password is good for a user

	user = User.first.authenticate(password)
	if user
		flash[:notice] = 'Good password'
	else
		flash[:notice] = 'Bad password'
	end
	
For find a user with the good couple of `has_my_secure_password_field` and `password`

	user = User.authenticate(email, password)
	if user
		flash[:notice] = 'Good'
	else
		flash[:notice] = 'Email or password invalid'
	end
	