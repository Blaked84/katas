require 'json'
require 'byebug'

module FileDb
  class Database

    attr_reader :data

    def initialize(data_file)

      data_json = File.read(data_file)
      @data = JSON.parse(data_json)
    end

    def table_names
      @data.keys.reverse
    end

    def table(name)
      FileDb::Table.find_by_name(self.data, name)
    end
  end
end
