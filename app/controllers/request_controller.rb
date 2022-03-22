class RequestController < ApplicationController
    def index
        def urlGetter
            puts base_url + original_fullpath
        end
    end
    ActiveRecord::Base.connection.execute("SELECT * FROM universities WHERE id = 17661")
end