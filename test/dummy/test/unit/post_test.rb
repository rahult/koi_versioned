require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should create new post" do
    post = Post.new
    assert post.save
  end

  test "should save new post in draft state by default" do
    post = Post.new
    post.save
    assert post.is_draft?
    assert !post.is_published?
  end

  test "should respond to is_published?" do
    post = Post.new
    post.save
    assert post.respond_to?(:is_published?)
  end

  test "should respond to is_draft?" do
    post = Post.new
    post.save
    assert post.respond_to?(:is_draft?)
  end
end
