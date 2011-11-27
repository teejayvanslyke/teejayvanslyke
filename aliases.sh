BLOG_PATH=~/src/tjvanslyke.com

blog-new() {
  rvm use 1.9.2
  rake -f $BLOG_PATH/Rakefile new_post
}

blog-clean() {
  rvm use 1.9.2
  rake -f $BLOG_PATH/Rakefile clean
}

blog-commit() {
  rvm use 1.9.2
  rake -f $BLOG_PATH/Rakefile clean
}

blog-push() {
  rvm use 1.9.2
  rake -f $BLOG_PATH/Rakefile push
}

blog-deploy() {
  rvm use 1.9.2
  rake -f $BLOG_PATH/Rakefile deploy
}

