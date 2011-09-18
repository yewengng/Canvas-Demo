require File.expand_path(File.dirname(__FILE__) + '/common')

shared_examples_for "discussions selenium tests" do
  it_should_behave_like "in-process server selenium tests"

  it "should not record a javascript error when creating the first topic" do
    course_with_teacher_logged_in

    get "/courses/#{@course.id}/discussion_topics"

    form = keep_trying_until {
      driver.find_element(:css, ".add_topic_link").click
      driver.find_element(:id, 'add_topic_form_topic_new')
    }
    driver.execute_script("return INST.errorCount;").should == 0

    form.find_element(:id, "discussion_topic_title").send_keys("This is my test title")
    tiny_frame = wait_for_tiny(form.find_element(:css, '.content_box'))
    in_frame tiny_frame["id"] do
      driver.find_element(:id, 'tinymce').send_keys('This is the discussion description.')
    end

    form.find_element(:css, ".submit_button").click
    keep_trying_until { DiscussionTopic.count.should == 1 }

    find_all_with_jquery(".add_topic_form_new:visible").length.should == 0
    driver.execute_script("return INST.errorCount;").should == 0
  end

  it "should create a podcast enabled topic" do
    course_with_teacher_logged_in

    get "/courses/#{@course.id}/discussion_topics"

    form = keep_trying_until {
      driver.find_element(:css, ".add_topic_link").click
      driver.find_element(:id, 'add_topic_form_topic_new')
    }

    form.find_element(:id, "discussion_topic_title").send_keys("This is my test title")
    tiny_frame = wait_for_tiny(form.find_element(:css, '.content_box'))
    in_frame tiny_frame["id"] do
      driver.find_element(:id, 'tinymce').send_keys('This is the discussion description.')
    end
    form.find_element(:css, '.more_options_link').click
    form.find_element(:id, 'discussion_topic_podcast_enabled').click

    form.find_element(:css, ".submit_button").click
    wait_for_ajax_requests
    wait_for_animations

    driver.find_element(:css, '.discussion_topic .podcast img').click
    wait_for_animations
    driver.find_element(:css, '#podcast_link_holder .feed').should be_displayed

  end

  it "should display the current username when making a side comment" do
    course_with_teacher_logged_in

    topic = @course.discussion_topics.create!
    entry = topic.discussion_entries.create!

    get "/courses/#{@course.id}/discussion_topics/#{topic.id}"

    form = keep_trying_until {
      find_with_jquery('.communication_sub_message .add_entry_link:visible').click
      find_with_jquery('.add_sub_message_form:visible')
    }

    tiny_frame = wait_for_tiny(form.find_element(:css, 'textarea'))
    in_frame tiny_frame["id"] do
      driver.find_element(:id, 'tinymce').send_keys("My side comment!")
    end
    form.find_element(:css, '.submit_button').click
    wait_for_ajax_requests
    wait_for_animations

    entry.discussion_subentries.should_not be_empty

    find_with_jquery(".communication_sub_message:visible .user_name").text.should == @user.name

  end
end

describe "course Windows-Firefox-Tests" do
  it_should_behave_like "discussions selenium tests"
end
