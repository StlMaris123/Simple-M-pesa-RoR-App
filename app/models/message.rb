# frozen_string_literal: true

# == Schema Information
#
# Table name: scheduled_messages
#
#  id           :bigint           not null, primary key
#  message      :text
#  channel      :string
#  status       :string
#  scheduled_at :datetime
#  metadata     :jsonb
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Message < ApplicationRecord
end
