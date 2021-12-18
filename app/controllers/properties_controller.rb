class PropertiesController < ApplicationController
    include HTTParty
    BASE_URL="https://api.stagingeb.com/v1"
    PARTIAL_URL_INITIAL_PAGE="/properties?page=1&limit=15&search%5Bstatuses%5D%5B%5D=published"
    def index
        response=HTTParty.get("#{BASE_URL}#{PARTIAL_URL_INITIAL_PAGE}",
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
            flash.alert = "You must specify a contact source"
            redirect_to "/properties/#{params[:property_id]}"
        end
    end

    private
    def contact_params
        params.require(:contact).permit(:name,:phone,:email,:message)
    end
end
