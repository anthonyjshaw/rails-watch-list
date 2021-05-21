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
    @results = List.where('lower(name) LIKE ?', "%#{params[:name].downcase}%")
    @results = if params[:name].empty?
                 @message = "You didn't enter anything!"
                 zero_results
               elsif @results.count.zero?
                 @message = "No results for #{params[:name]}."
                 zero_results
               else
                 @count = @results.count
                 @message = "Here are all the results for #{params[:name]}:"
                 List.where('name LIKE ?', "%#{params[:name]}%")

               end
  end

  private

  def zero_results
    @count = 0
    []
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
