require 'salesforce_bulk'

class Gem_desafio_rd
  def initialize(username, password, token)
   @salesforce = SalesforceBulk::Api.new(username, password+""+token)
  end 

  def insert(subject, name, type)
    new_account = Hash["name" => name, "type" => type] # Add as many fields per record as needed.
    records_to_insert = Array.new
    records_to_insert.push(new_account) # You can add as many records as you want here, just keep in mind that Salesforce has governor limits.
    result = @salesforce.create(subject, records_to_insert)
    puts "result is: #{result.inspect}"

  end

  def update(subject,name, id)
    updated_account = Hash["name" => name+" -- Updated", "id" => id] # Nearly identical to an insert, but we need to pass the salesforce id.
    records_to_update = Array.new
    records_to_update.push(updated_account)
    @salesforce.update(subject, records_to_update)
  end

  def delete(subject, id)
    deleted_account = Hash["id" => id] # We only specify the id of the records to delete
    records_to_delete = Array.new
    records_to_delete.push(deleted_account)
    @salesforce.delete(subject, records_to_delete)
  end

  def query(subject, query)
    res = @salesforce.query(subject, query) # We just need to pass the sobject name and the query string
    puts res.result.records.inspect
  end

end
