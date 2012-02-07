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
    assert Post.new.respond_to?(:is_published?)
  end

  test "should respond to is_draft?" do
    assert Post.new.respond_to?(:is_draft?)
  end

  test "should respond to publish!" do
    assert Post.new.respond_to?(:publish!)
  end

  test "should have the ability to publish" do
    post = Post.new
    post.save
    assert post.is_draft?
    post.publish!
    post.publish!
    assert post.is_published?
  end
end
