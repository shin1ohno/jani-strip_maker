# Jani::StripMaker

[![Build Status](https://travis-ci.org/shin1ohno/jani-strip_maker.svg?branch=master)](https://travis-ci.org/shin1ohno/jani-strip_maker)
[![Code Climate](https://codeclimate.com/github/shin1ohno/jani-strip_maker/badges/gpa.svg)](https://codeclimate.com/github/shin1ohno/jani-strip_maker)
[![Test Coverage](https://codeclimate.com/github/shin1ohno/jani-strip_maker/badges/coverage.svg)](https://codeclimate.com/github/shin1ohno/jani-strip_maker)
[![Dependency Status](https://gemnasium.com/shin1ohno/jani-strip_maker.svg)](https://gemnasium.com/shin1ohno/jani-strip_maker)

You can use cli

```bash
./strip_maker from_movie_to_strips --input_file path_to_file --fps N --height N --width N
```

or you can use from ruby code

```ruby
# build encode option
transcode_options = Jani::StripMaker::TranscodeOptions.new
transcode_options.fps = 15
transcode_options.width = 320
transcode_options.fps = 180

# Get strip files in current directory from movie file
Jani::StripMaker::Movie.new(
  "path/to/movieFile.mov", transcode_options
).to_strips.each(&:write)
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jani-strip_maker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jani-strip_maker

## Contributing

1. Fork it ( https://github.com/[my-github-username]/jani-strip_maker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
