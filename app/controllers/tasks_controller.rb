class TasksController < ApplicationController
  def index
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    else
      redirect_to login_url
    end 
    
  end  
   
    def show
      @task = Task.find(params[:id])  
    end
    
    def create
      @task = current_user.tasks.build(task_params)

      if @task.save
        flash[:success] = 'Task が正常に投稿されました'
        redirect_to root_url
      else
        flash.now[:danger] = 'Task が投稿されませんでした'
        render :new
      end
          
    end
    
  
    
    def update
         @task = Task.find(params[:id])
         
         if @task.update(task_params)
            flash[:success] = 'Task が正常に変更されました'
            redirect_to root_url
         else
            @task = current_user.tasks.order(id :desc).page(params[:page])
            flash.now[:danger] = 'Task が変更されませんでした'
            render :edit
         end
    end
    
    def new
        @task=Task.new
    end
    
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'Message は正常に削除されました'
    redirect_to tasks_url
  end
    
    
    def edit
        @task=Task.find(params[:id])
    end
    
  private
  
    def task_params
        params.require(:task).permit(:content,:status)
    end
    
  def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
end
