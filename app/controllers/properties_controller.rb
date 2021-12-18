class PropertiesController < ApplicationController
    include HTTParty
    BASE_URL="https://api.stagingeb.com/v1"
    def index
        response=HTTParty.get("#{BASE_URL}/properties?page=1&limit=15&search%5Bstatuses%5D%5B%5D=published",
                    headers: { "X-Authorization" => "l7u502p8v46ba3ppgvj5y2aad50lb9"})
        @properties=JSON.parse(response.body,symbolize_names: true)[:content]
    end

    def show
        response=HTTParty.get("#{BASE_URL}/properties/#{params[:id]}",
            headers: { "X-Authorization" => "l7u502p8v46ba3ppgvj5y2aad50lb9"})
        @property=JSON.parse(response.body,symbolize_names: true)
        @new_contact=Contact.new
    end

    def create_contact
        @new_contact=Contact.new(contact_params)
        @new_contact.property_id=params[:property_id]
        contact=@new_contact.attributes.slice("name","phone",'email','property_id','message')
        contact["source"]="giandomain.com"
        options = {
            headers: { "Content-Type"=> "application/json" ,
            "X-Authorization" => "l7u502p8v46ba3ppgvj5y2aad50lb9"
            },
            body: contact.to_json
        }
        response=HTTParty.post("#{BASE_URL}/contact_requests",options)
        if response.success?
            flash.notice = "Message sent correctly"
            redirect_to root_path
        else
            response=HTTParty.get("#{BASE_URL}/properties/#{params[:property_id]}",
                headers: { "X-Authorization" => "l7u502p8v46ba3ppgvj5y2aad50lb9"})
            @property=JSON.parse(response.body,symbolize_names: true)
            flash.alert = "You must specify a contact source"
            redirect_to "/properties/#{@property[:public_id]}/new_contact"
        end
    end

    private
    def contact_params
        params.require(:contact).permit(:name,:phone,:email,:message)
    end
end
