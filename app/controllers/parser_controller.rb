class ParserController < ApplicationController
    def index
        require 'json'
        require 'httparty'
        response = HTTParty.get(base_url)
        json = JSON.parse(response.body)
        count = 0
        
        json["results"].each do |school|
            school.each do |key, value|
                if key == key['lieu_denseignement_ens_libelle']
                    puts "#{value}"
                end
            end
        end

    end
end
