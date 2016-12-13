module FileDb
  class Table
    attr_reader :data, :name, :database

    def initialize(data=nil, table_mane=nil, database_name=nil)
      @data = data
      @name = table_mane
      @database = database_name
    end

    def self.find_by_name(db, name)
      table = self.new(db.data[name], name)
      return table
    end


    def select(args = nil)
      if args.nil?
        # if no parameter, return full data collection
        self.data
      else
        where_condition = args[:where]
        key = where_condition.keys.first.to_s
        value_to_match = where_condition.values.first
        self.data.select{ |x| x[key] == value_to_match }
      end
    end

    def insert(args = nil)
      if args.nil?
        raise "You can't insert nothing dude !"
      elsif !args.is_a?(Hash)
        raise "You can only instert an Hash"
      else
        #get last id
        last_id = self.data.collect{|x| x["id"]}.compact.max
        # generate hash with id
        hash_to_insert = {"id" => last_id+1}
        hash_to_insert.merge!(args)
        self.data << hash_to_insert
      end
    end

    def update(args)
      where_condition = args[:where]
      values = args[:values]
      value_key = values.keys.first.to_s
      value_value = values.values.first

      current_hashs = self.select(where: where_condition)
      # update hash
      current_hashs.each do |c_h|
        c_h[value_key] = value_value
      end
    end

  end
end
