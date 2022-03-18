class ParserController < ApplicationController
    def index
        require 'json'
        require 'httparty'
        base_url = 'https://api.opendata.onisep.fr/api/1.0/dataset/605344579a7d7/search?size=10'
        response = HTTParty.get(base_url)
        json = JSON.parse(response.body)

        json["results"].each do |school|
            puts "établissement --"
            school.each do |key, value|
                schoolsInfo = [
                    "lieu_denseignement_ens_libelle",
                    "ens_code_postal",
                    "ens_commune",
                    "ens_region"
                ]
                for i in 0..schoolsInfo.length
                    if key = key[schoolsInfo[i]]
                        puts "#{key} : #{value}"
                    end
                end

                # if key == key['lieu_denseignement_ens_libelle']
                #     puts "Établissement : #{value}"   
                # elsif 
                #     key == key['ens_code_postal']
                #     puts "Code postal : #{value}"   
                # elsif 
                #     key == key['ens_commune']
                #     puts "Commune : #{value}"   
                # elsif 
                #     key == key['ens_region']
                #     puts "Région : #{value}" 
                # end
            end
        end

    end
end
