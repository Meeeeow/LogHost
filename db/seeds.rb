class AddInitialInvoteCode < ActiveRecord::Migration[5.0]
  puts "Your initial invite code is 'nine lives'"
  InviteCode.create :code => 'nine lives'
end