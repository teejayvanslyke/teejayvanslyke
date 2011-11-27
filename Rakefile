require 'nanoc3/tasks'

task :new_post do
  id = Digest::SHA1.hexdigest(Time.now.to_i.to_s)
  puts id
  path = "#{File.dirname(__FILE__) + '/content/posts/' + id + '.haml'}"
  file = File.open(path, 'w')
  file << 
  %{---
kind: article
created_at: #{Time.now}
title: Untitled Post
---
  }

  file.close

  `mvim #{path}`
end

task :clean do
  `cd #{File.dirname(__FILE__)}/content/posts && git clean -f`
end

task :commit do
  `cd #{File.dirname(__FILE__)} && git commit -am "Automatic commit"`
end

task :push do
  `cd #{File.dirname(__FILE__)} && git push origin master`
end

