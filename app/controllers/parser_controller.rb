class ParserController < ApplicationController
    def index
        require 'json'
        require 'httparty'
        base_url = 'https://api.opendata.onisep.fr/api/1.0/dataset/605344579a7d7/search?size=10'
        response = HTTParty.get(base_url)
        json = JSON.parse(response.body)

        json["results"].each do |school|
            puts "établissement --"
            schoolsInfo = [
                "action_de_formation_af_identifiant_onisep",
                "formation_for_libelle",
                "for_url_et_id_onisep",
                "for_indexation_domaine_web_onisep",
                "for_type",
                "for_nature_du_certificat",
                "for_niveau_de_sortie",
                "lieu_denseignement_ens_libelle",
                "ens_commune",
                "ens_statut",
                "ens_adresse",
                "ens_code_postal",
                "ens_departement",
                "ens_academie",
                "ens_region",
                "ens_n_telephone",
                "ens_site_web",
                "ens_hebergement",
                "ens_accessibilite",
                "af_modalites_scolarite",
                "af_elements_denseignement",
                "af_cout_scolarite",
                "af_cout_dinscription"
            ]
            school.each do |key, value|
                if schoolsInfo.include? key
                    puts "#{key} : #{value}"
                end
            end
        end
    end
end
