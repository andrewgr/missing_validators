# MissingValidators

[![Build Status](https://travis-ci.org/andrewgr/missing_validators.png)](https://travis-ci.org/andrewgr/missing_validators)
[![Code Climate](https://codeclimate.com/github/andrewgr/missing_validators/badges/gpa.svg)](https://codeclimate.com/github/andrewgr/missing_validators)

MissingValidators is a collection of custom validators that are often required in Rails applications plus shoulda-style RSpec matchers to test the validation rules.

## Installation

Add this line to your application's Gemfile:

    gem 'missing_validators'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install missing_validators

## Usage

### EmailValidator

With an ActiveRecord model:

    class User < ActiveRecord::Base
      attr_accessor :email, :name
      validates :email, email: true
    end

Or any ruby class:

    class User
      include ActiveModel::Validations
      attr_accessor :email, :name
      validates :email, email: true
    end

You can specify domains to which the email domain should belong in one of the folowing ways:

    validates :email, email: { domains: 'com' }
    validates :email, email: { domains: :com }
    validates :email, email: { domains: [:com, 'edu'] }

RSpec matcher is also available for your convenience:

    describe User do
      it { should ensure_valid_email_format_of(:email) }
    end

### UrlValidator

With an ActiveRecord model:

    class User < ActiveRecord::Base
      attr_accessor :blog, :name
      validates :blog, url: true
    end

Or any ruby class:

    class User
      include ActiveModel::Validations
      attr_accessor :blog, :name
      validates :blog, url: true
    end

You can specify domains to which the URL domain should belong in one of the folowing ways:

    validates :url, url: { domains: 'com' }
    validates :url, url: { domains: :com }
    validates :url, url: { domains: [:com, 'edu'] }

You can specify if the URL should the site root:

    validates :url, url: { root: true }

You can specify the URL scheme:

    validates :url, url: { scheme: :http }
    validates :url, url: { scheme: [:http, 'https'] }

RSpec matcher is also available for your convenience:

    describe User do
      it { should ensure_valid_url_format_of(:url) }
    end

### InequalityValidator

With an ActiveRecord model:

    class Flight < ActiveRecord::Base
      attr_accessor :origin, :destination
      validates :origin, inequality: { to: :destination }
    end

Or any ruby class:

    class Flight
      include ActiveModel::Validations
      attr_accessor :origin, :destination
      validates :origin, inequality: { to: :destination }
    end

RSpec matcher is also available for your convenience:

    describe Flight do
      it { should ensure_inequality_of(:origin).to(:destination) }
    end

### MacAddressValidator

Ensures that MAC address is in one of the following formats:

    '08:00:2b:01:02:03'
    '08-00-2b-01-02-03'
    '08002b:010203'
    '08002b-010203'
    '0800.2b01.0203'
    '08002b010203'

With an ActiveRecord model:

    class Device < ActiveRecord::Base
      attr_accessor :mac
      validates :mac, mac_address: true
    end

Or any ruby class:

    class Device
      include ActiveModel::Validations
      attr_accessor :mac
      validates :mac, mac_address: true
    end

RSpec matcher is also available for your convenience:

    describe Device do
      it { should ensure_valid_mac_address_format_of }
    end

### ColorValidator

Ensures that the color is a hexadecimal value starting with '#':

With an ActiveRecord model:

    class Widget < ActiveRecord::Base
      attr_accessor :color
      validates :color, color: true
    end

Or any ruby class:

    class Widget
      include ActiveModel::Validations
      attr_accessor :color
      validates :color, color: true
    end

RSpec matcher is not available yet.

### ImeiValidator

Ensures that IMEI is in one of the following formats:

    '356843052637512'
    '35-6843052-637512'
    '35.6843052.637512'

and its check digit is correct.

With an ActiveRecord model:

    class Phone < ActiveRecord::Base
      attr_accessor :imei
      validates :imei, imei: true
    end

Or any ruby class:

    class Phone
      include ActiveModel::Validations
      attr_accessor :imei
      validates :imei, imei: true
    end

RSpec matcher is also available for your convenience:

    describe Phone do
      it { should ensure_valid_imei_format_of }
    end

### LatitudeValidator

Ensures that the value is between -90 and 90:

With an ActiveRecord model:

    class Coordinate < ActiveRecord::Base
      attr_accessor :latitude
      validates :latitude, latitude: true
    end

Or any ruby class:

    class Coordinate
      include ActiveModel::Validations
      attr_accessor :latitude
      validates :latitude, latitude: true
    end

RSpec matcher is not available yet.

### LongitudeValidator

Ensures that the value is between -180 and 180:

With an ActiveRecord model:

    class Coordinate < ActiveRecord::Base
      attr_accessor :longitude
      validates :longitude, longitude: true
    end

Or any ruby class:

    class Coordinate
      include ActiveModel::Validations
      attr_accessor :longitude
      validates :longitude, longitude: true
    end

RSpec matcher is not available yet.

## Contributing

Your contribution is welcome.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
