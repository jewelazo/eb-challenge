class PropertiesController < ApplicationController
    include HTTParty
    def index
        response=HTTParty.get("https://api.stagingeb.com/v1/properties?page=1&limit=15&search%5Bstatuses%5D%5B%5D=published",
                    headers: { "X-Authorization" => "l7u502p8v46ba3ppgvj5y2aad50lb9"})
        @properties=JSON.parse(response.body,symbolize_names: true)[:content]
    end

    def show
        response=HTTParty.get("https://api.stagingeb.com/v1/properties/#{params[:id]}",
            headers: { "X-Authorization" => "l7u502p8v46ba3ppgvj5y2aad50lb9"})
        @property=JSON.parse(response.body,symbolize_names: true)
    end

    def create_contact

    end

    private
    def property_params
        params.require(:property).permit(:name,:phone,:email,:message)
    end
end
