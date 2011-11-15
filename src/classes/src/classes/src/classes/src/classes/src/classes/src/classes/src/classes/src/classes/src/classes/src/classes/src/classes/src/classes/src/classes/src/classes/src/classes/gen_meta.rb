
class Gen_Meta 

            meta_template = File.open("/Users/jdietz/tech/Dragon-Breath/META", "r")
            meta_template_contents = meta_template.sysread(meta_template.stat.size)

            puts "Iterating through all "  + Dir["src/classes/*.cls"].size.to_s + " classes"
            counter = 0
            
            Dir["src/classes/*.cls"].each do |file|
              meta = "#{file}-meta.xml"
              next if file =~ /-meta\.xml$/ || File.exist?(meta)
                  counter += 1
                  puts meta + " does not exist, attempting to create"
                  File.open(meta, 'w') do |f|
                    f.puts(meta_template_contents)
                  end
            end
            if counter==0 
               puts "No files found without metadata."
            end

      

end