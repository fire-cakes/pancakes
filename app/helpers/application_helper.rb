# frozen_string_literal: true
def flash_message(type, text)
  flash[type] ||= []
  flash[type] << text
end

def render_flash
  flash_array = []
  flash.each do |type, messages|
    messages.each do |m|
      unless m.blank?
        flash_array << render(partial: 'shared/flash',
                              locals: { type: type, message: m })
      end
    end
  end

  flash_array.join('').safe_join
end