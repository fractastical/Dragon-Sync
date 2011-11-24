class Gen_Meta 
     
    api_version = 22.0 
    page = ""
                         
    sfdc_package_components = { 
      
        :class => { :displayname => "Class", :pluralname => "Classes", :extension => "cls", :foldername => "classes", :metaxml =>
           
           <<-EOS
              <?xml version="1.0" encoding="UTF-8"?>
              <ApexClass xmlns="http://soap.sforce.com/2006/04/metadata">
                <apiVersion>#{api_version}</apiVersion>
              </ApexClass>
            EOS
              
              },
         
         :staticresource => { :displayname => "Static Resource", :pluralname => "Static Resources", :extension => "resource", :foldername => "staticresources", :metaxml =>
                <<-EOS
                        <?xml version="1.0" encoding="UTF-8"?>
                        <ApexClass xmlns="http://soap.sforce.com/2006/04/metadata">
                          <apiVersion>#{api_version}</apiVersion>
                        </ApexClass>
                      EOS
          
           },
          
          :visualforcepage => { :displayname => "Visualforce Page", :pluralname => "Visualforce pages", :extension => "page", :foldername => "pages", :metaxml =>
               <<-EOS
                 <?xml version="1.0" encoding="UTF-8"?>
                 <ApexClass xmlns="http://soap.sforce.com/2006/04/metadata">
                   <apiVersion>#{api_version}</apiVersion>
                   <label>#{page}</label>
                 </ApexClass>
                EOS

           },
                             
           :trigger => { :displayname => "Apex Trigger", :pluralname => "Apex Triggers", :extension => "trigger", :foldername => "triggers", :metaxml =>
             <<-EOS
               <?xml version="1.0" encoding="UTF-8"?>
               <ApexTrigger xmlns="http://soap.sforce.com/2006/04/metadata">
                   <apiVersion>#{api_version}</apiVersion>
                   <status>Active</status>
               </ApexTrigger>
             EOS
                
           },

           :component => { :displayname => "Visualforce Component", :pluralname => "Visualforce Components", :extension => "component", :foldername => "components", :metaxml =>
               <<-EOS
               <?xml version="1.0" encoding="UTF-8"?>
               <ApexComponent xmlns="http://soap.sforce.com/2006/04/metadata">
                   <apiVersion>#{api_version}</apiVersion>
                   <label>Recruit Listing</label>
               </ApexComponent>
               EOS
           }
    }
    
    sfdc_package_components.each do |k,v|   
         
      puts "Iterating through all "  + Dir["src/#{v[:foldername]}/*.#{v[:extension]}"].size.to_s + " " + v[:pluralname].downcase
      counter = 0      

      Dir["src/#{v[:foldername]}/*.#{v[:extension]}"].each do |file|
        meta = "#{file}-meta.xml" 
        page = file
        next if file =~ /-meta\.xml$/ || File.exist?(meta)
            counter += 1
            puts meta + " does not exist, attempting to create"
            File.open(meta, 'w') do |f|            
              f.puts(v[:metaxml])
            end
    end  

    puts "No " + v[:pluralname] + " found without metadata." if counter==0    

  end
    
    
end