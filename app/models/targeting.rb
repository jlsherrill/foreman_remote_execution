class Targeting < ActiveRecord::Base

  belongs_to :user
  belongs_to :bookmark

  has_many :targeting_hosts, :dependent => :destroy
  has_many :hosts, :through => :targeting_hosts
  has_many :template_invocations, :dependent => :destroy

  validates :bookmark_id, :presence => {:message => N_("must be specified if search query is blank")},
            :if => Proc.new { |a| a.search_query.blank? }

  validate :bookmark_or_query


  def resolve_hosts
      query = self.bookmark ? self.bookmark.query : self.search_query
      self.hosts = User.as(self.user.login) { Host.authorized('edit_hosts', Host).search_for(query) }
  end

  private

  def bookmark_or_query
    if self.bookmark && self.search_query
      errors.add(:base, _("Cannot specify both a bookmark and a search query."))
    end
  end
end