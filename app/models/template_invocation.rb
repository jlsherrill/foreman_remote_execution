class TemplateInvocation < ActiveRecord::Base

  belongs_to :template
  belongs_to :targeting

end
