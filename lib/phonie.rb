require "phonie/version"
require "phonie/support" unless defined? ActiveSupport
require "phonie/phone"
require "phonie/country"
require "phonie/railties/validator"

Phonie::Country.load
