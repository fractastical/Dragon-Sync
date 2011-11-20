class Gen_Meta 
     
     api_version = 22.0
                     


    meta_template = File.open("/Users/jdietz/tech/Dragon-Breath/META", "r")
    meta_template_contents = meta_template.sysread(meta_template.stat.size)

    puts "Iterating through all "  + Dir["src/classes/*.cls"].size.to_s + " classes"
    counter = 0      
    
    hash = { :class => { :extension => "cls", :foldername => "classes", :metaxml =>
      <<-EOS
              <?xml version="1.0" encoding="UTF-8"?>
              <ApexClass xmlns="http://soap.sforce.com/2006/04/metadata">
                <apiVersion>#{api_version}</apiVersion>
              </ApexClass>
            EOS
              },
             :staticresources => { :extension => "resource", :foldername => "staticresources", :metaxml =>
                <<-EOS
                        <?xml version="1.0" encoding="UTF-8"?>
                        <ApexClass xmlns="http://soap.sforce.com/2006/04/metadata">
                          <apiVersion>#{api_version}</apiVersion>
                        </ApexClass>
                      EOS
           }  }
    
    hash.each do |k,v|      
      Dir["src/#{hash[:k][:foldername]}/*.#{hash[:k][:extension]}"].each do |file|

    end
    
    Dir["src/classes/*.cls"].each do |file|
      meta = "#{file}-meta.xml"
      next if file =~ /-meta\.xml$/ || File.exist?(meta)
          counter += 1
          puts meta + " does not exist, attempting to create"
          File.open(meta, 'w') do |f|            
            f.puts(class_xml)
          end
    end

    puts "No classes found without metadata." if counter==0    

    puts "Iterating through all "  + Dir["src/resources/*.resources"].size.to_s + " resources"
    counter = 0      
    
    Dir["src/staticresources/*.resource"].each do |file|
      meta = "#{file}-meta.xml"
      next if file =~ /-meta\.xml$/ || File.exist?(meta)
          counter += 1
          puts meta + " does not exist, attempting to create"
          File.open(meta, 'w') do |f|            
            f.puts(resource_xml)
          end
    end

    puts "No resources found without metadata." if counter==0    
    
    
end