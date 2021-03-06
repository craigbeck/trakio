class StoriesController < ApplicationController

  # TODO - should only let user create story for projects they have access to
  def create
    render json: Story.create(create_params.merge!(reporter_id: current_user.id))
  end

  def update
    story = Story.find(params[:id])
    unless current_user.projects.include? story.project
      render json: { message: "You do not have permission to modify this story." }, status: 403
    else
      attributes = update_params
      attributes[:assignee] = current_user if attributes[:state] == 'started'
      story.update_attributes(attributes)
      render json: story
    end
  end

  def destroy
    story = Story.find(params[:id])
    unless current_user.projects.include? story.project
      render json: { message: "You do not have permission to delete this story." }, status: 403
    else
      story.destroy
      render json: {}, status: 200
    end
  end

  private
  def create_params
    params.require(:story).permit(:title, :description, :story_type, :project_id, :state)
  end

  def update_params
    params.require(:story).permit(:title, :description, :story_type, :state, :position)
  end

end
