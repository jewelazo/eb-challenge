class ApplicationController < ActionController::Base
    BASE_URL="https://api.stagingeb.com/v1"
    PARTIAL_URL_INITIAL_PAGE="/properties?page=1&limit=15&search%5Bstatuses%5D%5B%5D=published"
    API_KEY={ "X-Authorization" => "l7u502p8v46ba3ppgvj5y2aad50lb9"}
end
