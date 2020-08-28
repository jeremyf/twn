# TWN

A Traveller and Stars without Number world generator and glossary.

## About

Traveller and Stars without Number both have world creation processes.  Each generating a different and somewhat overlapping overview of a system.

The goal of TWN is to use both processes to generate an even more descriptive world.

I envision that you should be able to feed in an already existing Stars without Number system and output the remaining Traveller attributes.  Those generated Traveller attributes would be informed by the Stars without Number attributes.  In other words, if you gave a Stars without Number system that has a Tech Level of 4, then the Traveller attributes that feed into Tech Level would need to be able to create the conditions so you could get that Tech Level.

## Modularity

TWN comes with four modules: Core, Factions, Security Profile, and Stars without Number.

<dl>
    <dt>Core</dt>
    <dd>The world generation from the <a href="https://www.drivethrurpg.com/product/171643/Traveller-Core-Rulebook?affiliate_id=318171">Traveller Core Rulebook</a>.</dd>
    <dt>Factions</dt>
    <dd>
    The faction generation from the <a href="https://www.drivethrurpg.com/product/171643/Traveller-Core-Rulebook?affiliate_id=318171">Traveller Core Rulebook</a>.  The faction generation depends on portions of the Core module.
    </dd>
    <dt>Security Profile</dt>
    <dd>The security profile comes from <a href="https://www.drivethrurpg.com/product/309499/Journal-of-the-Travellers-Aid-Society-Volume-5?affiliate_id=318171">Journal of the Travellers' Aid Society Volume 5</a>.  The security profile generation depends on portions of the Core module.</dd>
    <dt>Stars without Number</dt>
    <dd>The Stars without Number module comes from <a href="https://www.drivethrurpg.com/product/226996/Stars-Without-Number-Revised-Edition?affiliate_id=317181">Stars without Number</a>  When using this module, if you first generate Stars without Number elements, those generated elements impact the generation of Core elements.  In this way, if you already have a Stars without Number world, you can overlay Traveller information onto that world.  The Core overlay will conform to the constraints established by the Stars without Number module.</dd>
</dl>

## Example

```
A0C0857-15     RTC  De  A {FNo9 FNo9 FNo6} {S8D9-3 Pe Te} {#N1 #M0}
||||||| |        |  |   |  |----------/     |              |---/
||||||| |        |  |   |  |                |              +- SWN Tags
||||||| |        |  |   |  |                +- Security Profile
||||||| |        |  |   |  +- Faction tags
||||||| |        |  |   +- Travel code
||||||| |        |  +- Trade code(s)
||||||| |        +- Bases
||||||| +- Tech level
||||||+- Law
|||||+- Government
||||+- Population
|||+- Hydrographic
||+- Atmosphere
|+- Size
+- Starport
```

The segments enclosed in `{…}` are additional non-core UWP codes.  Each UWP module is contained within separate `{…}`.

<dl>
<dt>Faction Tags</dt>
<dd>Each faction tag is four characters.  Character one (1) is always <code>F</code>.  Characters two and three (2-3) represent the support level.  And Character four (4) is the government level.  In the above example, <code>FNo9</code> is a Notable (<code>No</code>) sized Impersonal Bureaucracy (<code>9</code>) faction.  Faction tags are from the <a href="https://www.drivethrurpg.com/product/171643/Traveller-Core-Rulebook?affiliate_id=318171">Traveller Core Rulebook</a>.</dd>
<dt>
<dt>Security Profile</dt>
<dd>Each security tag has a leading segment (e.g. <code>S8D9-3</code>) and any number of tags (e.g. <code>Pe Te</code>).  The segment starts with an <code>S</code>, to signify Security.  The next three characters represent the security presence for the planet, orbital, and system.  The digit after the <code>-</code> is the security's stance.  The stance may be prefixed with a <code>B</code>, representing balkanisation.  The next characters are the security codes.  A security code is two characters.  Multiple security codes will be separated by spaces.  The security profile comes from <a href="https://www.drivethrurpg.com/product/309499/Journal-of-the-Travellers-Aid-Society-Volume-5?affiliate_id=318171">Journal of the Travellers' Aid Society Volume 5</a>.</dt>
<dt>SWN Tags</dt>
<dd><a href="https://www.drivethrurpg.com/product/226996/Stars-Without-Number-Revised-Edition?affiliate_id=317181">Stars without Number</a> provides a rich set of tags for describing a world.  Each tag is 3 characters.  Character one (1) is always <code>#</code>.  Character two (2) is the first letter of the tag, character three (3) is a hexdecimal value indicating the number of tagsthat start with the same character and are alphabetically sorted before the current tag.  For example the <code>#N1</code> means it's the second tag that starts with <code>N</code>.  In this case <code>#N1</code> means the world tag "Nomads."
</dl>

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twn'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install twn

## Checklist

This is a scattering of tasks, some complete and some unfinished.  It is not representative of the complete set of work.  Instead its my scratchpad.

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
- [x] Add Traveller Faction generation
- [X] Handle exception on occassional non-reconcilable intersection of constraints.
- [X] Add constraints to Row builder and apply those constraints at Attribute initialization.
- [X] Extract a ".roll" macro that captures the results
- [X] Constraints should apply to composite attributes?  They do
- [ ] Add concept of "15+" to account for greater law levels.
- [ ] Add generator to consider location in hot/cold temperature band
- [ ] Implement the conceptual modules identified in the [Modularity](#modularity) section.
- [ ] Implement a `:contrained_by` concept.  When a value is
      `constraint_by` by something, it will hook into the registry and
      add those contraints.  I suspect this to be a major refactor.
      (I don't want :Core to know about :SWN, so :SWN would have
      constraints applied to it).  **This is a nice to have feature.**
- [ ] Review [Freelance Traveller/The RICE Archives - Doing It My Way - Extending the UWP - Government](https://www.freelancetraveller.com/features/rules/expuwp/govern.html)
