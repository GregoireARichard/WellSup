class RequestController < ApplicationController
    def index
        frontReq = request.params
        frontReq.each do |key, value|
            puts key + ' : ' + value 
        end

        # Setting up the variables for the SQL query

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

        request = "SELECT lieu_denseignement_ens_libelle, formation_for_libelle, for_niveau_de_sortie, for_indexation_domaine_web_onisep, ens_site_web, ens_n_telephone FROM universities"
        # Global part
        request += " WHERE for_niveau_de_sortie #{for_niveau_de_sortie} 'Bac + 3'" #Niveau de sortie
        request += " AND af_modalites_scolarite LIKE '%apprentissage%'" if (frontReq['alternship'])
        request += " AND ens_statut #{ens_statut}"
        request += " AND for_nature_du_certificat NOT IN ('non certifiant','Certificat d''école')" if frontReq['stateRecognized']
        request += " AND ens_region = 'Ile-de-France'" if frontReq['idf']
        request += " AND ens_commune IN #{bigTowns}" if frontReq['bigTown']
        # Chosen themes
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
        request += " LIMIT 3"

        # Send the SQL Query
        sqlQuery = (ActiveRecord::Base.connection.execute(request))

        # Send the link to the front-end, with the selected schools
        urlToSend = "https://zippy-smakager-c1ceed.netlify.app/results?q=ok&"

        replacements = {
            '/' => ',',
            '| ' => ',',
            ' - ' => ',',
            ', ' => ',',
            ' (généralités)' => ''
        }

        i = 1
        sqlQuery.each do |ecole|
            urlToSend += "ecole#{i}=#{ecole['lieu_denseignement_ens_libelle']}&"
            urlToSend += "formation#{i}=#{ecole['formation_for_libelle']}&"
            urlToSend += "duree#{i}=#{ecole['for_niveau_de_sortie']}&"
            categories = ecole['for_indexation_domaine_web_onisep'].gsub(Regexp.union(replacements.keys), replacements)
            categories = categories.split(",").uniq
            urlToSend += "description#{i}=#{categories.join(',')}&"
            urlToSend += "site#{i}=#{ecole['ens_site_web']}&"
            urlToSend += "tel#{i}=#{ecole['ens_n_telephone']}&"
            i += 1
        end
        urlToSend.delete_suffix!('&')

        redirect_to urlToSend
    end
end