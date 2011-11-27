require 'nanoc3/tasks'

def new_post(body='')
  id = Digest::SHA1.hexdigest(Time.now.to_i.to_s)
  puts id
  path = "#{File.dirname(__FILE__) + '/content/posts/' + id + '.haml'}"
  file = File.open(path, 'w')
  file << 
  %{---
kind: article
created_at: #{Time.now}
title: 
---
#{body}
  }

  file.close

  `mvim #{path}` if body == ''
end

task :new_post do
  new_post
end

task :clean do
  `cd #{File.dirname(__FILE__)}/content/posts && git clean -f`
end

task :commit do
  `cd #{File.dirname(__FILE__)} && git add . && git commit -am "Automatic commit"`
end

task :push do
  `cd #{File.dirname(__FILE__)} && git push origin master`
end

task :deploy do
  `rsync -arvuz ./output/ deploy@bop.fm:/var/www/tjvanslyke.com/ `
end

namespace :tweets do
  task :import do
    require 'twitter'

    (0..50).each do |page|
      Twitter.user_timeline("teejayvanslyke", :page => page).each do |tweet|
        next if tweet['text'][0] == '@'
        new_post tweet['text']
      end
    end
  end
end
