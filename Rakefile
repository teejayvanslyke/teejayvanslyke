require 'nanoc3/tasks'

def new_post(body='', created_at=nil)
  id = Digest::SHA1.hexdigest((Time.now.to_i * Kernel.rand).to_s)
  puts id
  path = "#{File.dirname(__FILE__) + '/content/posts/' + id + '.haml'}"
  file = File.open(path, 'w')
  file << 
  %{---
kind: article
created_at: #{created_at ? created_at : Time.now}
title: 
---
#{body}
  }

  file.close

  `mvim #{path}` if body == ''
end

desc "Create a new post and open it in MacVim"
task :new_post do
  new_post
end

desc "Clean the working directory"
task :clean do
  exec "`cd #{File.dirname(__FILE__)}/content/posts && git clean -f`"
end

desc "Commit changes and provide default commit message"
task :commit do
  exec "cd #{File.dirname(__FILE__)} && git add . && git commit -am \"Automatic commit\""
end

desc "Push changes to master branch."
task :push do
  puts "here"
  exec "cd #{File.dirname(__FILE__)} && git push origin master"
end

desc "Deploy to production from local output"
task :deploy do
  exec "cd #{File.dirname(__FILE__)} && nanoc compile"
  exec "cd #{File.dirname(__FILE__)} && rsync -arvuz ./output/ deploy@bop.fm:/var/www/tjvanslyke.com/"
end

desc "Commit, push, and deploy. Use at your own risk."
task :cpd => [ :commit, :push, :deploy ] do
end

namespace :tweets do
  task :import do
    require 'twitter'

    (0..50).each do |page|
      Twitter.user_timeline("teejayvanslyke", :page => page).each do |tweet|
        next if tweet['text'][0] == '@'
        new_post tweet['text'], tweet['created_at']
      end
    end
  end
end
