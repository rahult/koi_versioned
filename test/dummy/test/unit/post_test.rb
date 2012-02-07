require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should create new post" do
    post = Post.new
    assert post.save
  end

  test "should respond to published?" do
    post = Post.new
    post.save
    assert post.published?
  end
end
