# frozen_string_literal: true

class ListsController < ApplicationController

  def about
  end

  def index
    @lists = List.all
    @images = Dir.entries('app/assets/images')
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
    @comment = Comment.new
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_path
    else
      render :new
    end
  end

  def search
    @results = List.where('name LIKE ?', "%#{params[:name]}%")
    @results = if params[:name].empty?
                 empty_results
               elsif @results.count.zero?
                 zero_results
               else
                 @count = @results.count
                 @message = "Here are all the results for #{params[:name]}:"
                 List.where('name LIKE ?', "%#{params[:name]}%")
               end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path
  end

  private

  def empty_results
    @message = "You didn't enter anything!"
    @count = 0
    []
  end

  def zero_results
    @message = "No results for #{params[:name]}."
    @count = 0
    zero_results
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
