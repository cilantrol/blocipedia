class CollaboratorsController < ApplicationController
  before_action :require_sign_in

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find(params[:user_id])
    collaborator = current_user.collaborator.build(post: wiki)

    if collaborator.save
      flash[:notice] = "Collaborator added."
      redirect_to @wiki
    else
      flash[:alert] = "failed."
      redirect_to root_path
    end
  end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    collaborator = current_user.collaborator.build(post: wiki)

    if collaborator.destroy
      flash[:notice] = "Collaborator removed."
      redirect_to @wiki
    else
      flash[:alert] = "failed."
      redirect_to edit_wiki_path(@wiki)
    end
end
