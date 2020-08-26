# Factions are a lot more complicated.
#
# 1.  The number of factions keys off of the current government.
#
# 2.  The type of government for the faction requires another roll for
#     Government.  However, that roll should not add to the existing
#     government.  Nor should any registered constraints be applied.
#
# 3.  The faction has a randomized level of support.
#
# As I think about the approach.  I need a few features:
#
# 1.  Roll for an attribute without don't set the roll in the
#     generator (and thus trigger adding a constraint).
#
# 2.  I also need the rolls to inject data into the table.  That is, I
#     roll a faction, it has both government type as well as support.
#     The support level is rather easy (as is).  However, adding to
#     the row the type of government is a bit beyond what I have
#     setup.
Twn::Attributes.register(:Factions) do
  table do
    # from_uwp_slug do |uwp_slug|
    #   strength = uwp_slug[1..2]
    #   government = uwp_slug[3]
    #   row = rows.find { |r| r.fetch(:strength).start_with?(strength) }
    #   government = find(:Government, uwp_slug: government)
    #   row.merge(government: government)
    # end
    to_uwp_slug { |row| "F#{row.fetch(:strength)[0..1]}#{row.fetch(:government).to_uwp_slug}" }
    row(roll: 2, strength: "Obscure group - few have heard of them, no popular support")
    row(roll: 3, strength: "Obscure group - few have heard of them, no popular support")
    row(roll: 4, strength: "Finger group - few supporters")
    row(roll: 5, strength: "Finger group - few supporters")
    row(roll: 6, strength: "Minor group - some supporters")
    row(roll: 7, strength: "Minor group - some supporters")
    row(roll: 8, strength: "Notable group - significant support, well known")
    row(roll: 9, strength: "Notable group - significant support, well known")
    row(roll: 10, strength: "Signficant - nearly as powerful as the government")
    row(roll: 11, strength: "Signficant - nearly as powerful as the government")
    row(roll: 12, strength: "Overwhelming popular support - more powerful than the government")
  end


  roller do
    government = get!(:Government)
    how_many_rolls = roll("1d3")
    how_many_rolls += 1 if government.roll == 0
    how_many_rolls += 1 if government.roll == 7
    how_many_rolls -= 1 if government.roll >= 10
    (1..how_many_rolls).map do
      { roll: roll("2d6"), government: roll_for(:Government) }
    end
  end
end
