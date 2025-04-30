
class MacrosController < ApplicationController
  def display_form
    render({ :template => "macro_templates/new_form" })
  end

  def receive_form
    @the_description = params.fetch("description_param")
    @the_image = params.fetch("image_param")

    @the_image_converted = DataURI.convert(@the_image)
    
    c = OpenAI::Chat.new
    c.system("You are my food expert. Estimate how long is it to finish a Giodarno deep dish.")
    c.user(@the_description, image: @the_image)
    @result = c.assistant!
    render ({:template => "macro_templates/receive_info" })
  end
end 
