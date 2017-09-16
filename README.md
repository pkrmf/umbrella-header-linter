# Umbrella Helper Linter

__Umbrella Header Linter__ is a linter for iOS/macOS/tvOS/watchOS Frameworks. 
Since Xcode doesn't provide a good way to identify at pre/post compile time that the umbrella header is missing files, or files are missing its Public scope, I decided to build this gem to help with the development of Frameworks.

`umbrellalinter` is the perfect tool to be used with your C.I, or during development, as a pre-build script. The `umbrellalinter` will identify every single file that is missing on its umbrella header, or every single file in the umbrella header that is missing Public scope.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'umbrellalinter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install umbrellalinter

## Usage

`umbrellalinter lint FrameworkTargetName` to lint your Framework Target.

`umbrellalinter lint FrameworkTargetName --fix` to lint and fix your umbrella header and the file's scopes.

__NOTE__: Take in consideration we don't know what files you want public or private, we don't know the architecture of your application or your public API. We base our linting and fixing on what is declared on your umbrella header or what is missing on it(Files with public scope).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pkrmf/umbrellalinter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Umbrellalinter project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pkrmf/umbrellalinter/blob/master/CODE_OF_CONDUCT.md).
