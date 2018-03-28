class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  after_action :verify_authorized, except: [:index, :show]
  after_action :wiki_private, only: [:update]

  def index
    @wikis = policy_scope(Wiki)
    @wiki = Wiki.new
  end

  def show
    @wiki = Wiki.find(params[:id])
    @users = User.all

    authorize @wiki
  end

# create wiki
# edit Wiki link to collaborator path/edit
# after save redirect to wiki # edit for that id
# create/destroy action
# collaborator path will list all user array

  def new
    @wiki = Wiki.new
    @users = User.all
    @wiki.collaborator = Collaborator.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    @wiki.collaborator = Collaborator.new
    authorize @wiki

    if @wiki.save
      flash[:notice] = "wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "there was an error saving that wiki. please try again."
      render :new
    end

  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_private
    @wiki = Wiki.find(params[:id])
    @wiki.update_attribute(:private, true)
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

end
