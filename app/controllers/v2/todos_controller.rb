class V2::TodosController < ApplicationController
  def index
    json_response({ message: 'This is the verion 2 of Todos' })
  end
end
