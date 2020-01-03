require 'sinatra/base'
require 'easypost'
require './lib/helpers'

class App < Sinatra::Base
  require 'tilt/erb' if development?
  require 'pry' if development?

  set :show_exceptions, :after_handler
  enable :sessions
  helpers Helpers

  configure do
    EasyPost.api_key = ENV['EASYPOST_API_KEY']
    set :addr_verification, {verify_strict: ['delivery','zip4']}
  end

  get '/' do
    redirect '/shipment'
  end

  get '/shipment' do
    erb :index
  end

  post '/shipment' do
    begin
      from_address =  if params[:verify_from] == "true"
                        EasyPost::Address.create(params[:from_address].merge(settings.addr_verification))
                      else
                        params[:from_address]
                      end
      to_address =    if params[:verify_to] == "true"
                        EasyPost::Address.create(params[:to_address].merge(settings.addr_verification))
                      else
                        params[:to_address]
                      end
      shipment = EasyPost::Shipment.create(
        from_address: from_address,
        to_address: to_address,
        parcel: params[:parcel],
        options: {
          delivery_confirmation: params[:delivery_confirmation],
        },
      )
      redirect "shipment/#{shipment.id}/rates"
    rescue EasyPost::Error => e
      erb :index, locals: {
        exception: e
      }
    end
  end

  get '/shipment/:id/rates' do
    shipment = retrieve_shipment
    erb :rate, locals: {shipment: shipment}
  end

  post '/shipment/:id/buy' do
    shipment = retrieve_shipment
    begin
      shipment.buy(rate: {id: params[:rate]})
      raise "Failed to buy label" unless shipment.postage_label
      redirect "shipment/#{shipment.id}"
    rescue EasyPost::Error => e
      halt 400, erb(:rate, locals: {exception: e})
    end
  end

  get '/shipment/:id' do
    erb :shipment, locals: {shipment: retrieve_shipment}
  end

  run! if app_file == $0
end
