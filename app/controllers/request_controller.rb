class RequestController < ApplicationController
    def index
        frontReq = request.params
        frontReq.each do |key, value|
            puts key + ' : ' + value 
        end

        # Mise en place des variables pour la query SQL

        # frontReq = {
        #     "yoStudy"=>"false", 
        #     "paid"=>"false", 
        #     "alternship"=>"false", 
        #     "stateRecognized"=>"false", 
        #     "location"=>"true", 
        #     "idf"=>"true", 
        #     "bigTown"=>"null", 
        #     "theme1"=>"agriculture", 
        #     "theme2"=>"animaux", 
        #     "theme3"=>"agroalimentaire"
        # }

        frontReq.each do |key, value|
            frontReq[key] = true if (frontReq[key] == "true")
            frontReq[key] = false if (frontReq[key] == "false")
            frontReq[key] = nil if (frontReq[key] == "null")
        end

        bigTowns = "('Bordeaux', 'Marseille', 'Lyon')"

        if frontReq['yoStudy'] == true
            for_niveau_de_sortie = ">"
        else
            for_niveau_de_sortie = "<"
        end

        if frontReq['paid'] == true
            ens_statut = "= 'public'"
        else
            ens_statut = "<> 'public'"
        end

        request = "SELECT id FROM universities"
        # Partie globale
        request += " WHERE for_niveau_de_sortie #{for_niveau_de_sortie} 'Bac + 3'" #Niveau de sortie
        request += " AND af_modalites_scolarite LIKE '%apprentissage%'" if (frontReq['alternship'])
        request += " AND ens_statut #{ens_statut}"
        request += " AND for_nature_du_certificat NOT IN ('non certifiant','Certificat d''école')" if frontReq['stateRecognized']
        request += " AND ens_region = 'Ile-de-France'" if frontReq['idf']
        request += " AND ens_commune IN #{bigTowns}" if frontReq['bigTown']
        # Thèmes choisis
        request += " AND ("
        i = 1
        loop do
            selectedTheme = "theme" + i.to_s
            nextTheme = "theme" + (i+1).to_s
            break if frontReq[selectedTheme] == nil
            request += " for_indexation_domaine_web_onisep LIKE '%#{frontReq[selectedTheme]}%'"
            if frontReq[nextTheme] == nil
                request += ")"
            else
                request += " OR" if frontReq[nextTheme] != nil
            end
            i += 1
        end

        puts ActiveRecord::Base.connection.execute(request)
    end
end