class TopCommentersController < ApplicationController
  def index
    @top_commenters = Commontator::Comment
      .includes(:creator)
      .where('created_at >= ?', 1.week.ago)
      .where(deleted_at: nil)
      .group('commontator_comments.creator_id')
      .order('COUNT(commontator_comments.id) DESC')
      .limit(10)
  end
end
