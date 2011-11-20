class Zip_Resources 

	  require 'zip/zip'
    
    incoming_dir_name
  
	  Dir[incoming_dir_name].each do |f|
	    if File.directory?(f)
    	    resourcename = File.basename(f) + ".resource"
    	    resourcefile = "#{resourcename}"
    	    Zip::ZipFile.open(resourcefile, Zip::ZipFile::CREATE) do |zip|
    	      Dir["#{f}/**/*"].each do |file|
    	        zip.add(file.sub("#{f}/", ''), file)
    	      end
    	    end
    	  end
    end

      
 
end