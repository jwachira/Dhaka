class User < ActiveRecord::Base
  ROLES = %w( admin seller buyer )
  has_many :listings, :foreign_key => 'seller_id'
  acts_as_tagger
  @@permalink_field = :name

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :reference_id, :name, :email, :password, :password_confirmation, :remember_me

  validates :name,
    :presence => true,
    :format   => {
      :with    => /\A[\w \.\-]+\z/,
      :message => 'may only contain on alphanumeric characters, spaces, dashes, and underscores'
    }


  scope :with_role, lambda { |role|
    { :conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0" }
  }

  def roles= new_roles
    self.roles_mask = (new_roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((self.roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role_symbols
    roles.map &:to_sym
  end

  def has_role? role
    role_symbols.include? role.to_sym
  end

  def admin?
    has_role? 'admin'
  end

  def to_param
    permalink
  end
end