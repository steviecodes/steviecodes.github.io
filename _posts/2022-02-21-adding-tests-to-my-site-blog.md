---
layout: post
title: Adding tests to my site/blog
date: 2022-02-21 00:44
categories: testing rspec capybara selenium ruby jekyll
---

I am a big proponent of testing. I don't subscribe to a particular discipline, I
use what works and is suitable for the task.  I think that sometimes doctorine
can get in the way of shipping, however that is a blog post that warrants its
own entry.

As stated in a [GitHub
Issue](https://github.com/steviecodes/steviecodes.github.io/issues/3) I want to
have test suite for this blog.  This site is a [staticly
generated](/blogging/jekyll/go/google/s3/githubpages/hosting/2022/02/20/why-use-jekyll/).

A valid test or test suite would be to check the HTML and any internal links are
valid. That would be easy enough to test. Read in any files that are
publishable, check the markup via a few regexs. However these aren't real world
tests. Testing that the HTML is valid is no longer enough with the advent of javascript.

To create real world acceptance tests for my site, I use a few technologies:

- [RSpec](http://rspec.info/) - Behaviour Driven Development for Ruby -
- [Capybara](https://github.com/teamcapybara/capybara) - Test web applications by
simulating how a real user would interact with my site 
- [Selenium](https://www.selenium.dev/) - Selenium automates browsers

These let me set up a way to write tests (RSpec) and drive the browser
(Selenium) using an acceptance test API (Capybara). This gets me most of the way
there, but one problem - how do I serve the static site, so it can actually be
tested?

Most popular Ruby applications (such as Ruby on Rails and Sinatra) use the
[Rack](http://rack.github.io/) interface to connect web requests to Ruby code.
Since Jekyll generates static pages, it doesn't have a Rack interface by default.
However [rack-jekyll](https://github.com/adaoraul/rack-jekyll) is a gem that
bridges the gap, and allows us to serve my pages to Selenium so I can test it
using the browser.

### Gemfile

```ruby
source 'https://rubygems.org'

gem 'jekyll'

group :development, :test do
  gem 'capybara'
  gem 'chromedriver-helper'
  gem 'rack-jekyll'
  gem 'rspec'
  gem 'selenium-webdriver'
end
```

```bash
bundle install
brew install chromedriver
```

This installs what is needed.

Next generate the necessary configuration files for RSpec using `rspec --init`.

```bash
$ rspec --init
  create   .rspec
  create   spec/spec_helper.rb
```

This creates two files - `.rspec` is a configuration file for RSpec output, and `spec/spec_helper.rb` is the file that loads the tests and configures the environment. To setup RSpec to use Capybara and Rack::Jekyll the spec_helper.rb file needs to look like:

```ruby
require 'capybara/rspec'
require 'rspec'
require 'rack/jekyll'
require 'rack/test'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  Capybara.app = Rack::Jekyll.new(force_build: true)
end
```

I created a directory and a file in the `spec/` directory called
`features/homepage__spec.rb`. The `*_spec.rb` suffix is needed for all files to
let RSpec run it automatically.

```ruby
describe 'the homepage', type: :feature, js: true do
  before { visit '/' }

  it 'has the page title' do
    expect(find('.site-title').text).to eq('Stevie Codes')
  end
end
```

Run `bundle exec rspec`. This will

- Build the Jekyll site
- Open a Chrome browser
- Run the test(s)
- Pause after the page loads.

![Screenshot of results](/images/test-results-2021-02-19.png)

I am going to use this to ensure my site works as expected. It obviously needs
extended. The next step is to add it to some sort of [CI
workflow](https://github.com/steviecodes/steviecodes.github.io/issues/6). From
there then I will add more comprehensive
[tests](https://github.com/steviecodes/steviecodes.github.io/issues/5). I think
it is a good first step.
