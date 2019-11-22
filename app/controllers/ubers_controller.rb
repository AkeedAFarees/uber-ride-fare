class UbersController < ApplicationController
  before_action :set_client
  before_action :set_month
  before_action :set_total_amount
  # before_action :set_previous_month, only: [:get_amount_previous_month, :get_personal_amount_previous_month]

  # Todo Show split of each month
  # Todo Get Previous month
  # Todo Show each ride details (Date - Amount)
  # Todo Check for only CC rides

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

  def get_personal_amount
    query = "from:Uber Receipts <uber.pakistan@uber.com>, subject: Personal"
    get_mails(query)
  end

  def get_personal_amount_current_month
    @current_month = Time.current.year.to_s + "/" + Time.current.month.to_s + "/01"
    query = "from:Uber Receipts <uber.pakistan@uber.com>,subject: Personal, after: " + @current_month
    get_mails(query)
  end

  def get_personal_amount_previous_month
    @previous_month = 1.month.ago.year.to_s + "/" + 1.month.ago.month.to_s + "/01"
    query = "from:Uber Receipts <uber.pakistan@uber.com>,subject: Personal, after: " + @previous_month
    get_mails(query)
  end

  def get_total_amount
    query = "from:Uber Receipts <uber.pakistan@uber.com>, subject: !Personal"
    get_mails(query)
  end

  def get_amount_current_month
    @current_month = Time.current.year.to_s + "/" + Time.current.month.to_s + "/01"
    query = "from:Uber Receipts <uber.pakistan@uber.com>, subject: !Personal, after: " + @current_month
    get_mails(query)
  end

  def get_amount_previous_month
    @previous_month = 1.month.ago.year.to_s + "/" + 1.month.ago.month.to_s + "/01"
    @current_month = Time.current.year.to_s + "/" + Time.current.month.to_s + "/01"
    query = "from:Uber Receipts <uber.pakistan@uber.com>, subject: !Personal, after: " + @previous_month + ", before: " + @current_month
    get_mails(query)

  end

  private

  def set_client
    @client = Google::Apis::GmailV1::GmailService.new
    @client.authorization = Token.last.fresh_token
  end

  def set_month
    @month = Date.today.strftime("%B").to_s
    @previous = 1.month.ago.strftime("%B").to_s
  end

  def set_total_amount
    @total_amount = 0
  end

  def get_mails(query)
    @batch = @client.list_user_messages('me', q: query)
    @success = @batch.messages.present? ? true : false

    if @success
      @batch.messages.each do |email|
        message = @client.get_user_message('me', email.id)
        @total_amount += message.snippet.split[1].tr('Rs', '').to_i
      end
    end
  end
end