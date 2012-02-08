require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @post = Factory(:post)
  end

  test "should create new post" do
    assert @post
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

  test "should respond to revert!" do
    assert @post.respond_to?(:revert!)
  end

  test "should save new post in draft state by default" do
    assert @post.is_draft?
    assert !@post.is_published?
  end

  test "should have the ability to publish" do
    assert @post.is_draft?
    @post.publish!
    assert @post.is_published?
  end

  test "should have the ability to create a new published post" do
    published_post = Factory(:published_post)
    assert published_post
    assert published_post.is_published?
    assert !published_post.is_draft?
  end

  test "should update post attributes with draft after publish!" do
    original_title = @post.title
    changed_title = @post.title.reverse
    @post.title = changed_title
    @post.draft!
    assert_equal original_title, @post.title
    @post.publish!
    assert @post.is_published?
    assert_equal changed_title, @post.title
  end

  test "should keep published post attributes after saving draft" do
    original_title = @post.title
    original_updated_at = @post.updated_at
    changed_title = original_title.reverse
    @post.title = changed_title
    @post.draft!
    assert_equal original_title, @post.title
    assert_equal original_updated_at, @post.updated_at
  end

  test "when the record has no published version" do
    assert_equal @post.title, @post.draft.title
  end

  test "when the record has an updated draft and no published version" do
    changed_title = @post.title.reverse
    @post.title = changed_title
    @post.draft!
    # assert_equal changed_title, @post.title
    assert_equal changed_title, @post.draft.title
  end

  test "should revert to published state when asked to revert" do
    @post.publish!
    published_title = @post.title
    @post.title = published_title.reverse
    @post.draft!
    assert @post.is_draft?
    assert @post.is_published?
    @post.revert!
    assert !@post.is_draft?
    assert_equal published_title, @post.title
  end
end
