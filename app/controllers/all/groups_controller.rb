class All::GroupsController < GroupsController

  def index
    @groups = Group.includes(:joinner)
                    .all.order(created_at: :desc)
                    .page(params[:page]).per(20)

  end
end
