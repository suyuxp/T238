# ----------------------------------------------------
# 在非产品模式，可以支持 CORS
# ----------------------------------------------------
unless ENV["RACK_ENV"] == "production"
  require "rack/cors"
  use Rack::Cors do
    allow do
      origins "*"
      resource "*", headers: :any, methods: [:get, :post, :put, :delete, :options]
    end
  end
end

# ----------------------------------------------------
# 启动应用
# ----------------------------------------------------
require "./app"
run CLOAP::API
