class BookmarksController < ApplicationController

  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    # @movie = Movie.find(params[:bookmark][:movie_id])
    @bookmark = Bookmark.new(bookmark_params)

    @bookmark.list = @list
    # @bookmark.movie = @movie

    if @bookmark.save!
      redirect_to list_path(@list)
    else
      render :new
    end
  end

    def destroy
      @bookmark = Bookmark.find(params[:id])
      if @bookmark.destroy
      redirect_to list_path(@bookmark.list)
      else
        redirect_to list_path(@list)
      end
    end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end
end
