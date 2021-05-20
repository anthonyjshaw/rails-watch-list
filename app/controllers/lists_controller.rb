# frozen_string_literal: true

class ListsController < ApplicationController
  def index
    @lists = List.all
    @images = Dir.entries('app/assets/images')
  end

  def show
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def search
    @results = List.where('name LIKE ?', "%#{params[:name]}%")
    @results = if params[:name].nil?
                 @message = "You didn't enter anything!"
                 zero_results
               elsif @results.count.zero?
                 @message = "No results for #{params[:name]}."
                 @count = 0
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

  def zero_results
    @count = 0
    []
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
