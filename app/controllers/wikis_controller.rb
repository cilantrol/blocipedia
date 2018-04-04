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

  def new
    @wiki = Wiki.new
    @users = User.all
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
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
    @user = current_user
    @add_collaborators = User.where.not(id: current_user.id)
    @cs = Collaborator.all
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.assign_attributes(wiki_params)


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
