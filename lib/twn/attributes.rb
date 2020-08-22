Dir.glob(File.join(__dir__, "attributes", "*.rb")).each do |filename|
  require filename
end
module Twn
  # This module is a container for all of the types of world attributes.
  module Attributes
  end
end
