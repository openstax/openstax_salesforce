ActiveSupport::Inflector.inflections do |inflect|
  inflect.acronym 'OpenStax'
end

module OpenStax
  module Salesforce
    class Engine < ::Rails::Engine
      isolate_namespace OpenStax::Salesforce
    end
  end
end
