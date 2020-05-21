class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all).serializable_hash
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id])).serializable_hash
  end

  def create
    merchant = Merchant.create(merchant_params)
    if merchant.save
      render json: MerchantSerializer.new(merchant)
    end
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    if merchant.save
      render json: MerchantSerializer.new(merchant)
    end
  end

  def destroy
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
    merchant.destroy
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
