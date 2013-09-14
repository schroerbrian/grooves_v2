# == Schema Information
#
# Table name: track_data
#
#  id              :integer          not null, primary key
#  track_id        :integer
#  track_name      :string(255)
#  track_permalink :text
#  user_id         :integer
#  username        :string(255)
#  user_city       :string(255)
#  user_country    :string(255)
#  user_permalink  :text
#  user_avatar_url :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  lat             :float
#  lng             :float
#

require 'spec_helper'

describe TrackData do
  pending "add some examples to (or delete) #{__FILE__}"
end
