class TasksController < ApplicationController
    def index
      @task=Task.all
    end 
   
    def show
      @task = Task.find(params[:id])  
    end
    
    def create
      @task = Task.new(task_params)

      if @task.save
        flash[:success] = 'Task が正常に投稿されました'
        redirect_to @task
      else
        flash.now[:danger] = 'Task が投稿されませんでした'
        render :new
      end
          
    end
    
  
    
    def update
         @task = Task.find(params[:id])
         
         if @task.update(task_params)
            flash[:success] = 'Task が正常に変更されました'
            redirect_to @task
         else
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
end
