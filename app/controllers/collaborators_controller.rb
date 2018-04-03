class CollaboratorsController < ApplicationController

  def create
    @user = User.find(params[:collaborator][:user])
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(user_id: @user.id, wiki_id: @wiki.id, email: @user.email)

    if @wiki.users.include?(@user)
      @collaborator.destroy
      flash[:alert] = "#{@user.email} has already been added as a collaborator"
      redirect_to edit_wiki_path(@wiki)
    else
      if @collaborator.save
        flash[:notice] = "#{@user.email} added as collaborator"
      else
        flash[:alert] = "failed"
      end
      redirect_to edit_wiki_path(@wiki)
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @wiki = Wiki.find(params[:wiki_id])
    @cid = Collaborator.find(params[:collaborator_id])

    @collaborator = Collaborator.where(params[collaborator_id: @cid.id, user_id: @user.id, wiki_id: @wiki.id])

    if @collaborator.destroy(@cid.id)
      flash[:notice] = "Collaborator has been removed"
    else
      flash[:alert] = "failed to remove collab"
    end
    redirect_to edit_wiki_path(@wiki)
  end

end