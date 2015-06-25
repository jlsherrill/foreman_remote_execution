class JobInvocation < ActiveRecord::Base

  belongs_to :targeting
  has_many :template_invocations

  validates :targeting, :presence => true

end
