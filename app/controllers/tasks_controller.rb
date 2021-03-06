# frozen_string_literal: true

class TasksController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :task, through: :project
  before_action :task_status_options, only: %i[new edit create update]

  def show
    @new_comment = Comment.new(task: @task)
  end

  def new; end

  def edit; end

  def create
    if safe_create_task
      redirect_to project_task_path(@project, @task),
                  notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    params[:task][:user_id] = nil unless
      params[:task][:user_id] && can?(:assign_user_to_task, @task)

    if @task.update(task_params)
      redirect_to project_task_path(@project, @task),
                  notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to @project, notice: 'Task was successfully destroyed.'
  end

  private

  def task_status_options
    @task_status_options = %w[waiting implementation verifying releasing]
  end

  def base_permitted_task_params
    %i[title description status]
  end

  def authorized_permitted_task_params
    :user_id if
      can?(:assign_user_to_task, @task) ||
      (params[:task][:user_id] == current_user.id && @task.user == current_user)
  end

  def full_permitted_task_params
    base_permitted_task_params << authorized_permitted_task_params
  end

  def safe_create_task
    @task = if cannot? :assign_user_to_task, Task
              @project.tasks.new task_params.merge(user: current_user)
            else
              @project.tasks.new task_params
            end
    @task.save!
    return true
  rescue ActiveRecord::RecordInvalid
    return false
  end

  def task_params
    params.require(:task).permit(full_permitted_task_params)
  end
end
