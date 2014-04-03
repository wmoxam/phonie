3.1.1
=====

* Adds French error message (thanks cedric!)

3.1.0
=====

* Re-introduces ability to add custom named formats. Thanks dlindahl!

3.0.0
=====

* ActiveModel validator no longer modifies phone numbers on validation. Use a before_save to do that!
* configuration changes from Phonie::Phone.default_country_code to Phonie.configuration.default_country_code
* adds Phone#possible_valid_number? and Phone#is_valid_number?
* removes Phone#matches_full_number? Phone#matches_local_number_with_area_code? and Phone#matches_local_number?

2.1.2
=====

* fixes Mauritius parsing
* Support new Ecuador mobile numbers
* fix for Russian mobile number detection
