class User < ActiveRecord::Base
  serialize :avatars, Array
  mount_uploaders :avatars, ImageUploader
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable #, :confirmable
  acts_as_voter
  acts_as_follower
  acts_as_followable
  has_many :memberships
  has_many :lists,  :through => :memberships
  has_many :properties
  has_many :invitations, :class_name => 'Invite', :foreign_key => 'recipient_id'
  has_many :sent_invites, :class_name => 'Invite', :foreign_key => 'sender_id'
end
