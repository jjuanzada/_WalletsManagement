# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

Time::DATE_FORMATS[:created] = "created at %b, %m %Y"