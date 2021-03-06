require 'spec_helper'

describe "Paper pages" do

  subject { page }

  describe "paper page" do
    let(:paper) { FactoryGirl.create(:paper) }

    before do
      visit paper_path(paper)
    end

    it { should have_content paper.title }
    it { should have_content paper.identifier }
    it { should have_title paper.identifier }
    it { should have_content paper.authors[0] }
    it { should have_content paper.authors[1] }
    it { should have_content paper.abstract }
    it { should have_link paper.url }
    it { should have_content paper.pubdate.to_formatted_s(:rfc822) }

    describe "when a paper has not been updated" do
      before do
        paper.updated_date = paper.pubdate
        paper.save

        visit paper_path(paper)
      end

      it { should_not have_content "Updated on" }
    end

    describe "when a paper has been updated" do
      before do
        paper.updated_date = paper.pubdate + 1
        paper.save

        visit paper_path(paper)
      end

      it { should have_content paper.updated_date.to_formatted_s(:rfc822) }
    end

    describe "cross-listed papers" do
      let(:other_feed) { FactoryGirl.create(:feed) }

      describe "when there are no cross-listings" do

        before do
          visit paper_path(paper)
        end

        it "should not display cross-listings" do
          page.should_not have_content "Subjects:"
        end
      end

      describe "when there are cross-listings" do

        before do
          paper.cross_lists.create!(feed_id: other_feed.id, \
                                    cross_list_date: Date.today)
          visit paper_path(paper)
        end

        it "should display cross-listings" do
          page.should have_content "Subjects:"
        end

        it "should list the cross-listed feeds" do
          paper.cross_listed_feeds.each do |f|
            page.should have_content f.name
          end
        end
      end
    end

    describe "sciting/unsciting" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "sciting a paper" do
        before { visit paper_path(paper) }

        it "should increment the scited papers count" do
          expect do
            click_button "Scite!"
          end.to change(user.scited_papers, :count).by(1)
        end

        it "should increment the paper's scites count" do
          expect do
            click_button "Scite!"
          end.to change(paper.sciters, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Scite!" }
          it { should have_button("Unscite") }
        end
      end

      describe "unsciting a paper" do
        before do
          user.scite!(paper)
          visit paper_path(paper)
        end

        it "should decement the scited papers count" do
          expect do
            click_button "Unscite"
          end.to change(user.scited_papers, :count).by(-1)
        end

        it "should decrement the paper's scites count" do
          expect do
            click_button "Unscite"
          end.to change(paper.sciters, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button "Unscite" }
          it { should have_button("Scite!") }
        end
      end

      describe "should list sciters" do
        let(:user) { FactoryGirl.create(:user) }
        let(:other_user) { FactoryGirl.create(:user) }

        before do
          user.scite!(paper)
          visit paper_path(paper)
        end

        it { should have_content user.name }
        it { should_not have_content other_user.name }
      end
    end

    describe "comments" do
      let(:user) { FactoryGirl.create(:user) }
      let(:other_user) { FactoryGirl.create(:user) }
      let(:other_paper) { FactoryGirl.create(:paper) }

      describe "should list all comments for paper" do
        before do
          5.times { |n| user.comments.create(paper_id: paper.id,  content: "This is comment number #{n+1}.") }
          5.times { |n| other_user.comments.create(paper_id: paper.id,  content: "This is comment number #{n+6}.") }

          5.times { |n| user.comments.create(paper_id: other_paper.id,  content: "This is other comment number #{n+1}.") }
          5.times { |n| other_user.comments.create(paper_id: other_paper.id,  content: "This is other comment number #{n+6}.") }

          visit paper_path(paper)
        end

        it "should have all comments" do
          paper.comments.each do |comment|
            page.should have_content comment.content
          end
        end

        it "should not have comments from other papers" do
          other_paper.comments.each do |comment|
            page.should_not have_content comment.content
          end
        end

        it "should link to name of commenters" do
          paper.comments.each do |comment|
            page.should have_link comment.user.name
          end
        end

        it "should list comment time/date" do
          paper.comments.each do |comment|
            page.should have_content comment.created_at.to_formatted_s(:short)
          end
        end

        it "should list the nubmer of comments" do
          page.should have_content "10 comments"
        end

        describe "should sanitize comments" do
          before do
            user.comments.create(paper_id: paper.id,  content: '<a href="http://google.com">spam link</a>')
            user.comments.create(paper_id: paper.id,  content: '<h1>Heading in Comment</h1>')
            visit paper_path(paper)
          end

          describe "and not allow links" do
            it { should_not have_link "spam link" }
          end

          describe "and not allow markup" do
            it { should_not have_heading "Heading in Comment" }
          end
        end
      end

      describe "leaving a comment" do

        describe "when not signed in" do
          before { visit paper_path(paper) }

          it { should_not have_button "Leave Comment" }
          it { should_not have_field "comment[content]" }
        end

        describe "when signed in" do
          before do
            sign_in user
            visit paper_path(paper)
          end

          it { should have_button "Leave Comment" }
          it { should have_field "comment[content]" }

          describe "with no content" do
            it "should not increment user's comments count" do
              expect do
                click_button "Leave Comment"
              end.not_to change(user.comments, :count)
            end

            it "should not increment paper's comments count" do
              expect do
                click_button "Leave Comment"
              end.not_to change(paper.comments, :count)
            end

            it "should not create a comment" do
              expect do
                click_button "Leave Comment"
              end.not_to change(Comment, :count)
            end

            it "should generate an error message" do
              click_button "Leave Comment"
              page.should have_content "Error posting comment"
            end
          end

          describe "with valid content" do
            before { fill_in "comment[content]", with: "Test comment." }

            it "should increment user's comments count" do
              expect do
                click_button "Leave Comment"
              end.to change(user.comments, :count).by(1)
            end

            it "should increment paper's comments count" do
              expect do
                click_button "Leave Comment"
              end.to change(paper.comments, :count).by(1)
            end

            it "should create a comment" do
              expect do
                click_button "Leave Comment"
              end.to change(Comment, :count).by(1)
            end

            it "should generate an success message" do
              click_button "Leave Comment"
              page.should have_content "Comment posted"
            end
          end
        end
      end
    end
  end

  describe "index" do
    let(:feed) { Feed.default }
    let(:paper) { FactoryGirl.create(:paper, pubdate: Date.today, feed: feed) }
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }

    before do
      visit papers_path(date: Date.today)
    end

    it { should have_title "Papers for #{Feed.default.name} from #{Date.today.to_formatted_s(:short)}" }

    describe "scites display" do
      describe "when the paper has no scites" do
        before do
          paper.save
          visit papers_path(date: Date.today)
        end

        it { should have_content "0 Scites" }
      end

      describe "when the paper has one scite" do
        before do
          user.scite!(paper)
          visit papers_path(date: Date.today)
        end

        it { should have_content "1 Scite" }
        it { should_not have_content "1 Scites" }
      end

      describe "when the paper has two scites" do
        before do
          user.scite!(paper)
          other_user.scite!(paper)

          visit papers_path(date: Date.today)
        end

        it { should have_content "2 Scites" }
      end
    end

    describe "searching" do
      let(:foo_paper) { FactoryGirl.create(:paper, title: "On the origin of Foo") }
      let(:bar_paper) { FactoryGirl.create(:paper, title: "Bar: not baz") }

      before do
        foo_paper.save
        bar_paper.save

        visit papers_path(search: "foobar")
      end

      it { should_not have_content "Recent comments" }
      it { should_not have_content "next" }
      it { should_not have_content "prev" }

      it { should have_content "Search results" }
      it { should have_content "foobar" }

      describe "for a paper that does not exist" do
        before { visit papers_path(search: "notfound") }

        it { should_not have_content foo_paper.title }
      end

      describe "for a paper that exists" do
        before { visit papers_path(search: "foo") }

        it { should have_content foo_paper.title }
        it { should_not have_content bar_paper.title }
      end
    end

    describe "abstract display" do
      describe "when the user is not signed in" do
        describe "when the paper has no scites" do
          before do
            paper.save
            visit papers_path(date: Date.today)
          end

          it { should_not have_content paper.abstract }
        end

        describe "when the paper has one scite" do
          before do
            user.scite!(paper)
            visit papers_path(date: Date.today)
          end

          it { should have_content paper.abstract }
        end
      end

      describe "when the user is signed in" do
        before do
          sign_in user
        end

        describe "when the user has not set expand_abstracts preference" do
          before do
            user.expand_abstracts = false
            user.save!
          end

          describe "when the paper has no scites" do
            before do
              paper.save
              visit papers_path(date: Date.today)
            end

            it { should_not have_content paper.abstract }
          end

          describe "when the paper has one scite" do
            before do
              user.scite!(paper)
              visit papers_path(date: Date.today)
            end

            it { should have_content paper.abstract }
          end
        end

        describe "when the user has set expand_abstracts preference" do
          before do
            user.expand_abstracts = true
            user.save!
            sign_in user
          end

          describe "when the paper has no scites" do
            before do
              paper.save
              visit papers_path(date: Date.today)
            end

            it { should have_content paper.abstract }
          end

          describe "when the paper has one scite" do
            before do
              user.scite!(paper)
              visit papers_path(date: Date.today)
            end

            it { should have_content paper.abstract }
          end
        end
      end
    end

    describe "comments display" do
      describe "when the paper has no comments" do
        before do
          paper.save
          visit papers_path(date: Date.today)
        end

        it { should_not have_link "Comment" }
      end

      describe "when the paper has one comment" do
        before do
          user.comments.create(paper_id: paper.id, content: "Hi.")
          visit papers_path(date: Date.today)
        end

        it { should have_link "1 Comment" }
        it { should_not have_link "1 Comments" }
      end

      describe "when the paper has two comments" do
        before do
          user.comments.create(paper_id: paper.id, content: "Hi.")
          other_user.comments.create(paper_id: paper.id, content: "Ho.")
          visit papers_path(date: Date.today)
        end

        it { should have_link "2 Comments" }
      end
    end

    describe "recent comments display" do
      let(:comment) { user.comments.create(paper_id: paper.id, content: "Foobar") }

      before do
        comment.save
        visit papers_path(date: Date.today)
      end

      it "should display recent comments" do
        page.should have_comment comment
      end

      it "should not display more than 10 recent" do
        #add 10 comments to fill list
        for i in 1..10 do
          user.comments.create(paper_id: paper.id, content: "Bogus comment #{i}")
        end
        visit papers_path(date: Date.today)

        page.should_not have_comment comment
      end

      it "should truncate long comments at 500 chars" do
        long = "a"*500 + "should not appear"
        long_comment = user.comments.create(paper_id: paper.id, content: long)
        visit papers_path(date: Date.today)

        page.should have_comment long_comment

        # test that only the right part of comment should be displayed
        page.should have_content ("a"*500)
        page.should_not have_content "should not appear"

        # test for link to rest of comment
        page.should have_link "...(continued)"
      end

      describe "should sanitize comments" do
        describe "and not allow links" do
          before do
            comment.content = '<a href="http://google.com">spam link</a>'
            comment.save
            visit papers_path(date: Date.today)
          end

          it { should_not have_link "spam link" }
        end

        describe "and not allow markup" do
          before do
            comment.content = '<h1>Heading in Comment</h1>'
            comment.save
            visit papers_path(date: Date.today)
          end

          it { should_not have_heading "Heading in Comment" }
        end
      end
    end

    describe "cross-listed papers" do
      let(:other_feed) { FactoryGirl.create(:feed) }
      let(:other_paper) { FactoryGirl.create(:paper, pubdate: Date.today, feed: other_feed) }
      let(:yet_another_paper) { FactoryGirl.create(:paper, pubdate: Date.today, feed: other_feed) }

      before do
        other_paper.cross_lists.create!(feed_id: feed.id, cross_list_date: Date.today)
        visit papers_path(date: Date.today)
      end

      it "should list the cross-listed paper" do
        page.should have_paper other_paper
      end

      it "should not list non cross-listed papers" do
        page.should_not have_paper yet_another_paper
      end

      describe "with subscriptions" do
        before do
          user.subscribe!(feed)
          sign_in user
          visit papers_path(date: Date.today)
        end

        it "should list the cross-listed paper" do
          page.should have_paper other_paper
        end

        it "should not list non cross-listed papers" do
          page.should_not have_paper yet_another_paper
        end
      end
    end

    describe "pagination by date" do
      before(:all) do
        3.times { FactoryGirl.create(:paper, pubdate: Date.today, feed: Feed.default) }
        3.times { FactoryGirl.create(:paper, pubdate: Date.yesterday, feed: Feed.default) }
        3.times { FactoryGirl.create(:paper, pubdate: Date.yesterday - 1, feed: Feed.default) }
      end
      after(:all) do
        Paper.delete_all
      end

      it "should list all papers from today" do
        Feed.default.papers.find_all_by_pubdate(Date.today).each do |paper|
          page.should have_paper paper
        end
      end

      it "should not list all papers from yesterday" do
        Feed.default.papers.find_all_by_pubdate(Date.yesterday).each do |paper|
          page.should_not have_paper paper
        end
      end

      it "should have links to the next and previous days" do
        page.should have_link "Next", href: papers_next_path(Date.today)
        page.should have_link "Prev", href: papers_prev_path(Date.today)
      end

      it "should have links to date ranges" do
        ['2d', '3d', '1w', '1m', '1y'].each do |v|
          page.should have_link v.to_s
        end
      end

      describe "next day" do
        describe "on last day" do
          before { visit papers_next_path(date: Date.today) }

          it { should have_content "No future papers found!" }
          it { should have_title "Papers for #{Feed.default.name} from #{Date.today.to_formatted_s(:short)}" }
        end

        describe "on arbitrary day" do
          before { visit papers_next_path(date: Date.today - 1.day) }

          it { should_not have_content "No future papers found!" }
          it { should have_title "Papers for #{Feed.default.name} from #{Date.today.to_formatted_s(:short)}" }
        end
      end

      describe "prev day" do
        describe "on first day" do
          before { visit papers_prev_path(date: Date.today - 2.days) }

          it { should have_content "No past papers found!" }
          it { should have_title "Papers for #{Feed.default.name} from #{(Date.today - 2.days).to_formatted_s(:short)}" }
        end

        describe "on arbitrary day" do
          before { visit papers_prev_path(date: Date.today) }

          it { should_not have_content "No past papers found!" }
          it { should have_title "Papers for #{Feed.default.name} from #{(Date.today-1.day).to_formatted_s(:short)}" }
        end
      end
    end

    describe "feeds" do
      let(:feed) { FactoryGirl.create(:feed) }

      before do
        2.times { FactoryGirl.create(:paper, feed: feed, pubdate: Date.today) }
        2.times { FactoryGirl.create(:paper, feed: feed, pubdate: Date.yesterday) }
        2.times { FactoryGirl.create(:paper, feed: feed, pubdate: Date.yesterday - 1.day) }
        2.times { FactoryGirl.create(:paper, feed: Feed.default, pubdate: Date.yesterday) }

        visit papers_path(feed: feed.name, date: Date.yesterday)
      end

      it "should list all of right day's papers from first feed" do
        feed.papers.find_all_by_pubdate(Date.yesterday).each do |paper|
          page.should have_paper paper
        end
      end

      it "should not list any papers from default feed" do
        Feed.default.papers.each do |paper|
          page.should_not have_paper paper
        end
      end

      describe "next button and feeds" do
        before { first(:link, "Next day >>").click }

        it "should remain on the same feed" do
          page.should have_content "papers from #{feed.name}"
        end

        it "should go to the right date" do
          page.should have_content "#{Date.today.to_formatted_s(:rfc822)}"
        end
      end

      describe "prev button and feeds" do
        before { first(:link, "<< Prev day").click }

        it "should remain on the same feed" do
          page.should have_content "papers from #{feed.name}"
        end

        it "should go to the right date" do
          page.should have_content "#{(Date.yesterday - 1.day).to_formatted_s(:rfc822)}"
        end
      end

      describe "with a date range" do
        before do
          visit papers_path(feed: feed.name, range: 2, date: Date.today)
        end

        it "should have the right heading" do
          page.should have_content "#{(Date.today - 1.day).to_formatted_s(:rfc822)}"
          page.should have_content "#{Date.today.to_formatted_s(:rfc822)}"
        end

        it "should list all papers from feed in the range" do
          feed.papers.each do |paper|
            if [Date.yesterday, Date.today].include? paper.pubdate
              page.should have_paper paper
            else
              page.should_not have_paper paper
            end
          end
        end

        it "should not list any papers from default feed" do
          Feed.default.papers.each do |paper|
            page.should_not have_paper paper
          end
        end
      end

      describe "with subscriptions" do
        let(:new_user) { FactoryGirl.create(:user) }
        let(:feed1) { FactoryGirl.create(:feed) }
        let(:feed2) { FactoryGirl.create(:feed) }

        before do
          3.times { FactoryGirl.create(:paper, feed: feed1, pubdate: Date.today) }
          3.times { FactoryGirl.create(:paper, feed: feed2, pubdate: Date.today) }

          sign_in(new_user)
          new_user.subscribe!(feed1)

          visit papers_path
        end

        it { should have_title "Papers for #{new_user.name}'s feed from #{Date.today.to_formatted_s(:short)}" }
        it { should have_content "papers from #{new_user.name}'s feed" }

        it "should list most recent papers from subscribed feed" do
          feed1.papers.find_all_by_pubdate(Date.today).each do |paper|
            page.should have_paper paper
          end
        end

        it "should not list any papers from other feeds" do
          feed2.papers.each do |paper|
            page.should_not have_paper paper
          end
        end

        describe "with date range" do
          before do
            3.times { FactoryGirl.create(:paper, feed: feed1, pubdate: Date.yesterday) }
            3.times { FactoryGirl.create(:paper, feed: feed1, pubdate: Date.today - 2.day) }

            visit papers_path(range: 2)
          end

          it "should have the right heading" do
            page.should have_content "#{(Date.today - 1.day).to_formatted_s(:rfc822)}"
            page.should have_content "#{Date.today.to_formatted_s(:rfc822)}"
          end

          it "should list all papers from subscribed feeds in the range" do
            feed1.papers.each do |paper|
              if [Date.yesterday, Date.today].include? paper.pubdate
                page.should have_paper paper
              else
                page.should_not have_paper paper
              end
            end
          end

          it "should not list any papers from default feed" do
            feed2.papers.each do |paper|
              page.should_not have_paper paper
            end
          end
        end
      end
    end

    describe "pagination of large collections" do
      before(:all) do
        FactoryGirl.create_list(:paper, 10, title: "First Batch")
        FactoryGirl.create_list(:paper, 10, title: "Second Batch")
      end
      after(:all) do
        Paper.delete_all
      end

      describe "first page" do
        before { visit papers_path(date: Date.today) }

        it "should list first 10 papers but not second 10" do
          Feed.default.papers.each do |paper|
            if paper.title == "First Batch"
              page.should have_paper paper
            else
              page.should_not have_paper paper
            end
          end
        end
      end

      describe "second page" do
        before { visit papers_path(date: Date.today, page: 2) }

        it "should list second 10 papers but not first 10" do
          Feed.default.papers.each do |paper|
            if paper.title == "Second Batch"
              page.should have_paper paper
            else
              page.should_not have_paper paper
            end
          end
        end
      end
    end
  end
end
