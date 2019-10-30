require 'pp'
require 'google/apis/gmail_v1'

namespace :uber do

  task :label => :environment do
    client = Google::Apis::GmailV1::GmailService.new
    client.authorization = Token.last.fresh_token

    @total_amount = 0
    @month = Date.today.strftime("%B").to_s

    batch = client.list_user_messages('me', label_ids: 'Label_8902922992905552214')
    batch.messages.each do |email|
      message = client.get_user_message('me', email.id)
      @total_amount += message.snippet.split[1].tr('Rs','').to_i
    end
    puts 'Total Rides: ' + batch.messages.count.to_s
    puts "Total amount spent in " + @month + ": Rs." + @total_amount.to_s
  end

  task :sender => :environment do
    client = Google::Apis::GmailV1::GmailService.new
    client.authorization = Token.last.fresh_token

    @total_amount = 0
    @month = Date.today.strftime("%B").to_s

    batch = client.list_user_messages('me', q: "from:Uber Receipts <uber.pakistan@uber.com>")
    batch.messages.each do |email|
      message = client.get_user_message('me', email.id)
      @total_amount += message.snippet.split[1].tr('Rs','').to_i
    end
    puts "Total Rides: " + batch.messages.count.to_s
    puts "Total amount spent in " + @month + ": Rs." + @total_amount.to_s
  end

  task :get_labels => :environment do
    client = Google::Apis::GmailV1::GmailService.new
    client.authorization = Token.last.fresh_token
    result = client.list_user_labels('me')
    pp JSON.parse(result.to_json)
  end
end