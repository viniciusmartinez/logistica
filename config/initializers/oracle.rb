#ActiveSupport.on_load(:active_record) do
#  ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.class_eval do
    #self.emulate_integers_by_column_name = true
    #self.emulate_dates_by_column_name = true
    #self.emulate_booleans_from_strings = true

    # to ensure that sequences will start from 1 and without gaps
    # self.default_sequence_start_value = "1 NOCACHE INCREMENT BY 1"

    # other settings ...
#  end
#end

ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.emulate_booleans = false

