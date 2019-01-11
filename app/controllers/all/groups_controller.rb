class All::GroupsController < GroupsController

  def index
    if params[:group]
      @groups = Group.includes(:joinner)
                      .all.order(created_at: :desc)
                      .title_search(params[:group])
                      .page(params[:page]).per(20)
    else
      @groups = Group.includes(:joinner)
                      .all.order(created_at: :desc)
                      .page(params[:page]).per(20)
    end

  end
end
