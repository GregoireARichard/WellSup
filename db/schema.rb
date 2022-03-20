# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_20_144626) do

  create_table "universities", force: :cascade do |t|
    t.string "action_de_formation_af_identifiant_onisep"
    t.string "formation_for_libelle"
    t.string "for_url_et_id_onisep"
    t.string "for_indexation_domaine_web_onisep"
    t.string "for_type"
    t.string "for_nature_du_certificat"
    t.string "for_niveau_de_sortie"
    t.string "lieu_denseignement_ens_libelle"
    t.string "ens_commune"
    t.string "ens_statut"
    t.string "ens_adresse"
    t.integer "ens_code_postal"
    t.string "ens_departement"
    t.string "ens_academie"
    t.string "ens_region"
    t.string "ens_n_telephone"
    t.string "ens_site_web"
    t.boolean "ens_hebergement"
    t.boolean "ens_accessibilite"
    t.string "af_modalites_scolarite"
    t.string "af_elements_denseignement"
    t.string "af_cout_scolarite"
    t.string "af_cout_dinscription"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
