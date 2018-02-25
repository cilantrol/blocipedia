class WikisController < ApplicationController
  # before_action :set
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :set_wiki, only: [:edit, :update, :destroy, :show]

  # before_action :verify_authorized, except: [:index, :show]
  after_action :verify_authorized, except: :index

  # after_initialize

  def index
    @wikis = Wiki.all
    # authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
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

  def set_wiki
    @wiki = Wiki.find(params[:id])
    # authorize @wiki
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :public)
  end

end
