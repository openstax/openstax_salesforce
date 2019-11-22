namespace :openstax_salesforce do
  namespace :install do
    desc 'Copy initializers from openstax_salesforce to application'
    task :initializers do
      Dir.glob(File.expand_path('../../../config/initializers/*.rb', __FILE__)) do |file|
        if File.exists?(File.expand_path(File.basename(file), 'config/initializers'))
          print "NOTE: Initializer #{File.basename(file)} from openstax_salesforce has been skipped. Initializer with the same name already exists.\n"
        else
          cp file, 'config/initializers', verbose: false
          print "Copied initializer #{File.basename(file)} from openstax_salesforce\n"
        end
      end
    end
  end

  # TODO: Remove after all servers have been migrated
  desc 'Copy migrations from openstax_salesforce to application'
  task :install do
    Rake::Task['openstax_salesforce:install:initializers'].invoke
    Rake::Task['openstax_salesforce:install:migrations'].invoke
  end
end
