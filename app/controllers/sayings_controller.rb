require 'tempfile'
require 'digest'

class SayingsController < ApplicationController
  helper_method :filename_for
  def new
    @saying = Saying.new
  end

  def create
    @saying = Saying.new(saying_params)
    if @saying.valid?
      redirect_to saying_path(@saying.voice, {words: @saying.words})
    else
      # TODO: amusing error page
    end
  end

  def show
    @saying = Saying.new()
    @saying.voice = params[:id]
    @saying.words = params[:words]

    if @saying.valid?
      path = File.join(Rails.root, 'public', 'sayings', filename_for(@saying))
      system(voice_command, '-v', @saying.voice, @saying.words, '-o', path)
        system('ffmpeg', '-y', '-i', path, path.gsub('aiff', 'mp3'))
    else
    end
  end

  private

  def saying_params
    params.require(:saying).permit(:voice, :words)
  end

  def filename_for(saying)
    "#{@saying.voice}_#{Digest::SHA1.hexdigest(@saying.words)}.aiff"
  end
end
