class ParserController < ApplicationController
    def index
        require 'json'
        json_file = File.join(Rails.root, 'app', 'assets', 'test.json')

        File.open(json_file, 'r') do |json_file|

            json_file.each do |json_files|   
                hash = JSON.parse(json_file)
            end
         end
        #hash = JSON.parse(file)
        
        hash['nom'].each do |nom|
            puts nom
        end
    end
end
