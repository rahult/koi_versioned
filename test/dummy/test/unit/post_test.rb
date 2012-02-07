require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @post = Factory(:post)
  end

  test "should create new post" do
    assert @post
  end

  test "should save new post in draft state by default" do
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
    assert @post.is_draft?
    @post.publish!
    assert @post.is_published?
  end

  test "should update post attributes with draft after publish!" do
    changed_title = @post.title.reverse
    @post.title = changed_title
    @post.draft!
    @post.publish!
    assert @post.is_published?
    assert_equal changed_title, @post.title
  end

  test "should keep original post attributes after saving draft" do
    original_title = @post.title
    original_updated_at = @post.updated_at
    changed_title = original_title.reverse
    @post.title = changed_title
    @post.draft!
    assert_equal original_title, @post.title
    assert_equal original_updated_at, @post.updated_at
  end

  test "should have the ability to return draft record" do
    changed_title = @post.title.reverse
    @post.title = changed_title
    @post.draft!
    assert_equal changed_title, @post.draft.title
  end
end
