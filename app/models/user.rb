class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :assignments
  has_many :projects, through: :assignments
  has_many :user_issues
  has_many :issues, through: :user_issues
end
