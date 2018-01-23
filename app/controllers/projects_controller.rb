class ProjectsController < ApplicationController

    def new 
        @project = Project.new
    end

    def create
        @project = Project.new(project_params)
        @project.user_id = current_user.id
        if @project.save
            
            flash[:success] = "Sucessfully Created #{@project.project_name}"
            render 'projects/new'
        else      
            flash[:success] = "Already Created #{@project.project_name}"
            render 'projects/new'
        end
    end
    
    def project_params
        params.require(:project).permit(:project_name) 
    end
end