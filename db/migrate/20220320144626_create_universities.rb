class CreateUniversities < ActiveRecord::Migration[6.1]
  def change
    create_table :universities do |t|
      t.string :action_de_formation_af_identifiant_onisep
      t.string :formation_for_libelle
      t.string :for_url_et_id_onisep
      t.string :for_indexation_domaine_web_onisep
      t.string :for_type
      t.string :for_nature_du_certificat
      t.string :for_niveau_de_sortie
      t.string :lieu_denseignement_ens_libelle
      t.string :ens_commune
      t.string :ens_statut
      t.string :ens_adresse
      t.integer :ens_code_postal
      t.string :ens_departement
      t.string :ens_academie
      t.string :ens_region
      t.string :ens_n_telephone
      t.string :ens_site_web
      t.boolean :ens_hebergement
      t.boolean :ens_accessibilite
      t.string :af_modalites_scolarite
      t.string :af_elements_denseignement
      t.string :af_cout_scolarite
      t.string :af_cout_dinscription

      t.timestamps
    end
  end
end
