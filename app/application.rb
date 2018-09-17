class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    puts req.path
    puts req.params
    puts req.params['item']

    if req.path.match '/items/'
      item_req = req.path.split('/items/').last
      item_found = Item.all.find { |i| i.name == item_req }
      if item_found
        resp.write "#{item_req} costs #{item_found.price}."
      else
        resp.write "Item not found."
        resp.status = 400
      end
    else
      resp.write 'Route not found.'
      resp.status = 404
    end
    resp.finish
  end

end
