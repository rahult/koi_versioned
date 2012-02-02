#Koi Versioned#

Adds capability to ActiveRecord for storing drafts


###Active Record###

    class Post < ActiveRecord::Base
      koi_draftable
    end 


###Usage###

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

