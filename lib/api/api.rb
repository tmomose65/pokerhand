class API < Grape::API
  prefix "api"
  format :json
  mount Card_API

end
