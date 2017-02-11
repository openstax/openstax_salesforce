OPENSTAX_SALESFORCE_COPY_PATHS = [
  'views',
  'controllers'
]

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

  namespace :copy do
    OPENSTAX_SALESFORCE_COPY_PATHS.each do |path|
      name = File.basename(path)
      desc "Copy #{name} from openstax_salesforce to application"
      task name.to_sym do
        cp_r File.expand_path("../../../app/#{path}/openstax/salesforce", __FILE__),
             "app/#{path}",
             verbose: false
        print "Copied #{name} from openstax_salesforce\n"
      end
    end
  end

  desc 'Copy migrations from openstax_salesforce to application'
  task :install do
    Rake::Task['openstax_salesforce:install:initializers'].invoke
    Rake::Task['openstax_salesforce:install:migrations'].invoke
  end

  desc 'Copy all customizable files from openstax_salesforce to application'
  task :copy do
    OPENSTAX_SALESFORCE_COPY_PATHS.each do |path|
      Rake::Task["openstax_salesforce:copy:#{File.basename(path)}"].invoke
    end
  end
end

