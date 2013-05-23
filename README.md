#Koi Versioned [![Build Status](https://travis-ci.org/rahult/koi_versioned.png?branch=master)](https://travis-ci.org/rahult/koi_versioned) [![Code Climate](https://codeclimate.com/github/rahult/koi_versioned.png)](https://codeclimate.com/github/rahult/koi_versioned)

Adds capability to ActiveRecord for storing drafts


###Active Record###

```ruby
class Post < ActiveRecord::Base
  koi_draftable
end
``` 


###Usage###

```ruby
post = Post.create(title: "Guide to Git", body: "Git rocks my world!!!")

post.title = "Subversion to Git"
post.draft!

post.draft?
true

post.title
"Guide to Git"

post.draft.title
"Subversion to Git"

post.publish?
true

post.title
"Subversion to Git"
```

