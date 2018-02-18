class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :wiki_owner?, only: [:destroy]

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

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
  end

  def update
    @wiki = Wiki.find(params[:id])
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
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :public)
  end

  # def wiki_owner?
  #   @wiki = Wiki.find(params[:id])

  #   if @wiki.user == @user
  #     flash[:alert] = "Wiki Deleted"
  #     redirect_to(wiki_path(@wiki.id))
  #   else
  #     flash[:alert] = "You do not have permission to delete this Wiki"
  #   end
  # end


end
