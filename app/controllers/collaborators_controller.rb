class CollaboratorsController < ApplicationController
  before_action :require_sign_in

  def display
    @collaborator = Collaborator.find(params[:id])
  end


  def new
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:id])
    @user = User.find(params[:id])
    # @collaborator = @wiki.collaborators.new(:user_id => params[:collaborator][:user_id])
    @collaborator = Collaborator.new
    @collaborator.user_id = @user
    @collaborator.wiki_id = @wiki

    if collaborator.save
      flash[:notice] = "Collaborator added."
      redirect_to @wiki
    else
      flash[:alert] = "failed."
      redirect_to root_path
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    collaborator = current_user.collaborator.build(post: wiki)

    if collaborator.destroy
      flash[:notice] = "Collaborator removed."
      redirect_to @wiki
    else
      flash[:alert] = "failed."
      redirect_to edit_wiki_path(@wiki)
    end
  end
end