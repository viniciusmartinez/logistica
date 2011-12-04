class TasksController < ApplicationController
  before_filter :require_user
  respond_to :html, :js

  # GET /tasks
  # GET /tasks.xml
  def index
    @overdue = current_user.tasks.overdue
    @today = current_user.tasks.incomplete.due_to_today
    @week = week
    @next_week = next_week
    @later = current_user.tasks.incomplete.due_to_later
    
    @empty = (@overdue + @today + @week + @next_week + @later).size == 0
    
    @incomplete = current_user.tasks.incomplete
    
    respond_with @tasks
  end
  
  def week
    @week = current_user.tasks.incomplete.due_to_this_week
  end

  def next_week
    @next_week = current_user.tasks.incomplete.due_to_next_week
  end
  
  def completed
    @completed = current_user.tasks.complete.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = current_user.tasks.find(params[:id])
    @contact = @task.contact
    @comment = @task.comments.new

    respond_with @task
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new(:due_at => Time.now)
    
    respond_with @task
  end

  # GET /tasks/1/edit
  def edit
    @task = current_user.tasks.find(params[:id])

    respond_with @task
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])
    @task.user = current_user
    
    respond_with @task do |format|
      if @task.save
        @contact = @task.contact
        @last_tasks = @contact.tasks.last_tasks if @contact.present?
        format.html { redirect_to(tasks_path, :notice => t('messages.created')) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = current_user.tasks.find(params[:id])

    respond_with @task do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to(tasks_path, :notice => t('messages.updated')) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    @tasks = current_user.tasks.order("created_at DESC")
    
    respond_with @task do |format|
      format.html { redirect_to tasks_path }
    end
  end
  
  def get_tasks
    @start_at = Time.at(params['start'].to_i).to_formatted_s(:db)
    @end_at = Time.at(params['end'].to_i).to_formatted_s(:db)
    
    @tasks = Task.where(["due_at >= ? AND due_at <= ? AND completed = ?", @start_at, @end_at, false])
    tasks = []
    @tasks.each do |task|
      tasks << {:id => task.id, :title => task.name[0..13], :name => "", :start => "#{task.due_at.iso8601}", :end => "#{task.due_at.iso8601}", :allDay => (task.due_at.time == task.due_at.at_midnight.time), :recurring => false, :url => task_path(task)}
    end
    render :text => tasks.to_json
  end
  
  def complete
    @task = current_user.tasks.find(params[:id])
    respond_with @task do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to(tasks_path, :notice => t('messages.task.completed')) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def postpone
    @task = current_user.tasks.find(params[:id])
    @days = params[:days]
    @due_at = @task.due_at + @days.to_i.day
    
    respond_with @task do |format|
      if @task.update_attribute(:due_at, @due_at)
        format.html { redirect_to(@task, :notice => t('messages.task.postponed')) }
      else
        format.html { render :action => "show" }
      end
    end
  end
  
  def comment
    @task = current_user.tasks.find(params[:id])
    @contact = @task.contact
    @comment = @task.comments.new(params[:comment])
    @comment.update_attribute(:user_id, current_user)
    
    respond_with @comment do |format|
      format.html { redirect_to([@task], :notice => t('messages.comment.created')) }
    end
  end
  
end
