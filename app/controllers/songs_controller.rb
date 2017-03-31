class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:song_id])

    @lists = Playlist.where(song:params[:song_id])
  end

  def create
    song = Song.new(song_params)
    if song.valid?
      song.save
    else 
      flash[:errors] = song.errors.messages
    end

    redirect_to '/songs'
  end

  def add
    user = User.find(session[:user_id])
    song = Song.find(params[:song_id])
    record = Playlist.where(user:user, song:song)

    if record.length > 0
      record[0]['times_add'] = record[0]['times_add'] + 1
      record[0].save
    else
      Playlist.create(user: user, song: song, times_add: 1)
    end

    redirect_to '/songs'
  end

  private 
  def song_params
   params.require(:song).permit(:artist, :title)
  end
end
