module ApplicationHelper
  def all_voices
    Rails.cache.read('voices')
  end

  def voice_command
    Rails.cache.read('cmd')
  end
end
