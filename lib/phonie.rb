require "phonie/version"
require "phonie/configuration"
require "phonie/phone"
require "phonie/country"
require "phonie/railties/validator" if defined? ActiveModel

Phonie::Country.load
