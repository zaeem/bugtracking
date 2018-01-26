class ProjectsController < ApplicationController
    

    def index
        @user = current_user
        @projects = current_user.projects
        @count = @projects.count
    end

    def new 
        @project = Project.new
    end

    def create
        @project = Project.new(project_params)
        
        if @project.save
            @user_project = UserProject.new
            @user_project.user_id = current_user.id
            @user_project.project_id = @project.id
            @user_project.save
            flash[:success] = "Sucessfully Created #{@project.project_name}"
            redirect_to action: "index"
        else      
            flash[:danger] = "#{@project.errors.full_messages}"
            redirect_to action: "new"
        end
    end

    def destroy
        @project = Project.find(params[:id])
        Project.find(@project).destroy
        flash[:success] = "Sucessfully deleted #{@project.project_name}"
        redirect_to action: "index"
    end

    def edit

        @project = Project.find(params[:id])
    end

    def update

        @project = Project.find(params[:id])
 
        if @project.update(project_params)
            flash[:success] = "Sucessfully Updated #{@project.project_name}"
            redirect_to action: "index"
        else
            flash[:danger] = "#{@project.errors.full_messages}"
            redirect_to action: "edit"
        end

    end

    def show
        @project = Project.find(params[:id])
        @existing_users = @project.users
        @count1 = @existing_users.count
        if @count1>0
            @existing_users.reject {|u| u.id == current_user.id}
            @count1 = @count1 -1
        end


    end


    
    def project_params
        params.require(:project).permit(:project_name , :description) 
    end
end