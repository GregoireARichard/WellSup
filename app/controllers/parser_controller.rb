class ParserController < ApplicationController
    def index
        require 'json'
        require 'httparty'
        for i in 0..34
            base_url = "https://api.opendata.onisep.fr/api/1.0/dataset/605344579a7d7/search?size=1000&from=#{i*1000}"
            response = HTTParty.get(base_url)
            json = JSON.parse(response.body)
    
            json["results"].each do |school|
                if school["ens_hebergement"] == "sans hébergement"
                    school["ens_hebergement"] = false
                else 
                    school["ens_hebergement"] = true
                end
                if school["ens_accessibilite"] == ""
                    school["ens_accessibilite"] = false
                else 
                    school["ens_accessibilite"] = true
                end
                school["ens_code_postal"] = school["ens_code_postal"].to_i
                puts school["ens_code_postal"]
                University.create({
                    action_de_formation_af_identifiant_onisep: school["action_de_formation_af_identifiant_onisep"],
                    formation_for_libelle: school["formation_for_libelle"],
                    for_url_et_id_onisep: school["for_url_et_id_onisep"],
                    for_indexation_domaine_web_onisep: school["for_indexation_domaine_web_onisep"],
                    for_type: school["for_type"],
                    for_nature_du_certificat: school["for_nature_du_certificat"],
                    for_niveau_de_sortie: school["for_niveau_de_sortie"],
                    lieu_denseignement_ens_libelle: school["lieu_denseignement_ens_libelle"],
                    ens_commune: school["ens_commune"],
                    ens_statut: school["ens_statut"],
                    ens_adresse: school["ens_adresse"],
                    ens_code_postal: school["ens_code_postal"],
                    ens_departement: school["ens_departement"],
                    ens_academie: school["ens_academie"],
                    ens_region: school["ens_region"],
                    ens_n_telephone: school["ens_n_telephone"],
                    ens_site_web: school["ens_site_web"],
                    ens_hebergement: school["ens_hebergement"],
                    ens_accessibilite: school["ens_accessibilite"],
                    af_modalites_scolarite: school["af_modalites_scolarite"],
                    af_elements_denseignement: school["af_elements_denseignement"],
                    af_cout_scolarite: school["af_cout_scolarite"],
                    af_cout_dinscription: school["af_cout_dinscription"]
    
                })
            end
        end
    end
end
