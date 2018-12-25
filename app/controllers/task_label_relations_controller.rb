class TaskLabelRelationsController < ApplicationController

  def destroy
    relation = TaskLabelRelation.find_by(task_id: params[:id],label_id: params[:label_id])
    relation.destroy
    redirect_to edit_task_path(id: params[:id])
  end
end
