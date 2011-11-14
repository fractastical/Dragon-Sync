require 'rake'
require 'rake/tasklib'
      class Gen_Meta < ::Rake::TaskLib
        
        # The directory in which to store processed source files.
        # Defaults to #{src}-processed
        attr_accessor :processed_src
        
        def main
          puts "main"
          @deploy_file       = "deploy.zip"
          @src               = 'src'
          @package_namespace = nil
          @template_helper   = 'lib/template_helper.rb'
          @package_namespace += "__" if @package_namespace
          #@processed_src     ||= "#{src}-processed" 
          @api_version = '22.0'
          make_meta_xmls
        end

        
        def define
          if name.is_a? Hash
            task_name = name.keys.first
            dependencies = name[task_name]
          else
            task_name = name
            dependencies = []
          end
        
        namespace :gen_xml do
          puts "Deploy to salesforce"
          task task_name => dependencies do
            make_meta_xmls
          end
        end
        
      end

        def make_meta(glob)
          Dir["/usr/jdietz/tech/DragonBreath/src/#{glob}"].each do |file|
            puts "found"
            meta = "#{file}-meta.xml"
            next if file =~ /-meta\.xml$/ || File.exist?(meta)
            File.open(meta, 'w') do |f|
              f.print yield(file)
            end
          end
        end
              

        def make_meta_xmls
          make_meta "classes/*.cls" do |klass|
            <<-EOS.margin
              <?xml version="1.0" encoding="UTF-8"?>
              <ApexClass xmlns="http://soap.sforce.com/2006/04/metadata">
                <apiVersion>#{@api_version}</apiVersion>
              </ApexClass>
            EOS
          end

          make_meta "pages/*.page" do |page|
            <<-EOS.margin
              <?xml version="1.0" encoding="UTF-8"?>
              <ApexClass xmlns="http://soap.sforce.com/2006/04/metadata">
                <apiVersion>#{api_version}</apiVersion>
                <label>#{File.basename(page, '.page')}</label>
              </ApexClass>
            EOS
          end

          make_meta "documents/**/*" do |doc|
            if File.directory?(doc)
              m = <<-EOS.margin
                <?xml version="1.0" encoding="UTF-8"?>
                <DocumentFolder xmlns="http://soap.sforce.com/2006/04/metadata">
                  <name>#{File.basename(doc)}</name>
                  <accessType>Public</accessType>
                  <publicFolderAccess>ReadOnly</publicFolderAccess>
                </DocumentFolder>
              EOS
            else
              <<-EOS.margin
                <?xml version="1.0" encoding="UTF-8"?>
                <Document xmlns="http://soap.sforce.com/2006/04/metadata">
                  <internalUseOnly>false</internalUseOnly>
                  <name>#{File.basename(doc)}</name>
                  <public>true</public>
                  <description>A document</description>
                </Document>
              EOS
            end
          end

          make_meta "staticresources/*.resource" do |resource|
            <<-EOS.margin
              <?xml version="1.0" encoding="UTF-8"?>
              <StaticResource xmlns="http://soap.sforce.com/2006/04/metadata">
                <cacheControl>Private</cacheControl>
                <contentType>application/zip</contentType>
                <description>A static resource</description>
              </StaticResource>
            EOS
          end

          make_meta "triggers/*.trigger" do |trigger|
            <<-EOS.margin
              <?xml version="1.0" encoding="UTF-8"?>
              <ApexTrigger xmlns="http://soap.sforce.com/2006/04/metadata">
                  <apiVersion>#{api_version}</apiVersion>
                  <status>Active</status>
              </ApexTrigger>
            EOS
          end
          
          make_meta_xmls
          main
          
        end
          
          puts "oop"
          gm = Gen_Meta.new
          gm.main

end