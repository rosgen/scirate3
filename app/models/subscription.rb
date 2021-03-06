# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer         primary key
#  user_id    :integer
#  feed_id    :integer
#  created_at :timestamp       not null
#  updated_at :timestamp       not null
#

class Subscription < ActiveRecord::Base
  attr_accessible :feed_id

  belongs_to :user, counter_cache: true
  belongs_to :feed, counter_cache: true

  validates :user_id, presence: true
  validates :feed_id, presence: true
end
