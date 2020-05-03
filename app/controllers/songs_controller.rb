class SongsController < ApplicationController
    def index
        @songs = Song.all
    end

    def show
        @song = Song.find(params[:id])
    end

    def new
        @song = Song.new
    end

    def create
        @song = Song.new(song_params)

        if params[:song][:released] == "no" || params[:song][:released] == "No"
            @song.released = false
        else
            @song.released = true
        end

        if @song.save
            redirect_to song_path(@song)
        else
            render :new
        end
    end

    def edit
        @song = Song.find(params[:id])
    end

    def update
        @song = Song.find(params[:id])

        if @song.update(song_params)
            if params[:song][:released] == "no" || params[:song][:released] == "No"
                @song.released = false
                @song.save
            else
                @song.released = true
                @song.save
            end
            redirect_to song_path(@song)
        else
            render :edit
        end
    end

    def destroy
        @song = Song.find(params[:id])
        @song.destroy
        redirect_to songs_path
    end

    private

    def song_params
        params.require(:song).permit(:title, :artist_name, :genre, :released, :release_year)
    end
end