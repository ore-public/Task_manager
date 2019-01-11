# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :logged_in_check
  before_action :correct_user_check, except: %i[index new create show]
  before_action :correct_member_check, only: %i[show]
  def index
    if params[:task]
      @tasks = Task.includes(:stuck_labels)
                   .where(user_id: current_user.id)
                   .page(params[:page]).per(20)
                   .title_search(params[:task])
                   .status_choise(params[:task])
                   .priority_choise(params[:task])
                   .priority_order(params[:task])
                   .deadline_order(params[:task])
                   .label_search(params[:task])
      @form_default = params[:task]
      @deadline_close = @tasks.where(deadline: DateTime.now..DateTime.now + 3)
                              .where.not(status: '完了').count
      @deadline_over = @tasks.where("deadline < ?", DateTime.now ).where.not(status: '完了').count

    else
      @tasks = Task.includes(:stuck_labels)
                   .where(user_id: current_user.id)
                   .page(params[:page]).per(20)
                   .order(created_at: :desc)
      @deadline_close = @tasks.where(deadline: DateTime.now..DateTime.now + 3)
                              .where.not(status: '完了').count
      @deadline_over = @tasks.where("deadline < ?", DateTime.now ).where.not(status: '完了').count
    end
  end

  def show; end

  def new
    @task = if params[:back]
              Task.new(task_params)
            else
              Task.new
            end
    @groups = group_select_form
  end

  def create
    @task = Task.new(format_fix(task_params))
    if @task.save
      label_maker(@label) unless @label.nil?
      redirect_to @task, notice: 'タスクの保存に成功しました'
    else
      render :new
    end
  end

  def edit
    @groups = group_select_form
  end

  def update
    if @task.update(format_fix(task_params))
      label_maker(@label) unless @label.nil?
      redirect_to @task, notice: 'タスクの編集に成功しました'
    else
      render :edit
    end
  end

  def destroy
    if params[:label_id]
      relation = TaskLabelRelation.find_by(task_id: params[:id], label_id: params[:label_id])
      relation.destroy
      redirect_to edit_task_path(id: params[:id])
    else
      @task.destroy
      redirect_to '/', notice: 'タスクの削除に成功しました'
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def logged_in_check
    redirect_to new_session_path unless logged_in?
  end

  def correct_user_check
    redirect_to root_path if @task.user_id != current_user.id
  end

  def correct_member_check
    redirect_to groups_path, notice: '参加ユーザー以外閲覧出来ません' unless current_user.joined.ids.include?(@task.group_id)
  end

  def task_params
    params.require(:task)
          .permit(:title,
                  :content,
                  :deadline,
                  :status,
                  :priority,
                  :group_id,
                  :label)
  end

  def format_fix(task_params)
    @label = task_params[:label] unless task_params[:label] == ''
    task_params.delete(:label)
    task_params[:priority] = task_params[:priority].to_i
    task_params[:user_id] = current_user.id
    task_params
  end

  def label_maker(label_text)
    scaned_labels = label_text.scan(/[^ 　\r\n]+/)
    scaned_labels.each do |la|
      if Label.exists?(name: la)
        a = Label.find_by(name: la)
        TaskLabelRelation.create(task_id: @task.id, label_id: a.id) unless @task.stuck_labels.exists?(id: a.id)
      else
        lab = Label.new(name: la)
        lab.save
        TaskLabelRelation.create(task_id: @task.id, label_id: lab.id)
      end
    end
  end

  def group_select_form
    groups = {}
    joinnings = GroupUserRelation.where(user_id: current_user.id)
    joinnings.each do |join|
      group = Group.find_by(id: join.group_id)
      groups["#{group.title}"] = group.id
    end
    groups
  end
end
