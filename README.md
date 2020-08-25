# TWN

A Traveller and Stars without Number world generator.

## About

Stars without Number and Traveller both have world creation processes.  Each generating a different and somewhat overlapping overview of a system.

The goal of TWN is to use both processes to generate an even more descriptive world.

I envision that you should be able to feed in an already existing Stars without Number system and output the remaining Traveller attributes.  Those generated Traveller attributes would be informed by the Stars without Number attributes.  In other words, if you gave a Stars without Number system that has a Tech Level of 4, then the Traveller attributes that feed into Tech Level would need to be able to create the conditions so you could get that Tech Level.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twn'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install twn

## TODO

- [ ] Generate a UWP short-code (without coordinates) for https://campaignwiki.org/traveller/
- [X] Add Traveller Trade Codes
- [X] Ensure attribute entry can be fetched by `uwp_slug`
  - [X] Verify that each Twn::Attribute has a table
  - [X] Verify that each Twn::Attribute table's key is a `uwp_slug`
  - [X] Create UWP to Roll map for each attribute
- [X] Add SWN tags
  - [X] Tags are things to roll first, as they may influence UWP
  - [X] Tags apply Twn::Constraint
- [ ] Work on induction of Traveller traits from SWN entries
- [X] Create concept of Composite Attribute; The SwnWorldTags is a composite attribute, in that it has two implicit SwnWorldTag objects associated with it.  I see something similar as necessary for the Trade Codes.
- [ ] Consider how to render a Row
- [ ] Add a UWP converter (e.g. print out the UWP's expanded information)
- [ ] Add Traveller Faction generation
- [X] Handle exception on occassional non-reconcilable intersection of constraints.
- [X] Add constraints to Row builder and apply those constraints at Attribute initialization.
- [X] Extract a ".roll" macro that captures the results
