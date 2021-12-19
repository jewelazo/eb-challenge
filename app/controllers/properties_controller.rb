class PropertiesController < ApplicationController
    include HTTParty
    
    def index
        response=HTTParty.get("#{BASE_URL}#{PARTIAL_URL_INITIAL_PAGE}",headers: API_KEY)
        @properties=JSON.parse(response.body,symbolize_names: true)[:content]
    end

    def show
        response=HTTParty.get("#{BASE_URL}/properties/#{params[:id]}",headers: API_KEY)
        @property=JSON.parse(response.body,symbolize_names: true)
        @new_contact=Contact.new
    end

    def create_contact
        @new_contact=Contact.new(contact_params)
        @new_contact.property_id=params[:property_id]
        contact=@new_contact.attributes.slice("name","phone",'email','property_id','message')
        contact["source"]="giandomain.com"
        options = {
            headers: {
                'Content-Type'=>'application/json',
                'X-Authorization'=> API_KEY["X-Authorization"]
            },
            body: contact.to_json
        }
        response=HTTParty.post("#{BASE_URL}/contact_requests",options)
        if response.success?
            flash.notice = "Message sent correctly"
            redirect_to root_path
        else
            flash.alert = "You must specify a contact source"
            redirect_to "/properties/#{params[:property_id]}"
        end
    end

    private
    def contact_params
        params.require(:contact).permit(:name,:phone,:email,:message)
    end
end
