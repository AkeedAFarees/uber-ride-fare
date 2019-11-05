class UbersController < ApplicationController
  before_action :set_client
  before_action :set_month
  before_action :set_total_amount

  def form
    @month = Time.current.strftime("%B")
  end

  def get_by_label
    @batch = @client.list_user_messages('me', label_ids: 'Label_8902922992905552214')
    @batch.messages.each do |email|
      message = @client.get_user_message('me', email.id)
      @total_amount += message.snippet.split[1].tr('Rs', '').to_i
    end
  end

  def get_total_amount
    @batch = @client.list_user_messages('me', q: "from:Uber Receipts <uber.pakistan@uber.com>")
    @batch.messages.each do |email|
      message = @client.get_user_message('me', email.id)
      @total_amount += message.snippet.split[1].tr('Rs', '').to_i
    end
  end

  def get_amount_current_month
    @current_month = Time.current.year.to_s + "/" + Time.current.month.to_s + "/01"
    @batch = @client.list_user_messages('me', q: "from:Uber Receipts <uber.pakistan@uber.com>, after: " + @current_month)
    @batch.messages.each do |email|
      message = @client.get_user_message('me', email.id)
      @total_amount += message.snippet.split[1].tr('Rs', '').to_i
    end
  end

  private

  def set_client
    @client = Google::Apis::GmailV1::GmailService.new
    @client.authorization = Token.last.fresh_token
  end

  def set_month
    @month = Date.today.strftime("%B").to_s
  end

  def set_total_amount
    @total_amount = 0
  end
end