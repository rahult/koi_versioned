require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @draft_post = Factory(:post)
    @published_post = Factory(:published_post)
  end

  test "should create new post" do
    assert @draft_post
    assert @published_post
  end

  test "should respond to is_published?" do
    assert @draft_post.respond_to?(:is_published?)
  end

  test "should respond to is_draft?" do
    assert @draft_post.respond_to?(:is_draft?)
  end

  test "should respond to publish!" do
    assert @draft_post.respond_to?(:publish!)
  end

  test "should respond to draft!" do
    assert @draft_post.respond_to?(:draft!)
  end

  test "should respond to revert!" do
    assert @draft_post.respond_to?(:revert!)
  end

  test "should not respond to publish directly" do
    assert !@draft_post.respond_to?(:publish)
  end

  test "should not respond to draft!" do
    assert !@draft_post.respond_to?(:draft)
  end

  test "should not respond to revert!" do
    assert !@draft_post.respond_to?(:revert)
  end

  test "should save new post in draft state by default" do
    assert @draft_post.is_draft?
    assert !@draft_post.is_published?
  end

  test "should have the ability to publish" do
    assert @draft_post.is_draft?
    @draft_post.publish!
    @draft_post.reload
    assert @draft_post.is_published?
  end

  test "should have the ability to create a new published post" do
    assert @published_post.is_published?
    assert !@published_post.is_draft?
  end

  test "should only save one draft version" do
    assert @draft_post.is_draft?
    original_title = @draft_post.title
    changed_title = @draft_post.title.reverse
    @draft_post.title = changed_title
    @draft_post.draft!
    @draft_post.reload
    assert_not_equal original_title, @draft_post.draft_version.title
    assert_equal changed_title, @draft_post.draft_version.title
  end

  test "should update post content with draft version after publish!" do
    published_title = @draft_post.title.reverse
    @draft_post.title = published_title
    @draft_post.publish!
    @draft_post.reload
    assert @draft_post.is_published?
    assert_equal published_title, @draft_post.title
  end

  test "should keep published post content after saving draft" do
    original_title = @published_post.title
    original_updated_at = @published_post.updated_at
    changed_title = original_title.reverse
    @published_post.title = changed_title
    @published_post.draft!
    @published_post.reload
    assert_equal original_title, @published_post.title
    assert_equal original_updated_at, @published_post.updated_at
  end

  test "when the record has no published version" do
    assert_equal @draft_post.title, @draft_post.draft_version.title
  end

  test "when the record has an updated draft and no published version" do
    changed_title = @draft_post.title.reverse
    @draft_post.title = changed_title
    @draft_post.draft!
    @draft_post.reload
    assert_equal changed_title, @draft_post.title
    assert_equal changed_title, @draft_post.draft_version.title
  end

  test "should revert to published state when asked to revert" do
    published_title = @published_post.title
    @published_post.title = published_title.reverse
    @published_post.draft!
    @published_post.reload
    assert @published_post.is_draft?
    assert @published_post.is_published?
    @published_post.revert!
    @published_post.reload
    assert !@published_post.is_draft?
    assert_equal published_title, @published_post.title
  end

  test "should publish a record by passing version: true to save" do
    original_title = @draft_post.title
    changed_title = original_title.reverse
    @draft_post.title = changed_title
    @draft_post.version = true
    @draft_post.save
    @draft_post.reload
    assert !@draft_post.is_draft?
    assert @draft_post.is_published?
    assert_equal changed_title, @draft_post.title
  end

  test "should publish a record by passing version: true to update_attributes" do
    original_title = @draft_post.title
    changed_title = original_title.reverse
    @draft_post.update_attributes(title: changed_title, version: true)
    @draft_post.reload
    assert !@draft_post.is_draft?
    assert @draft_post.is_published?
    assert_equal changed_title, @draft_post.title
  end

  test "should store a record as draft by passing version: false to create" do
    draft_post = Factory(:post, version: false)
    original_title = draft_post.title
    assert draft_post.is_draft?
    assert !draft_post.is_published?
    assert_equal original_title, draft_post.title
  end

  test "should store a record as draft by passing no version attribute" do
    original_title = @draft_post.title
    assert @draft_post.is_draft?
    assert !@draft_post.is_published?
    assert_equal original_title, @draft_post.title
  end

  test "should provide scopes for accessing draft and published records" do
    published_records_count = 5
    draft_records_count = 5
    published = []
    published_records_count.times { published << Factory(:published_post) }
    drafts = []
    draft_records_count.times { drafts << Factory(:post) }
    published_draft_records_count = 2
    published_draft_records_count.times do |i|
      published[i].title = published[i].title.reverse
      published[i].draft!
    end
    draft_published_records_count = 2
    draft_published_records_count.times { |i| drafts[i].publish! }
    assert_equal published_records_count + published_draft_records_count + 1, Post.published.count
    assert_equal draft_records_count + published_draft_records_count - draft_published_records_count + 1, Post.draft.count
  end
end
