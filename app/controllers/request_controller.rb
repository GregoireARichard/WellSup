class RequestController < ApplicationController
    def index
        frontReq = request.params
        frontReq.each do |key, value|
            puts key + ' : ' + value 
        end
        parameters = ["ex", "djd", "djdpd"]
        request = HTTParty.post("http://localhost:3000/axiosTests/?ex=#{parameters[0]}&exe=#{parameters[1]}&exee=#{parameters[2]}")
    end
    #research =  ActiveRecord::Base.connection.execute("SELECT * FROM universities WHERE ID = 17679")
end