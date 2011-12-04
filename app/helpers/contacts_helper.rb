module ContactsHelper
  def formatted_address(user)
    city_and_state = ""
    city_and_state += user.city if user.city.present?
    city_and_state += ", " + user.state if user.city.present? and user.state.present?

    address = ""
    address += user.address if user.address.present?
        
    address += "<br />" if !address.empty?
    
    address += user.zip_code if user.zip_code.present?
    address += " - " if user.zip_code.present? and !city_and_state.empty?
    address += city_and_state
    
    address.html_safe
  end
  
  def formatted_phones(user)
    @phones = Array.new
    @phones << user.phone if user.phone.present?
    @phones << user.mobile if user.mobile.present?
    @phones.to_sentence
  end
  
  def contact_avatar(contact)
    @url = "/images/avatar.png"
    @url = contact.avatar_url(:thumb) if contact.avatar?
    
    @element = "<div class='contact_avatar_wrapper'>"
    @element += image_tag @url, :class => "contact_avatar"
    @element += "</div>"
    @element.html_safe
  end
  
  def facebook_avatar(contact)
    image_tag "http://graph.facebook.com/#{contact.facebook_id}/picture?type=large"
  end
  
  def sidebar_links(contact)
  
    links = {
      "1" => { :title => "Pagina do contato", :path => contact_path(contact) },
      "2" => { :title => "Alterar dados do cadastro", :path => edit_contact_path(contact) },
      "3" => { :title => "Alterar foto", :path => avatar_contact_path(contact) },
      "4" => { :title => "Remover contato", :path => confirm_destroy_contact_path(contact) }
    }
    
    @lista = ""
    links.map do |key, value|
      classname = "selected" if value[:path] == request.fullpath
      last = "last" if key.to_i == links.size
      @lista+="<li class=\"#{classname} #{last}\">#{link_to(value[:title], value[:path])}</li>"
    end
    @lista.html_safe
  end
end
