require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @post = Factory(:post)
  end

  test "should create new post" do
    assert @post.save
  end

  test "should save new post in draft state by default" do
    @post.save
    assert @post.is_draft?
    assert !@post.is_published?
  end

  test "should respond to is_published?" do
    assert @post.respond_to?(:is_published?)
  end

  test "should respond to is_draft?" do
    assert @post.respond_to?(:is_draft?)
  end

  test "should respond to publish!" do
    assert @post.respond_to?(:publish!)
  end

  test "should have the ability to publish" do
    @post.save
    assert @post.is_draft?
    @post.publish!
    assert @post.is_published?
  end
end
