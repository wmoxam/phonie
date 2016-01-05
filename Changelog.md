3.2.0
=====

* Improves BR mobile detection (Thanks @mfbmina)
* Adds an new validator for mobile numbers (Thanks @mfbmina)
* Adds a pt-BR locale for error messages (Thanks @mfbmina)

3.1.15
======

* Updates Swedish mobile area codes (Thanks @joenas!)

3.1.14
======

* Adds support for FJ. (Thanks @dramalho)
* Tightens up rules for CY (Thanks @dramalho)

3.1.13
======

* Adds support for MY. (Thanks @dramalho!)
* Add 07341 numbers to UK (Thanks @ijpiantanida!)

3.1.12
======

* Adds support for ID numbers (mobile only). Thanks @ivalkeen

3.1.11
======

* Improves new AE area code support (Thanks @ivalkeen!)

3.1.10
======

* Adds new BR area codes (Thanks @lunks!)

3.1.9
=====

* Adds support for Trinidad and Tobago

3.1.8
=====

* Remove personal numbers from GB mobile regexp. (Thanks peteryates!)

3.1.7
=====

* Fixes Brazilian number parsing (Thanks nofxx!)

3.1.6
=====

* Adds a correct international dialing prefix for Israel
* Some minor code cleanups

3.1.5
=====

* Adds support for Hong Kong
* Fixes mobile parsing for Thailand

3.1.4
=====

* Adds support for Singapore

3.1.3
=====

* Improves support for Brazil

3.1.2
=====

* Adds support for Montenegro

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
