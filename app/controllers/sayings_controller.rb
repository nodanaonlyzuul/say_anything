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
      redirect_to saying_path(1, {words: @saying.words})
    else
      # TODO: amusing error page
    end
  end

  def show
    @saying = Saying.new()
    @saying.words = params[:words]

    # Example usage: pico2wave -w=hello.wav "Hello my love, I heard a kiss from you"
    if @saying.valid?
      path = File.join(Rails.root, 'public', 'sayings', filename_for(@saying))
      system('pico2wave', "-w=#{path}", @saying.words)
      system('ffmpeg', '-y', '-i', path, path.gsub('wav', 'mp3'))
    else
    end
  end

  private

  def saying_params
    params.require(:saying).permit(:voice, :words)
  end

  def filename_for(saying)
    "#{Digest::SHA1.hexdigest(@saying.words)}.wav"
  end
end
