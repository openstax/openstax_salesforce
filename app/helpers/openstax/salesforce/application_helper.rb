module OpenStax::Salesforce
  module ApplicationHelper
    def config
      OpenStax::Salesforce.configuration
    end

    def page_heading(context, text)
      config.page_heading_proc.call(context, text)
    end
  end
end
