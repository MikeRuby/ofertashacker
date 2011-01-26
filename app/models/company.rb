class Company < ActiveRecord::Base
  
  production = Rails.env.production?
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :jobs
  
  validates_presence_of :title, :description, :city
  validates_attachment_content_type :logo, :content_type => ['image/jpg','image/jpeg', 'image/png']
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :title, :city, :logo, :description
	metropoli_for :city, :as=>:city_name
  scope :members, where(:role => "member")
  
  has_attached_file :logo, :styles => {:medium => "300x300>", :thumb => "100x100>"},
                            :storage => production ? :s3 : :filesystem,
                            :s3_credentials => "#{Rails.root}/config/s3.yml",
                            :path => production ? ":attachment/:id/:style/:filename" : "public/system/:attachment/:id/:style/:filename",
                            :bucket => "rubypros",
                            :default_url => "/images/missing.png"
                            
  def admin?
    self.role == "admin"
  end
  
  def member?
    self.role == "member"
  end
end