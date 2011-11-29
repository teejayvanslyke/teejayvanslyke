require 'nanoc3/tasks'

ROOT = File.dirname(__FILE__)

def new_post(body='', created_at=nil)
  id = Digest::SHA1.hexdigest((Time.now.to_i * Kernel.rand).to_s)
  puts id
  path = "#{ROOT + '/content/posts/' + id + '.haml'}"
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

task :tweet => [ :new_post, :cpd ]

desc "Clean the working directory"
task :clean do
  system "`cd #{ROOT}/content/posts && git clean -f`"
end

desc "Commit changes and provide default commit message"
task :commit do
  system "cd #{ROOT} && nanoc compile && git add . && git commit -am \"Automatic commit\""
end

desc "Push changes to master branch."
task :push do
  system "cd #{ROOT} && git push origin master"
end

desc "Deploy to production from local output"
task :deploy do
  system "cd #{ROOT} && nanoc compile"
  system "cd #{ROOT} && rsync -arvuz ./output/ deploy@bop.fm:/var/www/tjvanslyke.com/"
end

desc "Commit and push. Use at your own risk."
task :cp => [ :commit, :push ]

desc "Commit, push, and deploy. Use at your own risk."
task :cpd => [ :commit, :push, :deploy ]

desc "List all post SHA's and titles in reverse chronological order"
task :list do
  posts = Dir["#{ROOT}/content/posts/*.haml"].map do |filename|
    file = File.open(filename)
    title, created_at = '', ''
    file.each_line do |line|
      if line =~ /title:\s*(.*)$/
        title = $~[1]
      elsif line =~ /created_at:\s*(.*)$/
        created_at = $~[1]
      end
    end
    { :title => title, :created_at => created_at, :sha1 => File.basename(file).gsub('.haml','') }
  end.
    sort {|a, b| b[:created_at] <=> a[:created_at] }.
    each {|post| puts "#{post[:created_at]} #{post[:sha1]} #{post[:title]}"}
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
